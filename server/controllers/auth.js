import User from "../models/user.js";
import bcrypt from "bcryptjs";

// hada howa controller t3 auth li yhdr m3a auth , drnah hna for better architecture 
let  signIn= (req, res) => {
    
    res.status(200).send("hello world");
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

let  signOut= (req, res) => {
    res.status(200).send("hello world");
};




export { signUp,signIn ,signOut };