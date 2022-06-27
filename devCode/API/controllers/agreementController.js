'use strict';

const agreementDAO = require('../models/agreementDAO');
const authDAO = require('../models/authDAO');
const escapeHtml = require('escape-html');
const entitie = require('html-entities');
const dayjs = require('dayjs')
const jwtmiddle = require('../middleware/jwt')

async function make_agreement(req, res, next){
    let jwt_token = req.cookies.admin;
    let date = new dayjs();
    let datetime = date.format('YYYY-MM-DD HH:mm:ss');
    let {content, version} = req.body;
    let parameters = {
        "date":datetime,
        "agreement_id":version,
        "content":escapeHtml(content),
    }
    try {
        if (jwt_token == undefined) { throw "로그인 정보가 없습니다." }
        const permission = await jwtmiddle.jwtCerti(jwt_token);

        if (permission.LEVEL != 0 && permission.LEVEL != 1) throw "권한이 없습니다."
        
        const agreement_data = await agreementDAO.agreementInsert(parameters);
        const user_agreementUpdate = await authDAO.agreementUpdate(parameters);
        
        res.json({
            "Message" : "성공하였습니다."
        })
    } catch (error) {
        res.status(200).json({
            "Message": "실패하였습니다.",
            "Error_Message": error
        })
    }
}
async function read_agreement(req, res, next){
    try {
        
        const agreement_data = await agreementDAO.agreementRead()
        const html_agreement = entitie.decode(agreement_data[0].content)
        res.json({
            "Message":"성공하였습니다.",
            "Data":{
                "agreement_id" : agreement_data[0].agreement_id,
                "content":html_agreement
            }
        })
    } catch (error) {
        res.status(200).json({
            "Message":"실패하였습니다.",
            "Error_Message": error
        })
    }
}

module.exports={
    make_agreement,
    read_agreement,
}