import express from "express";
import admin from '../middlewars/admin.js'
import {addProduct,allProducts,deleteProduct } from '../controllers/admin.js'

let adminRoute=express.Router();


let domaineName="/admin";

adminRoute.post(domaineName + "/add-product",admin,addProduct);
adminRoute.get(domaineName + "/all-products",admin,allProducts);
adminRoute.post(domaineName + "/delete-product",admin,deleteProduct);





export default adminRoute ;
