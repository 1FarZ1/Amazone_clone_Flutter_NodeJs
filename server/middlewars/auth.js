import jwt from "jsonwebtoken";


const auth = async (req, res, next) => {
    try {
        const token  = req.header("x-auth-token");
        if(!token){
            return res.status(401).json({msg:"No Authentication Token, Authorization Denied"});
        }   ;
        const verified = jwt.verify(token, "passwordKey");
        if(!verified){
            return res.status(401).json({msg:"Token Verification Failed, Authorization Denied"});
        }
        req.user = verified.id;
        req.token = token;
        next();
        
    } catch (error) {
        res.status(400).json({msg:"Error" + error.message});
    }
};

export default auth;