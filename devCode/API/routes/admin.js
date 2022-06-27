'use strict';

const express = require('express');
const router = express.Router();

const adminController = require('../controllers/adminController');

router.get('/logout', adminController.logout)

router.get('/list', adminController.adminList)

router.post('/login', adminController.adminLogin);// 임시 DB 로그인


router.post('/loginOracle', adminController.adminLoginOracle);// 학교 DB 로그인 

router.post('/update_level', adminController.adminLevelUpdate);



module.exports = router;
