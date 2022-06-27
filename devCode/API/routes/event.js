'use strict';

const express = require('express');
const router = express.Router();

const eventController = require('../controllers/eventController');

/* APP */
router.get('/', eventController.eventMain); //해당 이벤트
// router.get('/all_event/detail', eventController.eventDetail); //상세 페이지 조회


/* WEB */
router.get('/all_event', eventController.eventAll); //모든 이벤트

router.post('/event_write', eventController.eventWrite);  //이벤트 추가
router.post('/event_update', eventController.eventUpdate);  //이벤트 수정
router.post('/event_enrolled', eventController.eventEnrolled);  //문제 등록 여부 수정
router.post('/event_checked', eventController.eventChecked);  //상품 증정 여부 수정

router.delete('/event_delete', eventController.eventDelete);  //이벤트 삭제


module.exports = router;