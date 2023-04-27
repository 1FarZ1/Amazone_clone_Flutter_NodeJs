import express from "express";
import admin from '../middlewars/admin.js'
import {addProduct,allProducts,changeOrderStatus,deleteProduct, getAnalytics, getOrders } from '../controllers/admin.js'

let adminRoute=express.Router();


let domaineName="/admin";

adminRoute.post(domaineName + "/add-product",admin,addProduct);
adminRoute.get(domaineName + "/all-products",admin,allProducts);
adminRoute.post(domaineName + "/delete-product",admin,deleteProduct);
adminRoute.get(domaineName + "/get-orders", admin,getOrders);
adminRoute.post(domaineName + "/change-order-status", admin, changeOrderStatus);
adminRoute.get(domaineName + "/analytics", admin, getAnalytics);




export default adminRoute ;
