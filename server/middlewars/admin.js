import jwt from "jsonwebtoken";
import User from '../models/user.js'


const admin = async (req, res, next) => {
    try {
        const token  = req.header("x-auth-token");
        if(!token){
            return res.status(401).json({msg:"No Authentication Token, Authorization Denied"});
        }   ;
        const verified = jwt.verify(token, "passwordKey");
        if(!verified){
            return res.status(401).json({msg:"Token Verification Failed, Authorization Denied"});
        }
        const user= User.findById(verified.id);
        if(!(user.type ==  "admin")){
            return res.status(401).json({msg:"You are Unauthorized " + error.message})

        }
        else{

        req.user = verified.id;
        req.token = token;
        next();
    }

        
    } catch (error) {
        return res.status(400).json({msg:"Error" + error.message});
    }
};

export default admin;
