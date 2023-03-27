
const productRouter = require('express').Router();

const { getAllProducts,editProduct,addProduct ,getAllCategories,getProductById} 
= require('../controllers/product-controllers');


productRouter.get('/', getAllProducts);
productRouter.put('/editproduct', editProduct);
productRouter.post('/addproduct', addProduct);
productRouter.get('/categories', getAllCategories);
productRouter.get('/:id', getProductById);



module.exports = productRouter;