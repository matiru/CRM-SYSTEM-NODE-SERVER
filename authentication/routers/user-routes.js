
const userRouter = require('express').Router();

const { getAllEmployees,getAllCustomers , addEmployee,updateEmployee,addCustomer,
    addUser, getUserById, updateCustomer} = require('../controllers/users-controllers');


userRouter.get('/employees',getAllEmployees);
userRouter.get('/customers',getAllCustomers);
userRouter.post('/addemployee', addEmployee);
userRouter.post('/addcustomer', addCustomer);
userRouter.put('/editemployee/:id', updateEmployee);
userRouter.put('/editcustomer/:id', updateCustomer);
userRouter.get('/:id', getUserById);
 





module.exports = userRouter;