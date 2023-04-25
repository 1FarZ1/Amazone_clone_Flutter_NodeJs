import express from 'express';
import auth from '../middlewars/auth.js'
import {addToCart} from '../controllers/user.js';

const userRouter = express.Router();

let domaineName="/api";

userRouter.post(domaineName+ "/add-to-cart", auth,addToCart);

  
export default userRouter;