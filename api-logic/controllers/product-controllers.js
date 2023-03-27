const sql = require('mssql');
const { config } = require('../sql-config');

const pool = new sql.ConnectionPool(config);

module.exports ={
    getProductById: async (req, res) => {
        const { id } = req.params;
        try {
          await pool.connect();
          const result = await pool.request()
            .input('productId', sql.Char(8), id) // <-- use 'productId' as the parameter name
            .execute('GetProductById');
          const product = result.recordset[0];
          if (product) {
            res.json(product);
          } else {
            res.status(404).json({ message: 'Product not found' });
          }
        } catch (err) {
          console.log(err);
          res.status(500).json({ message: 'An error occurred while retrieving the product' });
        }
    }
    ,
      

   getAllProducts: async (req , res)=>{
    try{
        await pool.connect();
        let data =  await pool.request().execute('GetProducts');
        res.json(data.recordset);
    }catch(err){

        console.log(err);
    }
   } 
,

getAllCategories: async (req , res)=>{
    try{
        await pool.connect();
        let data =  await pool.request().execute('GetAllCategories');
        res.json(data.recordset);
    }catch(err){

        console.log(err);
    }
   } 
,
   // Edit product details
   editProduct: async (req, res) => {
    const { productId, quantity, description, name, category, status, price } = req.body;
    try {
      await pool.connect();
      const result = await pool.request()
        .input('productId', sql.Char(8), productId)
        .input('quantity', sql.Int, quantity)
        .input('description', sql.Text, description)
        .input('name', sql.VarChar(255), name)
        .input('category', sql.VarChar(255), category)
        .input('status', sql.VarChar(20), status)
        .input('price', sql.Float, price)
        .execute('UpdateProduct');
      res.json({ message: 'Product updated successfully' });
    } catch (err) {
      console.log(err);
      res.status(500).json({ message: 'An error occurred while updating the product' });
    }
  },
  
  
  // Add a new product
  addProduct: async (req, res) => {
    const { quantity, description, name, category, status, price } = req.body;
    try {
      await pool.connect();
      const result = await pool.request()
        .input('quantity', sql.Int, quantity)
        .input('description', sql.Text, description)
        .input('name', sql.VarChar(255), name)
        .input('category', sql.VarChar(255), category)
        .input('status', sql.VarChar(20), status)
        .input('price', sql.Float, price)
        .execute('AddProduct');
      res.json({ message: 'Product added successfully' });
    } catch (err) {
      console.log(err);
      res.status(500).json({ message: 'An error occurred while adding the product' });
    }
  }
  
}
