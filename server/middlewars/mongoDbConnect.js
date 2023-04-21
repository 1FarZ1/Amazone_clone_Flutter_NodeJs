import {connect,set} from 'mongoose';

const dbURI= "mongodb+srv://Farz:mrfares77@cluster0.6zstawu.mongodb.net/?retryWrites=true&w=majority";

set('strictQuery', true);
const connectDb = ()=>{
    connect(dbURI,{useNewUrlParser:true, useUnifiedTopology:true}).then((result)=>console.log("connected to db" +  result)
).catch((err)=>console.log(err));
}

export default connectDb;

