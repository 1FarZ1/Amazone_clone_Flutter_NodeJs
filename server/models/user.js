// nimportiw mongoose  we njibo mnha wch ns79
import mongoose from "mongoose";

// hna ncriyiw instance mn shema 
const sh = mongoose.Schema;


// hna ndiro new shema mn shema builder bwch drnalo
const UserSh =new sh({
    name:{
        type:String,
        required:true,
        trim:true,
    },
    email:{
        type:String,
        required:true,
        trim:true,
        validate:{
            validator: (value)  => {
                return String(value)
                .toLowerCase()
                .match(
                  /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
                );
            },
            message: "Please enter a valid email adress",
        }
    }
    ,
    password:{
        type:String,
        required:true,
        trim:true,
    },
    adress:{
        type:String,
        default:'',
    },
    type :{
        type:String,
        default:"user",
    },
    // cart

})
// we hna ndefiniw lmodel ta3na chakl we asm 
const User= mongoose.model("User",UserSh);
export default User;