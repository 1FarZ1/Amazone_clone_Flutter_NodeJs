import User from "../models/user.js";
import bcrypt from "bcryptjs";

// hada howa controller t3 auth li yhdr m3a auth , drnah hna for better architecture 
let  signIn= async (req, res) => {
    const {email , password} = req.body;
    try {
        const  existingUser = User.findOne({email});
        if(!existingUser){
            return res.status(404).json({msg:"User Doesn't Exist"});
        }   
        bcrypt.compare(password, existingUser.password, (err, result) => {
            if (err) {
                return res.status(404).json({ msg: "Error" + err });
            }
            if (!result) {
                return res.status(404).json({ msg: "Password Doesn't Match" });
            }
        })

        return res.status(200).json({
            msg:"User Signed In Successfully",
            user:existingUser
        })


        
    } catch (error) {
            return res.status(404).json({msg : "Error" + error })

    }
    
};

let  signUp= async (req, res) => {
    const {name, email ,password}  =  req.body;
    console.log(req.body);
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


//JWT 