'use strict';

const express = require('express');
const router = express.Router();
const mileageController = require('../controllers/mileageController')

router.get('/all', mileageController.selectProgram)

router.get('/detail', mileageController.detailProgramUser)

router.post('/insert', mileageController.insertMileageUser)

router.get('/all-app', mileageController.selectMileage)

router.get('/mymileage', mileageController.mymileageApp)

router.get('/semester_mileage', mileageController.SemesterMileage)

module.exports = router;
