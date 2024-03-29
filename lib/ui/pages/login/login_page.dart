// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';

import '../pages.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage({
    super.key,
    required this.presenter,
  });

  @override
  Widget build(BuildContext context) {
    void hideKeyboard() {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream?.listen((isLoading) {
            if (isLoading) {
              showLoading(context: context);
            } else {
              hideLoading(context: context);
            }
          });

          presenter.mainErrorStream?.listen((error) {
            // ignore: unnecessary_null_comparison
            if (error != null) {
              showErrorMessage(context: context, error: error);
            }
          });

          return GestureDetector(
            onTap: hideKeyboard,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LoginHeader(),
                  const Headline1(text: 'Login'),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ChangeNotifierProvider<LoginPresenterWrapper>(
                      // Provider(
                      create: (_) => LoginPresenterWrapper(presenter),
                      child: Form(
                          child: Column(
                        children: [
                          const EmailInput(),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 32),
                            child: PasswordInput(),
                          ),
                          const LoginButton(),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.person),
                            label: const Text('Criar conta'),
                          ),
                        ],
                      )),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoginPresenterWrapper extends ChangeNotifier {
  final LoginPresenter presenter;

  LoginPresenterWrapper(this.presenter);
}
