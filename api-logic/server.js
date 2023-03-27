
const express = require('express');
const app =  express();

require('dotenv').config()

const productRouter = require('./routers/product-routes');
const salesRouter = require('./routers/sales-routes');

app.use(express.json());
app.use(express.urlencoded({extended: true}));

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE,PATCH');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    next();
});




app.get('/', (req, res) => {
    res.json('crm backend products');
});

app.use('/products', productRouter);
app.use('/sales', salesRouter);

const port = process.env.PORT || 6050;
app.listen(port, () => {
    console.log(`Listening on port ${port}`);
});
