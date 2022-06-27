'use strict';

const eventDAO = require('../models/eventDAO');
const jwtmiddle = require('../middleware/jwt');
const dayjs = require('dayjs');
// const { type } = require('express/lib/response');

async function eventMain(req, res, next) {
    let jwt_token = req.cookies.student;
    // let jwt_token = req.query.jwt_token;
    let parameters = {};
    try {
        if(jwt_token == undefined) {throw "로그인 정보가 없습니다."}
        const permission = await jwtmiddle.jwtCerti(jwt_token);
        // parameters.user_id = permission.STUDENT_ID;
        const event_data = await eventDAO.eventMain();

        console.log(event_data);
        
        res.json({
            "Message": "성공하였습니다.",
            "Data": event_data
        });
    }
    catch (error) {
        res.json({
            "Message": "실패하였습니다.",
            "Error_Message": error
        });
    }
}

async function eventAll(req, res, next) {
    // let jwt_token = req.query.jwt_token;
    let jwt_token = req.cookies.admin;
    try {
        if(jwt_token == undefined)  {throw "로그인 정보가 없습니다."}
        const permission = await jwtmiddle.jwtCerti(jwt_token);
        if (permission.LEVEL != 0 && permission.LEVEL != 1) throw "권한이 없습니다";
        const event_data = await eventDAO.eventAll();

        res.json({
            "Message": "성공하였습니다.",
            "Data": event_data
        });
    }
    catch (error) {
        res.json({
            "Message": "실패하였습니다.",
            "Error_Massage": error
        });
    }
}

/* 이벤트 상세 페이지
async function eventDetail(req, res, next){
    let jwt_token = req.query.jwt_token;
    // let jwt_token = req.cookies.admin;
    try {
        if(jwt_token == undefined)  {throw "로그인 정보가 없습니다."}
        const permission = await jwtmiddle.jwtCerti(jwt_token);
        if(permission.LEVEL != 0 && permission.LEVEL != 1)  throw "권한이 없습니다.";
        const event_detail = await eventDAO.eventDetail();

        res.json({
            "Message" : "성공하였습니다.",
            "Data" : event_detail
        });
    } 
    catch (error) {
        res.json({
            "Message" : "실패하였습니다.",
            "Error_Message" : error
        });
    }
}
*/

async function eventWrite(req, res, next) {
    let {title, url, start_date, end_date, limits, is_enrolled, is_checked } = req.body;
    // let jwt_token = req.query.jwt_token;
    let jwt_token = req.cookies.admin;
    let date = new dayjs();
    let startdate = date.format(start_date, 'YYYY-MM-DD HH:mm:ss');
    let enddate = date.format(end_date, 'YYYY-MM-DD HH:mm:ss');
    let parameters = {
        // "event_id" : event_id,
        "title": title,
        "url": url,
        "start_date": startdate,
        "end_date": enddate,
        "limits": limits,
        "is_enrolled": is_enrolled,
        "is_checked": is_checked
    }
    try{
        if(jwt_token == undefined) {throw "로그인 정보가 없습니다."}
        const permission = await jwtmiddle.jwtCerti(jwt_token);
        if(permission.LEVEL != 0 && permission.LEVEL != 1) throw "권한이 없습니다.";
        
        const event_write = await eventDAO.eventWrite(parameters);

        res.json({
            "Message" : "성공하였습니다."
        });
    }
    catch(error){
        res.json({
            "Message" : "실패하였습니다.",
            "Error_Message" : error
        });
    }
}

async function eventUpdate(req, res, next){
    let {event_id, title, url, start_date, end_date, limits, is_enrolled, is_checked} = req.body;
    // let jwt_token = req.query.jwt_token;
    let jwt_token = req.cookies.admin;
    let date = new dayjs();
    let startdate = date.format(start_date, 'YYYY-MM-DD HH:mm:ss');
    let enddate = date.format(end_date, 'YYYY-MM-DD HH:mm:ss');
    let parameters = {
        "event_id" : event_id,
        "title" : title,
        "url" : url,
        "start_date" : startdate,
        "end_date" : enddate,
        "limits" : limits,
        "is_enrolled" : is_enrolled,
        "is_checked" : is_checked
    }
    console.log(req.body);
    try {
        if(jwt_token == undefined)  {throw "로그인 정보가 없습니다."}
        const permission = await jwtmiddle.jwtCerti(jwt_token);
        if(permission.LEVEL != 0 && permission.LEVEL != 1)  {throw "권한이 없습니다."}

        const event_update = await eventDAO.eventUpdate(parameters);

        res.json({
            "Massage" : "성공하였습니다."
        })
    }
    catch(error) {
        res.json({
            "Message" : "실패하였습니다.",
            "Error_Message" : error
        })
    }
}

async function eventEnrolled(req, res, next){
    let {event_id, is_enrolled} = req.body;
    // let jwt_token = req.query.jwt_token;
    let jwt_token = req.cookies.admin;
    let parameters = {
        "event_id" : event_id,
        "is_enrolled" : is_enrolled
    }
    try {
        if(jwt_token == undefined)  {throw "로그인 정보가 없습니다."}
        const permission = await jwtmiddle.jwtCerti(jwt_token);
        if(permission.LEVEL != 0 && permission.LEVEL != 1)  {throw "권한이 없습니다."}
        
        const event_enrolled = await eventDAO.eventEnrolled(parameters);

        res.json({
            "Message": "성공하였습니다."
        })
    }
    catch(error){
        res.json({
            "Message": "실패하였습니다.",
            "Error_Message": error
        });
    }
}

async function eventChecked(req, res, next){
    let {event_id, is_checked} = req.body;
    // let jwt_token = req.query.jwt_token;
    let jwt_token = req.cookies.admin;
    let parameters = {
        "event_id" : event_id,
        "is_checked" : is_checked
    }
    try{
        if(jwt_token == undefined)  {throw "로그인 정보가 없습니다."}
        const permission = await jwtmiddle.jwtCerti(jwt_token);
        if(permission.LEVEL != 0 && permission.LEVEL != 1)  {throw "권한이 없습니다."}

        const event_checked = await eventDAO.eventChecked(parameters);

        res.json({
            "Message" : "성공하였습니다."
        })
    }
    catch(error){
        res.json({
            "Message": "실패하였습니다.",
            "Error_Message": error
        });
    }
}

async function eventDelete(req, res, next) {
    // let {event_id} = req.body;
    // let jwt_token = req.query.jwt_token;
    let jwt_token = req.cookies.admin;
    console.log(jwt_token);
    let parameters = {"event_id" : req.body.event_id};
    // let parameters = req.query;
    try {
        if(jwt_token == undefined) {throw "로그인 정보가 없습니다."}
        const permission = await jwtmiddle.jwtCerti(jwt_token);
        if(permission.LEVEL != 0 && permission.LEVEL != 1) throw "권한이 없습니다."
        // console.log(parameters.event_id);
        const event_delete = await eventDAO.eventDelete(parameters);

        res.json({
            "Message": "성공하였습니다.",
            "Data" : event_delete
        });
    }
    catch (error) {
        // console.log(error);
        res.json({
            "Message": "실패하였습니다.",
            "Error_Massage": error
        });
    }
}

module.exports = {
    eventAll,
    eventMain,
    eventDelete,
    eventWrite,
    eventUpdate,
    // eventDetail,
    eventEnrolled,
    eventChecked
}