import express from 'express';
import auth from '../middlewars/auth.js'
import {addToCart,removeFromCart,saveUserAdress,placeOrder, allOrders} from '../controllers/user.js';

const userRouter = express.Router();

let domaineName="/api";

userRouter.post(domaineName   + "/add-to-cart", auth,addToCart);
userRouter.delete(domaineName + "/remove-from-cart", auth,removeFromCart);
userRouter.post(domaineName   + "/save-user-adress", auth,saveUserAdress);
userRouter.post(domaineName   +   "/order",auth,placeOrder);
userRouter.get(domaineName    +  "/orders/me", auth, allOrders);
  
export default userRouter;