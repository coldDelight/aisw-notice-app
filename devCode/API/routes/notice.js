'use strict';

const express = require('express');
const router = express.Router();

const noticeController = require('../controllers/noticeController')
const multer = require('../middleware/multer')

/* Admin-WEB Back-End*/
router.get('/all', noticeController.noticeMain)
router.get('/all/detail', noticeController.noticeDetailweb) 
router.get('/all_watch', noticeController.noticeWatch)
router.delete('/delete', noticeController.noticeDelete)

router.get('/write', function(req ,res ,next) {
    res.render('fileupload');
  });
router.post('/write', multer.uploads.array('FILE'), noticeController.noticeWrite)

/* APP Back-End */
router.get('/all_app', noticeController.noticeMainApp)
router.get('/all_app/detail', noticeController.noticeDetailApp)
router.get('/download', noticeController.downloadFile)

// router.post('/fileupload', noticeController.noticeFileupLoad)
module.exports = router;
