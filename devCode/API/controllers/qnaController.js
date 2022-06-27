'use strict';

const qnaDAO = require('../models/qnaDAO')

function qnaMain(req, res, next){
    res.render('./qna/qna', { title: 'QnA' });
}

module.exports={
    qnaMain,
}