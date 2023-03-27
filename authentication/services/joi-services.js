const Joi = require('joi');

const addEmployeeSchema = Joi.object({
    name: Joi.string().required(),
    email: Joi.string().email().required(),
    password: Joi.string().min(6).required(),
    role: Joi.string().required().valid('admin','staff','super Admin'),
    gender : Joi.string().required().valid('male','female').required(),
    phone_number : Joi.number().min(10).required(),
})

const addCustomerSchema = Joi.object({
    name: Joi.string().required(),
    email: Joi.string().email().required(),
    password: Joi.string().min(6).required(),
    role: Joi.string().required().valid('customer'),
    gender : Joi.string().required().valid('male','female').required(),
    phone_number : Joi.number().min(10).required(),
})

const loginSchema = Joi.object({
    email:Joi.string().email().required(),
    password: Joi.string().min(6).required(),

})

const EditEmployeeSchema = Joi.object({
    name: Joi.string().required(),
    password: Joi.string().min(6).required(),
    phone_number : Joi.number().min(10).required(),

})

const EditCustomerSchema = Joi.object({
    name: Joi.string().required(),
    password: Joi.string().min(6).required(),
    phone_number : Joi.number().min(10).required(),
    email: Joi.string().email().required(),

})

module.exports ={ addCustomerSchema,addEmployeeSchema,EditCustomerSchema,EditEmployeeSchema,loginSchema,}