'use strict'

const db = require('../config/db')
const logger = require('../config/logger')

function push_logSelect(parameters){
    return new Promise(function(resolve, reject){
        let queryData = `SELECT push_id FROM push_log WHERE push_title = ? AND push_content = ? AND push_date = ?`;
        db.query(queryData, [parameters.title, parameters.content,parameters.push_date], function(error, db_data){
            if(error){
                logger.error(
                    "DB error [push_log]" +
                    "\n \t" + queryData +
                    "\n \t" + error);
                reject('DB ERR');
            }
            resolve(db_data[0].push_id)
        })
    })
}
function push_logInsert(parameters){
    return new Promise(function (resolve, reject){
        let queryData = `INSERT INTO push_log (push_title, push_content, push_type, push_date) VALUES (?,?,?,?)`;
        db.query(queryData, [parameters.title,parameters.content,parameters.push_type,parameters.push_date], function (error, db_data){
            if(error){
                logger.error(
                    "DB error [push_log]" +
                    "\n \t" + queryData +
                    "\n \t" + error);
                reject('DB ERR');
            }
            resolve('푸쉬기록 DB 저장완료')
        })
    })
}
function push_userInsert(parameters, user_id){
    return new Promise(function (resolve, reject){
        let queryData = `INSERT INTO push_user (push_id , user_id) VALUES (?,?);`
        db.query(queryData,[parameters.push_id, user_id], function(error, db_data){
            if(error){
                logger.error(
                    "DB error [push_user]" +
                    "\n \t" + queryData +
                    "\n \t" + error);
                reject('DB ERR');
            }
            resolve('DB 입력완료')
        })
    })
}
function selectAllpushuser(parameters){
    return new Promise(function (resolve, reject){
        let queryData = `SELECT push_id FROM push_user WHERE user_id = ? AND is_del = 0`;
        db.query(queryData,[parameters.user_id], function (error, db_data){
            if(error){
                logger.error(
                    "DB error [push_user]" +
                    "\n \t" + queryData +
                    "\n \t" + error);
                reject('DB ERR');
            }
            resolve(db_data)
        })
    })
}
function selectAllpushlog(push_id,parameters){
    return new Promise(function (resolve, reject){
        let queryData = `SELECT pl.push_title, pl.push_content, REPLACE(SUBSTR(pl.push_date,1,10) ,"-",".") AS push_time, pu.user_push_id, pu.readDate
        FROM push_log AS pl 
        JOIN push_user AS pu ON pl.push_id = pu.push_id WHERE pl.push_id = ? AND pu.user_id = ?`;
        // let queryData = `SELECT push_title, push_content, push_date FROM push_log WHERE push_id = ?`;
        db.query(queryData,[push_id, parameters.user_id], function(error, db_data){
            if(error){
                logger.error(
                    "DB error [push_log]" +
                    "\n \t" + queryData +
                    "\n \t" + error);
                reject('DB ERR');
            }
            resolve(db_data)
        })
    })
}
function updatePushUserDate(parameters){
    return new Promise(function (resolve, reject){
        let queryData = `UPDATE push_user SET readDate='${parameters.readDate}', is_read = 1 WHERE is_read = 0 AND user_push_id = ? AND user_id = ?`;
        db.query(queryData, [parameters.user_push_id, parameters.user_id], function (error, db_data){
            if(error){
                logger.error(
                    "DB error [push_user]" +
                    "\n \t" + queryData +
                    "\n \t" + error);
                reject('DB ERR');
            }
            if(db_data.affectedRows == 1) resolve('데이터 입력 완료')
            else resolve('이미 확인하였습니다')
        })
    })
}
function deletePushUser(parameters){
    return new Promise(function (resolve, reject){
        let queryData = `UPDATE push_user SET is_del = 1 WHERE is_del = 0 AND user_push_id = ? AND user_id = ?`;
        db.query(queryData, [parameters.user_push_id, parameters.user_id], function(error, db_data){
            if(error){
                logger.error(
                    "DB error [push_user]" +
                    "\n \t" + queryData +
                    "\n \t" + error);
                reject('DB ERR');
            }
            console.log(queryData)
            if(db_data.affectedRows == 1) resolve('데이터 입력 완료')
            else reject('삭제할 데이터가 없습니다.')
        })
    })
}
module.exports = {
    push_logSelect,
    push_logInsert,
    push_userInsert,
    selectAllpushuser,
    selectAllpushlog,
    updatePushUserDate,
    deletePushUser,
}