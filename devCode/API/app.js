const createError = require('http-errors');
const express = require('express');
const cors = require('cors')
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
const session = require('express-session');
const helmet = require('helmet')
const bodyParser = require('body-parser');
const multer = require('multer');
const fs = require('fs');


const oracledb = require('oracledb');


const indexRouter = require('./routes/index');
const usersRouter = require('./routes/users');
const dashboardRouter = require('./routes/dashboard');
const noticeRouter = require('./routes/notice');
const pushRouter = require('./routes/push');
const programRouter = require('./routes/program');
const adminRouter = require('./routes/admin');
const qnaRouter = require('./routes/qna');
// const subscribeRouter = require('./routes/subscribe');
const authRouter = require('./routes/auth');
const agreementRouter = require('./routes/agreement');
const mileageRouter = require('./routes/mileage');
const eventRouter = require('./routes/event');

const app = express();

// app.use(cors());
app.use(cors({origin: 'http://localhost:3333', credentials: true}));
// app.use(cors({origin: 'http://127.0.0.1:3000', credentials: true}));


app.use(bodyParser.json({limit:'100mb'}));
app.use(bodyParser.urlencoded({extended: false}));

// app.use(multer());

// app.use(session({
//   secret: process.env.SESSION_SECRET,
//   resave: false,
//   saveUninitialized: true,
// }));

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/notice', noticeRouter);
app.use('/push', pushRouter);
app.use('/admin', adminRouter);
app.use('/qna', qnaRouter);
app.use('/auth', authRouter);
app.use('/agreement', agreementRouter);
app.use('/program', programRouter);
app.use('/mileage', mileageRouter);
app.use('/event', eventRouter);

// app.use('/dashboard', dashboardRouter);
// app.use('/dashboard/subscribe', subscribeRouter);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

app.use(helmet());
app.disable('x-powered-by'); //HELMET으로 X-powerde-by 안보이게 수정

app.use(function (req, res, next) {
  var dir = './public/images';
  if (!fs.existsSync(dir)) fs.mkdirSync(dir);
});

module.exports = app;