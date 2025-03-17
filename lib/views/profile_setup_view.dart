import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/profile_setup_viewmodel.dart';
import 'profile_step_widget.dart';

class ProfileSetupView extends StatelessWidget {
  const ProfileSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileSetupViewModel(),
      child: Consumer<ProfileSetupViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Column(
              children: [
                _buildProgressIndicator(viewModel),
                _buildPageView(viewModel),
                _buildContinueButton(context, viewModel),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressIndicator(ProfileSetupViewModel viewModel) {
    return Padding(
  padding: const EdgeInsets.all(16.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Centraliza todos os elementos horizontalmente
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Setinha no canto esquerdo
      IconButton(
        icon: const Icon(Icons.arrow_back),  // A setinha para voltar
        onPressed: () {
          if (viewModel.currentPage > 0) {
            viewModel.prevPage();
          }
        },
      ),
      // Barra de progresso centralizada
      Container(
        width: 180,  // Ajuste o tamanho da barra de progresso
        margin: const EdgeInsets.symmetric(horizontal: 50),  // Ajuste o espaço entre a seta e a barra
        child: LinearProgressIndicator(
          value: (viewModel.currentPage + 1) / viewModel.totalPages,
          backgroundColor: const Color(0xffFFE9F1),
          color: const Color(0xffFF5069),
          minHeight: 12,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      Spacer(),
    ],
  ),
);

  }

  Widget _buildPageView(ProfileSetupViewModel viewModel) {
    return Expanded(
      child: PageView.builder(
        controller: viewModel.pageController,
        itemCount: viewModel.totalPages,
        onPageChanged: (index) {
          viewModel.currentPage = index;
          viewModel.notifyListeners();
        },
        itemBuilder: (context, index) {
          return ProfileStepWidget(step: viewModel.steps[index]);
        },
      ),
    );
  }

  Widget _buildContinueButton(
    BuildContext context,
    ProfileSetupViewModel viewModel,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffFF5069),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            // Lógica para navegar para a próxima etapa ou finalizar o cadastro
            if (viewModel.currentPage < viewModel.totalPages - 1) {
              viewModel.pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              // Finalizar o cadastro
              // Navigator.push(...) ou outra ação
            }
          },
          child: const Text(
            "Continue",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
