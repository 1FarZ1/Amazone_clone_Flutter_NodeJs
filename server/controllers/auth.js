import User from "../models/user.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";


// hada howa controller t3 auth li yhdr m3a auth , drnah hna for better architecture 
let  signIn= async (req, res) => {
    const {email , password} = req.body;
    console.log(req.body);
    try {
        const  existingUser = await User.findOne({email});
        if(!existingUser){
            return res.status(404).json({msg:"User Doesn't Exist"});
        }   
        let isPasswordCorrect = await bcrypt.compare(password, existingUser.password);
        if(!isPasswordCorrect){
                return res.status(404).json({
                    nsg:"Password Inccorect"
                });
        }


        const token = jwt.sign(
            {id: existingUser._id},
            "passwordKey"
        );
        return res.status(200).json({
            msg:"User Signed In Successfully",
            token:token,
            ...existingUser._doc,

        })


        
    } catch (error) {
            return res.status(404).json({msg : "Error" + error })

    }
    
};

let  signUp= async (req, res) => {
    const {name, email ,password}  =  req.body;
    let hashedPass = await  bcrypt.hash(password,8);
  try {
    const  existingUser = await User.findOne({email});
    if(existingUser){
        return res.status(400).json({msg:"User With This Email Already Exists"});   
    }
   let user = new User({
         email,
        password:hashedPass,
         name,
   })
   user = await user.save();
    res.status(200).json({user:user,msg:"User Created Successfully"});

  } catch (error) {
    return res.status(404).json({msg : "Error" + error })
  }
};

let tokenValid = async (req, res) => {
    try {
        const token = req.header("x-auth-token");
        if(!token){
            return res.json(false);
        }
        const verified = jwt.verify(token,"passwordKey");
        if(!verified){
            return res.json(false);
        }
            const user = User.findById(verified.id);
            if(!user){
                return res.json(false);
            }
        }
        catch(e){
            return res.status(404).json({msg:e});
        }
    };



let tempName = async (req, res) => {
        const user = await User.findById(req.user);
        res.json({ ...user._doc, token: req.token });
      }




let  signOut= (req, res) => {
    res.status(200).send("hello world");
};







export { signUp,signIn ,signOut ,tokenValid,tempName};


//JWT 