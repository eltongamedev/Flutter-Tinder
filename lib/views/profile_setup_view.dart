import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/profile_setup_viewmodel.dart';
import 'profile_step_widget.dart';
import '../viewmodels/user_profile/user_name_view_model.dart';

class ProfileSetupView extends StatelessWidget {
  const ProfileSetupView({super.key});

  @override
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider(
  //     create: (_) => ProfileSetupViewModel(),
  //     child: Consumer<ProfileSetupViewModel>(
  //       builder: (context, viewModel, child) {
  //         return Scaffold(
  //           body: Column(
  //             children: [
  //               _buildProgressIndicator(viewModel),
  //               _buildPageView(viewModel),
  //               _buildContinueButton(viewModel),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    // Remove o ChangeNotifierProvider e acesse diretamente
    final viewModel = Provider.of<ProfileSetupViewModel>(context);

    return Scaffold(
      body: Column(
        children: [
          _buildProgressIndicator(viewModel),
          _buildPageView(viewModel),
          _buildContinueButton(viewModel),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(ProfileSetupViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              viewModel.prevPage();
            },
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: LinearProgressIndicator(
                value: (viewModel.currentPage + 1) / viewModel.totalPages,
                backgroundColor: const Color(0xffFFE9F1),
                color: const Color(0xffFF5069),
                minHeight: 12,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
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
          viewModel.setPage(index);
        },
        itemBuilder: (context, index) {
          return ProfileStepWidget(step: viewModel.steps[index]);
        },
      ),
    );
  }

  Widget _buildContinueButton(ProfileSetupViewModel viewModel) {
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
            viewModel.nextPage();
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
