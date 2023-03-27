const sql = require('mssql');
const { config } = require('../sql-config');

const pool = new sql.ConnectionPool(config);

module.exports ={

getAllSales: async (req , res)=>{
    try{
        await pool.connect();
        let data =  await pool.request().execute('GetSalesInformation');
        res.json(data.recordset);
    }catch(err){
        console.log(err);
    }
   } 
,
makeSale: async (req, res) => {
    try {
      const { payment_method, customer_id, employee_id, products } = req.body;
  
      // Call the MakeSale stored procedure
      const result = await pool
        .request()
        .input('payment_method', sql.VarChar, payment_method)
        .input('customer_id', sql.Char(8), customer_id)
        .input('employee_id', sql.Char(8), employee_id)
        .input('products_json', sql.NVarChar, JSON.stringify(products))
        .execute('MakeSale');
  
      // Send back the ID of the new sale
      res.status(200).json({ saleId: result.output.sale_id });
    } catch (error) {
      console.error(error);
      res.status(500).send('Internal Server Error');
    }
  }
  
}
