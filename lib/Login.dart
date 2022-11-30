import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerUser = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  TextEditingController _controllerConfPass = TextEditingController();
  var largura;

Future<void> primeiroAcesso() async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirme suas credenciais"),
          content: Container(
            width: largura,
            height: 180,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(bottom: 16),
                  child: TextField(
                    controller: _controllerUser,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                        hintText: "Usuário",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6))),
                  ),),
                Padding(padding: EdgeInsets.only(bottom: 6),
                child: TextField(
                  controller: _controllerPass,
                  autofocus: true,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      hintText: "Senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                ),),
                TextField(
                  controller: _controllerConfPass,
                  autofocus: true,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      hintText: "Confirmar Senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                ),
              ],
            ),
          ),
          actions: [
            Row(children: [
              ElevatedButton(onPressed: (){}, child: const Text("Confirmar"))
            ],)
          ],
        );
      }
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/backgroundLogin.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8), BlendMode.softLight)),
      ),
      padding: EdgeInsets.all(32),
      child: Center(
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraint) {
              var width = constraint.maxWidth;
              if(width < 600){
                largura = 400;
              }else if (width < 1000) {
                largura = 600;
              }else {
                largura = width / 3;
              }
              return Container(
                width: largura,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 48),
                      child: Image.asset(
                        "images/logo.png",
                        width: 150,
                        height: 150,
                        color: Colors.white.withOpacity(1), colorBlendMode: BlendMode.modulate,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 8),
                    child: TextField(
                      controller: _controllerUser,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                          hintText: "Usuário",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6))),
                    ),),
                    TextField(
                      controller: _controllerPass,
                      autofocus: true,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                          hintText: "Senha",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6))),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Entrar"),
                        )),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Primeiro Acesso? ",
                          style: TextStyle(
                            color: Colors.white60,
                          ),),
                          TextButton(onPressed: () {
                            primeiroAcesso();
                          },
                              child: Text("Clique Aqui",
                                style: TextStyle(
                                  color: Colors.blueAccent,),),),

                        ],
                      ),),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ));
  }
}
