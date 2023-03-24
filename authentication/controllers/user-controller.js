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
        console.log("first visited")
    
        try {
            const {email,password}= req.body;
            await sql.connect(config);
            
            const user = await sql.query`select * from USERS where email = ${email}`;
            if(user.recordset.length>0){
                const validPassword = await bcrypt.compare(password,user.recordset[0].password);
                if(validPassword){
                    res.json({message:'Login success'});
                }
                else{
                    res.json({message:'Invalid password'});
                }
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
    },

    addEmployee: async (req, res) => {
        const { name, phone_number, email, password, role,gender } = req.body;
        let hash = await bcrypt.hash(password, 8)
        console.log(hash)
        try {
            await pool.connect()
            const data = await pool.request()
                .input('name', name)
                .input('phone_number', phone_number)
                .input('email', email)
                .input('role', role)
                .input('password', hash)
                .input('gender', gender)
                .execute(`AddNewEmployee`)
            console.log(data)
            res.json(data.rowsAffected)
        } catch (error) {
            res.json(error.message)
            console.log(error)
        }
    },
    


    addCustomer: async (req, res) => {
        const { name, phone_number, email, password, role,gender } = req.body;
        let hash = await bcrypt.hash(password, 8)
        console.log(hash)
        try {
            await pool.connect()
            const data = await pool.request()
                .input('name', name)
                .input('phone_number', phone_number)
                .input('email', email)
                .input('role', role)
                .input('password', hash)
                .input('gender', gender)
                .execute(`AddNewCustomer`)
            console.log(data)
            res.json(data.rowsAffected)
        } catch (error) {
            res.json(error.message)
            console.log(error)
        }
    },
    getAllEmployees: async (req, res) => {
        try {
            await pool.connect()
            let data = await pool.request().execute(`GetEmployees`)
            res.json(data.recordset)
        } catch (error) {
            console.log(error)
        }
    },
 
        
}




