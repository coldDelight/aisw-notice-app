'use strict';

const express = require('express');
const router = express.Router();

const qnaController = require('../controllers/qnaController');

router.get('/', qnaController.qnaMain);

module.exports = router;
