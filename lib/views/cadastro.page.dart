import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';
import '../services/google_auth_service.dart';
import './user_create_profile_view.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xfffd7055), Color(0xfffa2e7b)],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/tinder-logobranca.png",
                      width: 200,
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 100),
                  Text(
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    "Ao tocar em entrar, você concorda com os nossos\nTermos. Saiba como processamos seus dados em\nnossa Política de Privacidade e Política de Cookies.",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  buildButton(
                    "assets/images/google.png",
                    "ENTRAR COM O GOOGLE",
                    () async {
                      await viewModel.login(GoogleAuthService());
                      // Verifica se o login foi bem-sucedido
                      if (viewModel.isLoggedIn) {
                        // Navega para a próxima página
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => UserCreateProfileView(),
                          ),
                        );
                      } else {
                        // Exibe uma mensagem de erro
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro ao fazer login')),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  buildButton(
                    "assets/images/facebook.png",
                    "ENTRAR COM O FACEBOOK",
                    () {}, // Adicione a lógica do Facebook aqui
                  ),
                  SizedBox(height: 20),
                  buildButton(
                    "assets/images/message.png",
                    "ENTRAR COM TELEFONE",
                    () {}, // Adicione a lógica do telefone aqui
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String imagePath, String text, [VoidCallback? onPressed]) {
    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        width: 300,
        height: 50,
        child: TextButton(
          onPressed: onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 20, height: 20),
              SizedBox(width: 30),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Container(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
