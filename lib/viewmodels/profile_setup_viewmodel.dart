import 'package:flutter/material.dart';
import '../models/profile_step.dart';


class ProfileSetupViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentPage = 0;

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
      title: "Qual é o seu gênero?",
      subtitle: "Conte-nos sobre seu gênero",
      type: StepType.gender,
      gender: ["Masculino", "Feminino"],
    ),
    ProfileStep(
      title: "Eu Estou Procurando Por...",
      subtitle: "Conte-nos as suas preferências",
      type: StepType.checkbox,
      options: [
        "Relacionamento Sério",
        "Algo Casual",
        "Não Tenho Certeza",
        "Prefiro Não Dizer",
      ],
    ),
    ProfileStep(
      title: "Escolha seu avatar",
      subtitle: "Selecione uma imagem",
      type: StepType.imagePicker,
      imageOptions: ["avatar1.png", "avatar2.png", "avatar3.png"],
    ),
  ];

  int get currentPage => _currentPage;
  int get totalPages => steps.length;

  void nextPage() {
    if (_currentPage < totalPages - 1) {
      _currentPage++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void prevPage() {
    if (_currentPage > 0) {
      _currentPage--;
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void setPage(int index) {
    _currentPage = index;
    notifyListeners();
  }
}
