import { Router } from "express";
import {getCategoryProducts,getSearchProducts,rateProduct,getDealOfTheDay} from "../controllers/product.js";
import auth from "../middlewars/auth.js";

const productRouter = Router();
let domaineName = "/api/products";


productRouter.get(domaineName +  "/getCategoryProducts",auth,getCategoryProducts);
productRouter.get(domaineName +  "/getSearchProducts",auth,getSearchProducts);
productRouter.get(domaineName +  "/get-deal-of-the-day",auth,getDealOfTheDay);
productRouter.post(domaineName+ "/rate-product", auth,rateProduct);



export default productRouter;
