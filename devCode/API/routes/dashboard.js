'use strict';

const express = require('express');
const router = express.Router();

router.get('/', function (req, res, next) {
  res.render('./dashboard/dashboard', { title: 'Deshboard' });
});

module.exports = router;