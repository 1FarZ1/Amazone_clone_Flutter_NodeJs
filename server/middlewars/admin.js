import jwt from "jsonwebtoken";
import User from '../models/user.js'


const admin = async (req, res, next) => {
    try {
        console.log("admin path  trigged");
        const token  = req.header("x-auth-token");
        if(!token){
            console.log("go out");
            return res.status(401).json({msg:"No Authentication Token, Authorization Denied"});
        };

        console.log("token good");
        const verified = jwt.verify(token, "passwordKey");
        if(!verified){
            return res.status(401).json({msg:"Token Verification Failed, Authorization Denied"});
        }
        console.log("verified good");
        const user= User.findById(verified.id);

        if(user.type ==  "seller" ||user.type == "user"  ){
            return res.status(401).json({msg:"You are Unauthorized " + error.message})
        }
        console.log("admin good");
        
        req.user = verified.id;
        req.token = token;
        next();

 
    } catch (error) {
        return res.status(400).json({msg:"Error ; " + error.message});
    }
};

export default admin;

