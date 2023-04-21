import 'package:amazon_clone/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constant/constants.dart';

enum Auth {
  signin,
  signup,
}

final authTypeProvider = StateProvider((ref) {
  return Auth.signin;
});

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    ref.read(authControllerProvider.notifier).register(
          context: context,
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text,
        );
  }

  void signInUser() {
    ref.read(authControllerProvider.notifier).login(
          email: _emailController.text,
          password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _auth = ref.watch(authTypeProvider);
    return Scaffold(
      backgroundColor: AppConsts.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? AppConsts.backgroundColor
                    : AppConsts.greyBackgroundCOlor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: AppConsts.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    ref.read(authTypeProvider.notifier).state = val!;
                  },
                ),
              ),
              (_auth == Auth.signup)
                  ? Container(
                      padding: const EdgeInsets.all(8),
                      color: AppConsts.backgroundColor,
                      child: Form(
                        key: _signInFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Email',
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                            ),
                            const SizedBox(height: 10),
                            CustomButton(
                              text: 'Sign In',
                              onTap: () {
                                if (_signInFormKey.currentState!.validate()) {
                                  signInUser();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(
                      height: 100,
                      color: Colors.red,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  CustomTextField(
      {required TextEditingController controller, required String hintText}) {}

  CustomButton({required String text, required Null Function() onTap}) {}
}
