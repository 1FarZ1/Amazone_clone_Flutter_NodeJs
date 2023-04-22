import 'dart:io';

import 'package:amazon_clone/core/constant/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/image_picker.dart';
import '../../auth/view/login/widgets/custom_button.dart';
import '../../auth/view/login/widgets/custom_text_field.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  // final AdminServices adminServices = AdminServices();

  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void sellProduct() {
    // if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
    //   adminServices.sellProduct(
    //     context: context,
    //     name: productNameController.text,
    //     description: descriptionController.text,
    //     price: double.parse(priceController.text),
    //     quantity: double.parse(quantityController.text),
    //     category: category,
    //     images: images,
    //   );
    // }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarAddProduct(),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                images.isNotEmpty
                    ? CustomCarousel(images: images)
                    : CustomPicker(
                        selectImages: selectImages,
                      ),
                const SizedBox(height: 30),
                CustomTextField(
                    controller: productNameController,
                    hintText: 'Product Name'),
                const SizedBox(height: 10),
                CustomTextField(
                    controller: descriptionController,
                    hintText: 'Description',
                    maxLines: 7),
                const SizedBox(height: 10),
                CustomTextField(controller: priceController, hintText: 'Price'),
                const SizedBox(height: 10),
                CustomTextField(
                    controller: quantityController, hintText: 'Quantity'),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(text: 'Sell', onTap: sellProduct),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({
    super.key,
    required this.images,
  });

  final List<File> images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images.map(
        (i) {
          return Builder(
            builder: (BuildContext context) => Image.file(
              i,
              fit: BoxFit.cover,
              height: 200,
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}

class CustomAppBarAddProduct extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBarAddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: AppConsts.appBarGradient,
        ),
      ),
      title: const Text(
        'Add Product',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class CustomPicker extends StatelessWidget {
  const CustomPicker({super.key, required this.selectImages});
  final void Function() selectImages;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectImages,
      child: DottedBorder(
        color: AppConsts.secondaryColor,
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        dashPattern: const [10, 4],
        strokeCap: StrokeCap.round,
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.folder_open,
                size: 40,
              ),
              const SizedBox(height: 15),
              Text(
                'Select Product Images',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
