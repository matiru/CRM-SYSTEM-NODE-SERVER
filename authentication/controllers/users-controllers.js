const sql = require('mssql');
const {config} = require('../sql-config');


const pool = new sql.ConnectionPool(config);

module.exports = {  

    

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
            try {
              const pool = await sql.connect(config);
              await pool.request()
                .input('email', sql.VarChar(255), email)
                .input('role', sql.VarChar(255), role)
                .input('gender', sql.VarChar(255), gender)
                .input('password', sql.VarChar(255), password)
                .input('phone_number', sql.VarChar(255), phone_number)
                .input('name', sql.VarChar(255), name)
                .execute('AddNewEmployee');
              res.status(200).send({ message: 'Employee added successfully.' });
            } catch (error) {
              console.error(error);
              res.status(500).send({ message: 'Error adding employee.' });
            }
          }
          
          
,addCustomer: async (req, res) => {
    const { email, gender, phone_number, name } = req.body;
  
    try {
      const pool = await sql.connect(config);
      await pool.request()
      .input('email', sql.VarChar(255), email)
              
                .input('gender', sql.VarChar(255), gender)
                .input('phone_number', sql.VarChar(255), phone_number)
                .input('name', sql.VarChar(255), name)
        .execute('AddNewCustomer');
  
      res.status(200).send({ message: 'Customer added successfully.' });
    } catch (error) {
      console.error(error);
      res.status(500).send({ message: 'Error adding customer.' });
    }
  }


  
 
  ,  updateCustomer:  async (req, res) => {
    const { id } = req.params;
    const { name, password, phone_number } = req.body;
    try {
      const pool = await sql.connect(config);
      await pool.request()
    
        .input('name', sql.VarChar(255), name)
        .input('password ', sql.VarChar(255), password)
        .input('phone_number', sql.VarChar(255), phone_number)
        .execute('EditCustomer');
      res.status(200).send({ message: 'Customer edited successfully.' });
    } catch (error) {
      console.error(error);
      res.status(500).send({ message: 'Error editing customer.' });
    }
  },
updateEmployee: async (req, res) => {
    const { id } = req.params;
    const { name, password, phone_number, image_link } = req.body;
    try {
      const pool = await sql.connect(config);
      await pool.request()
        .input('name', sql.VarChar(255), name)
        .input('password', sql.VarChar(255), password)
        .input('phone_number', sql.VarChar(255), phone_number)
        .input('image_link', sql.VarChar(255), image_link)
        .execute('EditEmployee');
      res.status(200).send({ message: 'Employee edited successfully.' });
    } catch (error) {
      console.error(error);
      res.status(500).send({ message: 'Error editing employee.' });
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




