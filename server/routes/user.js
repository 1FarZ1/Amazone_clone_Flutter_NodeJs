import express from 'express';
import auth from '../middlewars/auth.js'
import {addToCart,removeFromCart} from '../controllers/user.js';

const userRouter = express.Router();

let domaineName="/api";

userRouter.post(domaineName+ "/add-to-cart", auth,addToCart);
userRouter.delete(domaineName+ "/remove-from-cart", auth,removeFromCart);

  
export default userRouter;