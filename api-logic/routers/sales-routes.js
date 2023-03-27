
const salesRouter = require('express').Router();

const { getAllSales,makeSale} 
= require('../controllers/sales-controllers');


salesRouter.get('/', getAllSales);
salesRouter.post('/makesale',makeSale);



module.exports = salesRouter;