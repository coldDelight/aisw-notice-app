'use strict';

const authDAO = require('../models/authDAO');
const oracleUserDAO = require('../models/oracleUserDAO');
const agreementDAO = require('../models/agreementDAO')
const crypto = require('crypto');
const jwtmiddle = require('../middleware/jwt');
const dayjs = require('dayjs');
const { auth } = require('firebase-admin');

async function logout(req, res, next) {
    let user = req.cookies.student;
    res.clearCookie('student').redirect('/');
}

async function AppPush(req, res, next) {
    let { active, device_token } = req.body;
    let user = req.cookies.student;

    try {
        const permission = await jwtmiddle.jwtCerti(user);
        let parameters = {
            "push_active": active,
            "device_token": device_token,
            "user_id": permission.STUDENT_ID
        }
        let updatePushDeviceToken
        if (parameters.push_active == '동의') updatePushDeviceToken = await authDAO.updatePushDeviceToken(parameters)
        else if (parameters.push_active == '미동의') updatePushDeviceToken = await authDAO.updateNotPushDeviceToken(parameters)

        res.json({
            "Message": "성공하였습니다."
        })
    } catch (error) {
        res.json({
            "Message": "실패하였습니다.",
            "Error_Message": error
        })
    }
}

async function loginP(req, res, next) {
    let parameters = {
        "user_id": req.body.user_id,
        "pwd": crypto.createHash('sha512').update(req.body.pwd).digest('base64')
    }
    try {
        const result = await oracleUserDAO.authLogin(parameters);
        parameters.name = result.NM;
        parameters.phone = result.M_PHONE;
        parameters.department = result.DEPT_NM;
        parameters.addr = result.ADDR;

        if (result.SCHYR != '') parameters.SCHYR = result.SCHYR;
        else parameters.SCHYR = "교직원";

        if (result.SCHYR != '') parameters.GRAD_YN = result.GRAD_YN;
        else parameters.GRAD_YN = "N";

        await authDAO.insertUser(parameters);
        const level = await authDAO.checkLevel(parameters)
        const userData = {
            "STUDENT_ID": parameters.user_id,
            "NM": parameters.name,
            "LEVEL": level,
            "DEPT_NM": parameters.department,
            "SCHYR": parameters.SCHYR,
        }
        const jwtToken = await jwtmiddle.jwtCreateApp(userData);

        res.cookie("student", jwtToken);
        parameters.jwt_token = jwtToken;

        const insertJWT = await authDAO.insertJWT(parameters);
        const accept = await authDAO.checkAccept(parameters);

        res.json({
            "Message": "성공하였습니다.",
            "Data": {
                "user_id": parameters.user_id,
                "name": parameters.name,
                "department": parameters.department,
                "grade": parameters.SCHYR,
                "jwt_token": parameters.jwt_token,
                "accept": accept,
            }
        })
    } catch (error) {
        res.status(200).json({
            "Message": "실패하였습니다.",
            "Error_Message": error,
            "Data": {
                "user_id": "",
                "name": "",
                "department": "",
                "grade": "",
                "jwt_token": "",
                "accept": "",
            },
        })
    }
}

async function loginOracle(req, res, next) {
    let parameters = {
        "user_id": req.body.user_id,
        // "pwd": crypto.createHash('sha512').update(req.body.pwd).digest('base64')
        "pwd": req.body.pwd
    }
    try {
        // const result = await oracleUserDAO.authLoginOracle(parameters);
        const result = await oracleUserDAO.userCheck(parameters);
        if(result){
            if(result.PASS == parameters.pwd){
                parameters.name = result.NM;
                parameters.phone = result.HAND_PHONE;
                parameters.department = result.DEPT_NM;
                if (result.SCHYR != '') parameters.SCHYR = result.SCHYR;
                else parameters.SCHYR = "교직원";
                if (result.SCHYR != '') parameters.GRAD_YN = result.GRAD_YN;
                else parameters.GRAD_YN = "N";
                await authDAO.insertUser(parameters);
                const level = await authDAO.checkLevel(parameters)
                const userData = {
                    "STUDENT_ID": parameters.user_id,
                    "NM": parameters.name,
                    "LEVEL": level,
                    "DEPT_NM": parameters.department,
                    "SCHYR": parameters.SCHYR,
                }
                const jwtToken = await jwtmiddle.jwtCreateApp(userData);
                res.cookie("student", jwtToken);
                parameters.jwt_token = jwtToken;
                const insertJWT = await authDAO.insertJWT(parameters);
                const accept = await authDAO.checkAccept(parameters);
                res.json({
                    "Message": "성공하였습니다.",
                    "type":1,
                    "Data": {
                        "user_id": parameters.user_id,
                        "name": parameters.name,
                        "department": parameters.department,
                        "grade": parameters.SCHYR,
                        "jwt_token": parameters.jwt_token,
                        "accept": accept,
                    }
                })
            }else{//1.학번 잘못침 2. sw개인정보 동의 안함
                res.status(200).json({
                    "Message": "실패하였습니다.",
                    "type":2,
                    "Error_Message": "비밀번호가 틀렸습니다",
                    "Data": {
                        "user_id": "",
                        "name": "",
                        "department": "",
                        "grade": "",
                        "jwt_token": "",
                        "accept": "",
                    },
                })
            }
        }else{
            res.status(200).json({
                "Message": "실패하였습니다.",
                "type":3,
                "Error_Message": "학번 혹은 포털 SW 개인정보 동의를 확인해주세요",
                "Data": {
                    "user_id": "",
                    "name": "",
                    "department": "",
                    "grade": "",
                    "jwt_token": "",
                    "accept": "",
                },
            })
        }
    } catch (error) {
        res.status(200).json({
            "Message": "실패하였습니다.",
            "type":4,
            "Error_Message": error,
            "Data": {
                "user_id": "",
                "name": "",
                "department": "",
                "grade": "",
                "jwt_token": "",
                "accept": "",
            },
        })
    }
}


async function acceptP(req, res, next) {
    let user_id = req.body.user_id;
    let agreement_id = req.body.agreement_id;
    let date = new dayjs();
    let datetime = date.format('YYYY-MM-DD HH:mm:ss');
    if (user_id == undefined) {
        res.json({ "Message": "Parameter ERR." })
        return 0;
    }
    let parameters = {
        "user_id": user_id,
        "agreement_id": agreement_id,
        "checked_date": datetime
    }
    try {
        const accept = await agreementDAO.userAgreementCheck(parameters)

        console.log(accept)

        const acceptUpdate = await authDAO.updateAccept(parameters);
        const accept_data = await agreementDAO.user_agreementInsert(parameters);
        res.json({
            "Message": "성공하였습니다.",
        })
    } catch (error) {
        res.status(200).json({
            "Message": "실패하였습니다.",
            "Error_Message": error
        })
    }
}

module.exports = {
    loginP,
    AppPush,
    logout,
    acceptP,
    loginOracle
}