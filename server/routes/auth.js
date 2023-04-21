import { Router } from "express";
const router = Router();
import { signUp, signIn, signOut } from "../controllers/auth.js";


const  domaineName="/api";


router.post( domaineName + "/signout",signOut);
router.post( domaineName + "/signup",signUp);
router.post( domaineName + "/signin",signIn);


export default router;
