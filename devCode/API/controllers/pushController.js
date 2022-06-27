'use strict';

const pushDAO = require('../models/pushDAO')
const authDAO = require('../models/authDAO')
const jwtmiddle = require('../middleware/jwt')
const push = require('../push-message')
const dayjs = require('dayjs')

async function pushMain(req, res, next) {
    let jwt_token = req.cookies.student;
    let parameters = {}
    try {
        if (jwt_token == undefined) { throw "로그인 정보가 없습니다." }
        const permission = await jwtmiddle.jwtCerti(jwt_token);
        parameters.user_id = permission.STUDENT_ID;
        const push_data = await pushDAO.selectAllpushuser(parameters)

        let push_userAll = []
        for (const element of push_data) {
            const data = await pushDAO.selectAllpushlog(element.push_id, parameters)
            push_userAll.push(data[0])
        }
        res.json({
            "Message": "성공하였습니다.",
            "Data": push_userAll
        })
    } catch (error) {
        res.json({ "Message": "실패하였습니다.", "Error_Message": error })
    }
}

async function pushWrite(req, res, next) {
    let jwt_token = req.cookies.admin;
    let { title, content, push_type, target_user_id } = req.body
    let date = new dayjs();
    let datetime = date.format('YYYY-MM-DD HH:mm:ss');
    let parameters = {
        "title": title,
        "content": content,
        "push_type": push_type,
        "push_date": datetime,
    }
    let device_token = []
    try {
        if (jwt_token == undefined) { throw "로그인 정보가 없습니다." }
        const permission = await jwtmiddle.jwtCerti(jwt_token);
        if (permission.LEVEL != 0 && permission.LEVEL != 1) throw "권한이 없습니다."
        parameters.user_id = permission.STUDENT_ID;

        await pushDAO.push_logInsert(parameters)
        const selectpush_log = await pushDAO.push_logSelect(parameters)
        parameters.push_id = selectpush_log;
        await target_user_id.forEach(async function (data) {
            const insertpush_user = pushDAO.push_userInsert(parameters, data);
        })

        for (const element of target_user_id) {
            const data = await authDAO.selectDeviceToken(element)
            device_token.push(data)
        }
        const push_data = await push.sendMessage(device_token, { "title": parameters.title, "content": parameters.content })

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
async function pushRead(req, res, next) {
    let date = new dayjs();
    let datetime = date.format('YYYY-MM-DD HH:mm:ss');
    try {
        let jwt_token = req.cookies.student;
        let parameters = {
            "user_push_id": req.body.user_push_id,
            "readDate": datetime
        }
        if (jwt_token == undefined) { throw "로그인 정보가 없습니다." }
        const permission = await jwtmiddle.jwtCerti(jwt_token);
        parameters.user_id = permission.STUDENT_ID;

        const push_userUpdate = await pushDAO.updatePushUserDate(parameters);
        res.json({
            "Message": "성공하였습니다.",
            "Success_Message": push_userUpdate
        })
    } catch (error) {
        res.json({
            "Message": "실패하였습니다.",
            "Error_Message": error
        })
    }
}

async function pushDelete(req, res, next) {
    try {
        let jwt_token = req.cookies.student;
        let parameters = {
            "user_push_id": req.body.user_push_id
        }
        if (jwt_token == undefined) { throw "로그인 정보가 없습니다." }
        const permission = await jwtmiddle.jwtCerti(jwt_token);
        parameters.user_id = permission.STUDENT_ID;

        const push_userDelete = await pushDAO.deletePushUser(parameters)
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

module.exports = {
    pushMain,
    pushWrite,
    pushRead,
    pushDelete,
}