import 'package:firebase_auth/firebase_auth.dart';  // Firebase Auth pra autenticação
import 'package:google_sign_in/google_sign_in.dart';  // Google SignIn pra integração com Google
import '../models/user_model.dart';  // Modelo do usuário que vai armazenar os dados do usuário logado
import 'auth_service.dart';  // Interface que estamos implementando (AuthServiceInterface)

/// Serviço de autenticação do Google
class GoogleAuthService implements AuthServiceInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;  // Aqui a gente cria uma instância do Firebase Auth pra fazer a autenticação com o Google.

  @override
  Future<UserModel?> signIn() async {  // O método signIn vai tentar fazer o login com o Google.
    try {
      // O GoogleSignIn().signIn() abre a janela do Google pra o usuário logar
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Se o usuário não fez login ou cancelou, retorna null.
      if (googleUser == null) return null;

      // Aqui pegamos as credenciais de autenticação do Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Criamos um "credential" usando essas credenciais pra autenticar o usuário no Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Agora que temos o "credential", usamos ele pra logar no Firebase com _auth.signInWithCredential()
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Se der certo, criamos um UserModel com os dados do usuário que acabou de logar
      return UserModel.fromFirebase(userCredential.user!);
    } catch (e) {
      // Se der algum erro durante o login, ele vai cair aqui e mostrar um erro no console
      print("Erro ao fazer login com Google: $e");
      return null;  // E retorna null caso tenha erro
    }
  }
}
