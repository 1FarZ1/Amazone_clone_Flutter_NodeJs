import Product from '../models/productModel.js';

let addProduct = async (req, res) => {
    try {
        const {name,price,description,category,quantity} = req.body;
        if(!name || !price || !description || !category || !quantity){
            return res.status(400).json({msg:"Please fill all the fields"});
        }
        const product = new Product({
            name,
            price,
            description,
            category,
            quantity
        });
        const savedProduct = await product.save();
        res.status(200).json({msg:"Product Added Successfully",product:savedProduct});
    } catch (error) {
        
    }
}




export default addProduct;