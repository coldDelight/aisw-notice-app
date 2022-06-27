const express = require('express');
const router = express.Router();

const programController = require('../controllers/programController');

router.get('/all_program', programController.programAll)
router.get('/app_program', programController.programAllApp)
router.get('/myprogram', programController.myprogramAll);

router.delete('/delete_program', programController.deleteProgram)
router.delete('/delete_user_program', programController.deleteUserProgram)

router.post('/write',programController.programWrite);
router.post('/user_answer', programController.programUserAnswer);

module.exports = router;
