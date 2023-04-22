import express from "express";
import admin from '../middlewars/admin.js'
import {addProduct} from '../controllers/admin.js'

adminRoute=express.Router();


let domaineName="/admin";

adminRoute.post( domaineName + "/add-product",admin,addProduct);
