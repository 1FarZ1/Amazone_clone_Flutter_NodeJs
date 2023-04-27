import { Router } from "express";
import { signUp, signIn,tokenValid,getUser } from "../controllers/auth.js";
import auth from "../middlewars/auth.js";


const  domaineName="/api";


const router = Router();
// hada howa router ,  app thdr m3ah we howa yhdr m3a controller 
// router.post( domaineName + "/signout",signOut);
router.post( domaineName + "/signup",signUp);
router.post( domaineName + "/tokenIsValid",tokenValid);
router.post( domaineName + "/signin",signIn);

router.get("/", auth,getUser);


export default router;
