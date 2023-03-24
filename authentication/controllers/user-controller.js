const sql = require('mssql');
const Joi = require('joi');
const bcrypt = require('bcrypt');

const {config} = require('../sql-config');
const createValidator = require('../services/validator');
const validateSchema = require ('../services/joi-services');
const{json} = require('express');

const pool = new sql.ConnectionPool(config);

const loginSchema = Joi.object({
    email:Joi.string().email().required(),
    password:Joi.string().min(6).required() 
})

module.exports = {  
    userLogin: async(req,res)=>{
        const validateLogin = createValidator(loginSchema);
    
        try {
            const {email,password}= req.body;
            awaitsql.connect(config);
            await sql.query`select * from USERS where email = ${email}`;
            const user = await sql.query`select * from USERS where email = ${email}`;
            if(user.recordset.length>0){
                const validPassword = await bcrypt.compare(password,user.recordset[0].password);
                if(!validPassword){
                    res.json({message:'Invalid password'});
                }
                res.json({message:'Login success'});
            }else{
                res.json({message:'User not found'});   
            }
        } catch (error) {
            console.log(error);
            return res.status(400).json({
                error:"Something went wrong",
                message:error.message,
            })

        }
    }
}