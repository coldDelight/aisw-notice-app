'use strict';

const express = require('express');
const router = express.Router();

const pushController = require('../controllers/pushController')

router.get('/', pushController.pushMain)

router.post('/write', pushController.pushWrite)

router.put('/read', pushController.pushRead)

router.put('/delete', pushController.pushDelete)

module.exports = router;
