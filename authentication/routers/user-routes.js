
const userRouter = require('express').Router();

const {SchemaValidateMiddleware} = require('../middlewares/schema-validate');
const {signupSchema,loginSchema} = require('../services/joi-services');

const {
    userLogin,

} = require('../controllers/user-controller');

userRouter.post('/login',(req,res,next) =>SchemaValidateMiddleware(req,res,next,loginSchema),userLogin);

module.exports = userRouter;