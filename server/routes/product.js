import { Router } from "express";
import {getCategoryProducts,getSearchProducts} from "../controllers/product.js";
import auth from "../middlewars/auth.js";

const productRouter = Router();
let domaineName = "/api";


productRouter.get(domaineName +  "/getCategoryProducts",auth,getCategoryProducts);
productRouter.get(domaineName +  "/getSearchProducts",auth,getSearchProducts);


export default productRouter;
