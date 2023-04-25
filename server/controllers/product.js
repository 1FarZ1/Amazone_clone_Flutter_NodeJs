import {Product} from '../models/product.js';


let getCategoryProducts = async (req, res) => {
    try {  
        // change it to title

        const category = req.query.category;
        const products = await Product.find({category:category});
        return res.status(200).json({msg:"All Products of category : " + category,products:products});
    } catch (error) {
            return res.status(400).json({msg:"error happend " + error.message});
    }
}
let getSearchProducts = async (req, res) => {
    try {  
        // change it to title

        const searchQuery = req.query.searchQuery;
        const products = await Product.find({name:{$regex:searchQuery,$options:"$i"}});


        return res.status(200).json({msg:"All Products of That Seach Query are  : " + searchQuery,products:products});
    } catch (error) {
            return res.status(400).json({msg:"error happend " + error.message});
    }
}




export {getCategoryProducts,getSearchProducts}