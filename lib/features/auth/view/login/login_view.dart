import 'package:amazon_clone/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constant/constants.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/header.dart';
import 'widgets/methode_selection.dart';

enum Auth {
  signin,
  signup,
}

final authTypeProvider = StateProvider<Auth>((ref) {
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
    final auth = ref.watch(authTypeProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppConsts.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Header(auth: auth),
              const SizedBox(height: 30),
              MethodeSelectionSection(auth: auth, ref: ref),
              const SizedBox(height: 50),
              (auth == Auth.signup)
                  ? Form(
                      key: _signUpFormKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _nameController,
                              hintText: 'Name',
                            ),
                            const SizedBox(height: 24),
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Email',
                            ),
                            const SizedBox(height: 24),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                            ),
                            const SizedBox(height: 40),
                            CustomButton(
                              text: 'Sign Up',
                              onTap: () {
                                if (_signUpFormKey.currentState!.validate()) {
                                  clearInputField();
                                  signUpUser();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  : Form(
                      key: _signInFormKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Email',
                            ),
                            const SizedBox(height: 24),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                            ),
                            const SizedBox(height: 40),
                            CustomButton(
                              text: 'Sign In',
                              onTap: () {
                                if (_signInFormKey.currentState!.validate()) {
                                  clearInputField();
                                  signInUser();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  clearInputField() {
    Future.delayed(Duration(seconds: 2), () {
      _emailController.clear();
      _passwordController.clear();
      _nameController.clear();
    });
  }
}
