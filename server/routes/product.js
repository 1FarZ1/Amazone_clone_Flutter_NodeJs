import { Router } from "express";
import {getCategoryProducts} from "../controllers/product.js";
import auth from "../middlewars/auth.js";

const productRouter = Router();
let domaineName = "/api"
productRouter.get(domaineName +  "/getCategoryProducts",auth,getCategoryProducts);


export default productRouter;
