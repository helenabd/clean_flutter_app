import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(image: AssetImage('assets/logo.png')),
            Text('Login'.toUpperCase()),
            Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Email', icon: Icon(Icons.email)),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Senha', icon: Icon(Icons.lock)),
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Entrar'.toUpperCase()),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.person),
                  label: const Text('Criar conta'),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
