// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LoginHeader(),
            const Headline1(text: 'Login'),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                  child: Column(
                children: [
                  StreamBuilder<String>(
                      stream: presenter.emailErrorStream(),
                      builder: (context, snapshot) {
                        return TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            icon: Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColorLight,
                            ),
                            errorText: snapshot.data,
                            labelStyle: Theme.of(context).textTheme.bodyText2,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: presenter.validateEmail,
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 32),
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        icon: Icon(
                          Icons.lock,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        // labelStyle: ,
                      ),
                      obscureText: true,
                      onChanged: presenter.validatePassword,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    child: Text('Entrar'.toUpperCase()),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person),
                    label: const Text('Criar conta'),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
