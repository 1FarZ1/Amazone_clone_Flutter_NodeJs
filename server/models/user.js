import mongoose, { Schema, model } from "mongoose";

const sh = mongoose.Schema;

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
const User=model("Animes",UserSh);
export default User;