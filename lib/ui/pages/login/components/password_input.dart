import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenterWrapper>(context);

    return StreamBuilder<String?>(
      stream: presenter.presenter.passwordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            labelText: 'Senha',
            errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
            icon: Icon(
              Icons.lock,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          obscureText: true,
          onChanged: presenter.presenter.validatePassword,
        );
      },
    );
  }
}
