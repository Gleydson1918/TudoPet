// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:telainicial/telacadastro.dart';
import 'package:telainicial/teladetransi%C3%A7%C3%A3o.dart';
import 'package:telainicial/usuario.dart';

class telalogin extends StatefulWidget {
  const telalogin({super.key});

  @override
  State<telalogin> createState() => _telaloginState();
}

class _telaloginState extends State<telalogin> {
final formKey = GlobalKey<FormState>();
final emialKey = GlobalKey<FormFieldState>();


TextEditingController textoemailLogin = TextEditingController();
TextEditingController textoPassword = TextEditingController();

String emailLogin = '';
String Password = '';

Future<void> gravarPreferences() async {
  SharedPreferences dadosPref = await SharedPreferences.getInstance();

  dadosPref.setString("emailAddress", textoemailLogin.text);
  dadosPref.setString("Password", textoPassword.text);

  textoemailLogin.clear();
  textoPassword.clear();
}

Future<void> lerpreferences() async {
  SharedPreferences dadosPref = await SharedPreferences.getInstance();

  setState(() {
    emailLogin = dadosPref.getString("name") as String;
    Password = dadosPref.getString("password") as String;
  });
}

   //Usuario user = Usuario();

  @override
  Widget _body() {
    return Container(
      padding: const EdgeInsets.all(60.0),
      child: Form(
        key: formKey,
        child: Column(children: [
          SizedBox(height: 235),
          TextFormField(
            controller: textoemailLogin,
            key: emialKey,
            decoration: InputDecoration(
              labelText: 'E-mail',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5)),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Digite seu E-mail';
              }
              return null;
            },
          ),
          const SizedBox(height: (7)),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5)),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Digite sua senha';
              }
              return null;
            },
          ),
          const SizedBox(height: (7)),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 235, 182, 23))),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).push(PageTransition(child:telatransicao(), type:PageTransitionType.rightToLeft, duration: Duration(milliseconds: 700)));           
              ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Realizando Login')),);
              }
            },
            child: const Text(
              'Entrar',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 52, 52, 53),
                  fontSize: 15),
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(PageTransition(child:telacadastro(), type:PageTransitionType.leftToRight, duration: Duration(milliseconds: 400)));
                  },
                  child: const Text(
                    'Novo Usuário',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 52, 52, 53),
                        fontSize: 15),
                  )),
              TextButton(
                  onPressed: () {
                    emialKey.currentState?.validate();
                    showDialog(
                        context: (context),
                        builder: (context) => AlertDialog(
                          titleTextStyle: TextStyle(
                            color: Colors.black,
                          ),
                              title: Text(
                                  "Digite o seu email, para recuperar a senha."),
                              content: TextField(
                                controller: textoemailLogin,
                              ),
                              actions: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStatePropertyAll(Colors.black),
                                    backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 233, 200, 100))
                                  ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Enviar senha")),
                              ],
                            ));
                  },
                  child: const Text(
                    'Esqueceu a senha',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 52, 52, 53),
                        fontSize: 15),
                  )),
            ],
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // Usuario user = Usuario();
print('teste');
    //user = ModalRoute.of(context)!.settings.arguments as Usuario;
    

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:
                Image.asset("assets/imagens/tudopetlogin.png", fit: BoxFit.cover),
          ),
          _body(),
        ],
      ),
    );
  }
}
