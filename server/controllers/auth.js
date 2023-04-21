
let  signIn= (req, res) => {
    
    res.status(200).send("hello world");
};

let  signUp= (req, res) => {
    const {name, email ,password}  =  req.body;
    
};

let  signOut= (req, res) => {
    res.status(200).send("hello world");
};


export { signUp,signIn ,signOut };