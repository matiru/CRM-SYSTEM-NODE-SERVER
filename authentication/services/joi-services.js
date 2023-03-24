const Joi = require('joi');

const loginSchema = Joi.object({
email:Joi.string().email().required(),
password:Joi.string().min(6).required()

})



const signUpSchema = Joi.object({
    name: Joi.string()
        .required(),

    email: Joi.string()
        .email({ minDomainSegments: 2, tlds: ['*'] })
        .required(),

    phonenuber: Joi.number()
        .min(9)
        .max(12)
        .required(),

    gender:Joi.string()
     .required(),

    password: Joi.string()
        .pattern(new RegExp('^[a-zA-Z1-9]{5,30}'))
        .required(),

    
}).with('password');

module.exports = {loginSchema,signUpSchema}

