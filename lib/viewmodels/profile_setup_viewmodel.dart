import 'package:flutter/material.dart';
import '../models/profile_step.dart';

class ProfileSetupViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentPage = 0;

  final List<ProfileStep> steps = [
    ProfileStep(
      title: "Qual é o seu nome?",
      subtitle: "Vamos nos conhecer melhor",
      type: StepType.text,
      hintText: "Digite seu nome",
    ),
    ProfileStep(
      title: "Qual é a sua idade?",
      subtitle: "Queremos saber mais sobre você",
      type: StepType.age,
    ),
    ProfileStep(
      title: "Quais são seus interesses?",
      subtitle: "Escolha pelo menos um",
      type: StepType.checkbox,
      options: ["Música", "Filmes", "Jogos", "Esportes"],
    ),
    ProfileStep(
      title: "Escolha seu avatar",
      subtitle: "Selecione uma imagem",
      type: StepType.imagePicker,
      imageOptions: ["avatar1.png", "avatar2.png", "avatar3.png"],
    ),
  ];

  int get totalPages => steps.length;

  void nextPage() {
    if (currentPage < totalPages - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPage++;
      notifyListeners();
    }
  }

  void prevPage() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPage--;
      notifyListeners();
    }
  }
}
