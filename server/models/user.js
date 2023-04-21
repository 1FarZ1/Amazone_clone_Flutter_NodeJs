import { Schema, model } from "mongoose";



const sh = Schema;

const AnimeSh =new sh({
    title:{
        type:String,
        required:true,
    },
    story:{
        type:String,
        required:true,
    }
    ,
    image:{
        type:String,
        required:true,
    }
    ,
    rating:{
        type:Number,
        required:true,
    },
})
const Anime=model("Animes",AnimeSh);
// export defaultAnime;