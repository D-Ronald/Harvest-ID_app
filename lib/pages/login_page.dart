import 'package:debug_no_cell/utils/routes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Login form fields
            TextField(
              decoration: InputDecoration(
                iconColor: Color.fromRGBO(27, 94, 32, 1),
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Senha',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(27, 94, 32, 1)),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.00),
            ElevatedButton(
              onPressed: () {
                switch_view_page(context);
              },
              child: Text('Entrar'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green[900], // Altera a cor de fundo para um cinza esverdeado
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // TODO: Implement password recovery logic
              },
              child: Text('Esqueceu sua senha?'),
            ),
            SizedBox(height: 16),
            Text('Ou Entre com'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement login with Google logic
                  },
                  child: Text('Google'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[900], // Altera a cor de fundo para um cinza esverdeado
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}