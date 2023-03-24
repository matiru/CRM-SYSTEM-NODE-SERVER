
const userRouter = require('express').Router();

const {SchemaValidateMiddleware} = require('../middlewares/schema-validate');
const {signupSchema,loginSchema} = require('../services/joi-services');

const {
    userLogin,

} = require('../controllers/user-controller');

userRouter.post('/login',(req,res,next) =>SchemaValidateMiddleware(req,res,next,loginSchema),userLogin);
userRouter.post('/signup',(req,res,next) =>SchemaValidateMiddleware(req,res,next,signupSchema),userSignup);
userRouter.get('/getAllCustomers',getAllCustomers);


module.exports = userRouter;