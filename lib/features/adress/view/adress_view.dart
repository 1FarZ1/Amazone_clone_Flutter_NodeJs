import 'package:amazon_clone/core/common/loader.dart';
import 'package:amazon_clone/core/constant/constants.dart';
import 'package:amazon_clone/core/providers/user_provider.dart';
import 'package:amazon_clone/features/adress/controller/adress_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pay/pay.dart';

import '../../../core/utils/custom_snack_bar.dart';
import '../../auth/view/login/widgets/custom_text_field.dart';

class AdressView extends ConsumerStatefulWidget {
  final String totalAmount;
  const AdressView({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  ConsumerState<AdressView> createState() => _AdressViewState();
}

class _AdressViewState extends ConsumerState<AdressView> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onApplePayResult(res) {
    if (ref.watch(userStateProvider).address.isEmpty) {
      ref
          .read(addressControllerProvider.notifier)
          .saveUserAddress(adress: addressToBeUsed);
    }
    // addressServices.placeOrder(
    //   context: context,
    //   address: addressToBeUsed,
    //   totalSum: double.parse(widget.totalAmount),
    // );
  }

  void onGooglePayResult(res) {
    if (ref.watch(userStateProvider).address.isEmpty) {
      ref
          .read(addressControllerProvider.notifier)
          .saveUserAddress(adress: addressToBeUsed);
    }
    // addressServices.placeOrder(
    //   context: context,
    //   address: addressToBeUsed,
    //   totalSum: double.parse(widget.totalAmount),
    // );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  final Future<PaymentConfiguration> _googlePayConfigFuture =
      PaymentConfiguration.fromAsset('gpay.json');
  final Future<PaymentConfiguration> _applePayConfigure =
      PaymentConfiguration.fromAsset('applepay.json');

  @override
  Widget build(BuildContext context) {
    var address = ref.watch(userStateProvider).address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppConsts.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: cityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              FutureBuilder(
                  future: _applePayConfigure,
                  builder: (_, snapshot) {
                    return snapshot.hasData
                        ? ApplePayButton(
                            width: double.infinity,
                            style: ApplePayButtonStyle.automatic,
                            type: ApplePayButtonType.buy,
                            paymentConfiguration: snapshot.data!,
                            onPaymentResult: onApplePayResult,
                            paymentItems: paymentItems,
                            margin: const EdgeInsets.only(top: 15),
                            height: 50,
                            onPressed: () => payPressed(address),
                            loadingIndicator: const Loader(),
                          )
                        : const Text("try");
                  }),
              const SizedBox(height: 10),
              FutureBuilder(
                  future: _googlePayConfigFuture,
                  builder: (_, snapshot) {
                    return snapshot.hasData
                        ? GooglePayButton(
                            onPressed: () => payPressed(address),
                            paymentConfiguration: snapshot.data!,
                            onPaymentResult: onGooglePayResult,
                            paymentItems: paymentItems,
                            height: 50,
                            type: GooglePayButtonType.buy,
                            margin: const EdgeInsets.only(top: 15),
                            loadingIndicator: const Loader(),
                          )
                        : const Text("try");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
