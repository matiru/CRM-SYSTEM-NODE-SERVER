
const userRouter = require('express').Router();


const { addCustomerSchema,addEmployeeSchema,EditCustomerSchema,EditEmployeeSchema,loginSchema,} = require('../services/joi-services')
const { validateJwtTokenUsers } = require('../middlewares/authenticate-middleware')
const { SchemaValidateMiddleware } = require('../middlewares/schema-validate')
const { getAllEmployees,getAllCustomers , addEmployee,updateEmployee,addCustomer,login,
   getUserById, updateCustomer} = require('../controllers/users-controllers');

userRouter.post('/login',(req, res, next) => {SchemaValidateMiddleware(req, res, next, loginSchema)},login);
userRouter.get('/employees',validateJwtTokenUsers,getAllEmployees);
userRouter.get('/customers',validateJwtTokenUsers,getAllCustomers);
userRouter.post('/addemployee', validateJwtTokenUsers,(req, res, next) => {SchemaValidateMiddleware(req, res, next,addEmployeeSchema)},addEmployee);
userRouter.post('/addcustomer', validateJwtTokenUsers,(req, res, next) => {SchemaValidateMiddleware(req, res, next, addCustomerSchema)},addCustomer);
userRouter.put('/editemployee/:id',validateJwtTokenUsers, (req, res, next) => {SchemaValidateMiddleware(req, res, next, EditEmployeeSchema)},updateEmployee);
userRouter.put('/editcustomer/:id',validateJwtTokenUsers, (req, res, next) => {SchemaValidateMiddleware(req, res, next, EditCustomerSchema)},updateCustomer);
userRouter.get('/:id',validateJwtTokenUsers, getUserById);
 





module.exports = userRouter;