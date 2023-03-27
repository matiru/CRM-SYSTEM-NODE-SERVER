const sql = require('mssql');
const {config} = require('../sql-config');
const bcrypt = require ('bcrypt');
const { createToken } = require('../services/jwt-token.js');

const pool = new sql.ConnectionPool(config);

module.exports = {  

    
  login: async (req, res) => {
    const { email, password } = req.body;
    try {
        await pool.connect()
        let data = await pool.request()
            .input('email', email)
            .execute(`get_single_users`)
        if (data.recordset.length) {
            let user = data.recordset[0]
            let dbPass = data.recordset[0].password
            let result = await bcrypt.compare(password, dbPass)
            let token = createToken({ email })
            result ? res.json({ response: "Login successful", user, token }) : res.json({ response: "Check your credentials" })
        } else {
            res.status(400).json({ message: 'User not found!' })
        }
    } catch (error) {
        res.status(500).json(error.message)
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
       
    getAllCustomers: async (req, res) => {
        try {
            await pool.connect()
            let data = await pool.request().execute(`GetCustomers`)
            res.json(data.recordset)
        } catch (error) {
            console.log(error)
        }}

        ,
        addEmployee: async (req, res) => {
            const { email, role, gender, password, phone_number, name } = req.body;
            let hash = await bcrypt.hash(password,8)
            try {
              await  pool.connect()
              const data = await pool.request()
                .input('email', email)
                .input('role', role)
                .input('gender', gender)
                .input('password', hash)
                .input('phone_number', phone_number)
                .input('name', name)
                .execute('AddNewEmployee');
                data.rowsAffected > 1 && res.status(200).json({ message: "Employee created succesfully" })
        } catch (error) {
            if (error.message.includes('Violation of UNIQUE KEY constraint')) {
                res.json({ message: "User already exists" })
            } else {
                res.status(400).json(error.originalError['info'].message)
            }
        }
    }
          
          
,addCustomer: async (req, res) => {
    const { email, gender, phone_number, name } = req.body;
    try {
      await  pool.connect()
      const data = await pool.request()
      .input('email', email)           
      .input('gender', gender)
      .input('phone_number', phone_number)
      .input('name', name)
.execute('AddNewCustomer');
        data.rowsAffected > 1 && res.status(200).json({ message: "Customer created succesfully" })
} catch (error) {
    if (error.message.includes('Violation of UNIQUE KEY constraint')) {
        res.json({ message: "User already exists" })
    } else {
        res.status(400).json(error.originalError['info'].message)
    }
}
  
  }


  
 
  ,  updateCustomer:  async (req, res) => {
    let { id, name, email, phone_number } = req.body
    try {
        await pool.connect()
        let data = await pool.request()
            .input('customer_id', id)
            .input('name', name)
            .input('email', email)
            .input('phone_number', phone_number)
            .execute(`UpdateCustomer`)
        console.log(data)
        data.rowsAffected.length > 0 ? res.status(200).json({ message: "Customer details updated successfully" }) : res.status(400).json({ message: "Request not completed try again later" })
    } catch (error) {
        res.status(400).json(error.originalError['info'].message)
    }
},
updateEmployee: async (req, res) => {
  const { id, name, phone_number,image_link} = req.body
  try {
      await pool.connect()
      let data = await pool.request()
          .input('user_id', id)
          .input('name', name)
          .input('phone_number', phone_number)
          .input('image_link',image_link)
          .execute(`UpdateEmployee`)
      data.rowsAffected.length > 0 ? res.status(200).json({ message: "User details updated successfully" }) : res.status(500).json({ message: "Request not completed try again later" })
  } catch (error) {
      res.status(400).json(error.originalError['info'].message)
  }
}

 ,
  
  getUserById: async (req, res) => {
    const { id } = req.params;
    try {
      await pool.connect();
      const result = await pool.request()
        .input('userId', sql.Char(8), id) // <-- use 'productId' as the parameter name
        .execute('GetUserById');
      const user = result.recordset[0];
      if (user) {
        res.json(user);
      } else {
        res.status(404).json({ message: 'user not found' });
      }
    } catch (err) {
      console.log(err);
      res.status(500).json({ message: 'An error occurred while retrieving the user' });
    }
}
,

        
}




