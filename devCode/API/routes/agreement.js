'use strict';

const express = require('express');
const router = express.Router();

const agreementController = require('../controllers/agreementController');

router.get('/write', function(req, res, next) {
    res.render('agreement', { title: 'agreement' });
  });

router.get('/read_one', agreementController.read_agreement);

router.post('/write', agreementController.make_agreement);

module.exports = router;
