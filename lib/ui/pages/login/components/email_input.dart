import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clean_flutter_app/ui/pages/pages.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context, listen: false);
    return StreamBuilder<String?>(
        stream: presenter.emailErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              icon: Icon(
                Icons.email,
                color: Theme.of(context).primaryColorLight,
              ),
              errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
              labelStyle: Theme.of(context).textTheme.bodyMedium,
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: presenter.validateEmail,
          );
        });
  }
}
