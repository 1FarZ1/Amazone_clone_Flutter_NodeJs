import { Router } from "express";
import { signUp, signIn, signOut } from "../controllers/auth.js";


const  domaineName="/api";


const router = Router();
// hada howa router ,  app thdr m3ah we howa yhdr m3a controller 
router.post( domaineName + "/signout",signOut);
router.post( domaineName + "/signup",signUp);
router.post( domaineName + "/signin",signIn);


export default router;
