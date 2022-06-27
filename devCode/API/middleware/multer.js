var multer = require('multer'); // 1

const storageNotice = multer.diskStorage({ // 2
    destination(req, file, cb) {
        cb(null, 'public/upload');
    },
    filename(req, file, cb) {
        cb(null, `${file.originalname}`);
    },
});

const uploads = multer({ storage: storageNotice });

module.exports = {
    uploads,
}