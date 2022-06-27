'use strict';

const express = require('express');
const router = express.Router();

const authController = require('../controllers/authController');

// router.get('/login', authController.login);
router.get('/logout',authController.logout)

router.put('/push-message',authController.AppPush)

router.post('/login',authController.loginP)//학교DB 아닌 임시 DB로 로그인

router.post('/loginOracle',authController.loginOracle)//학교 oracleDB연동한 로그인 (237서버에서만 접근가능)

router.post('/check_accept', authController.acceptP)

module.exports = router;
