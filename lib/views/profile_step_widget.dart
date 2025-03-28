import 'package:flutter/material.dart';
import '../models/profile_step.dart';
import 'package:google_fonts/google_fonts.dart';
import '../viewmodels/user_profile/user_name_view_model.dart';
import 'package:provider/provider.dart';


class ProfileStepWidget extends StatefulWidget {
  final ProfileStep step;

  const ProfileStepWidget({super.key, required this.step});

  @override
  ProfileStepWidgetState createState() => ProfileStepWidgetState();
  
}

class ProfileStepWidgetState extends State<ProfileStepWidget> {
  List<String> selectedOptions = [];
  String? selectedImage;
  int _currentAge = 18; // Idade inicial para o carrossel
  final PageController _pageController = PageController(viewportFraction: 0.3);
  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  
  

  @override
  Widget build(BuildContext context) {
    // Lista de idades (de 18 a 100)
    final List<int> idades = List.generate(
      83,
      (index) => index + 18,
    ); // 83 itens (18 a 100)

    final viewModel = Provider.of<UserNameViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Título
          Text(
            widget.step.title,
            style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),

          // Subtítulo
          Text(
            widget.step.subtitle,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),

          // Renderiza dinamicamente o campo correto
          if (widget.step.type == StepType.text)
            TextField(
              controller: viewModel.nameController,
              decoration: InputDecoration(
                hintText: widget.step.hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  // Quando o campo está focado
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Color(0xffFF5069)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Color(0xffFF5069)),
                ),
              ),
              onChanged: (value) {
                viewModel.setUserName(value);
              },
            ),

          if (widget.step.type == StepType.age)
            Column(
              children: [
                // Carrossel de idades (vertical)
                SizedBox(
                  height: 300, // Altura do carrossel
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical, // Rolagem vertical
                    onPageChanged: (index) {
                      setState(() {
                        _currentAge =
                            idades[index]; // Atualiza a idade selecionada
                      });
                    },
                    itemCount: idades.length,
                    itemBuilder: (context, index) {
                      final bool isSelected =
                          index ==
                          _currentAge -
                              18; // Verifica se o item está selecionado
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 150,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? Color(0xffFF5069) : Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: Color(0xffFF5069),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            idades[index].toString(),
                            style: TextStyle(
                              fontSize: isSelected ? 40 : 30,
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

          if (widget.step.type == StepType.gender)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMaleSelected = !isMaleSelected;
                        if (isMaleSelected) isFemaleSelected = false;
                      });
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor:
                          isMaleSelected
                              ? Color(0xffFF5069)
                              : Colors.grey.shade300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.male,
                            size: 50,
                            color: isMaleSelected ? Colors.white : Colors.black,
                          ),
                          Text(
                            "Masculino",
                            style: TextStyle(
                              color:
                                  isMaleSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFemaleSelected = !isFemaleSelected;
                        if (isFemaleSelected) isMaleSelected = false;
                      });
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor:
                          isFemaleSelected
                              ? Color(0xffFF5069)
                              : Colors.grey.shade300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.female,
                            size: 50,
                            color:
                                isFemaleSelected ? Colors.white : Colors.black,
                          ),
                          Text(
                            "Feminino",
                            style: TextStyle(
                              color:
                                  isFemaleSelected
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          if (widget.step.type == StepType.checkbox)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  widget.step.options!.map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ), // Espaçamento entre os botões
                      child: SizedBox(
                        width: 200, // Largura fixa para todos os botões
                        height: 50, // Altura fixa para manter a consistência
                        child: ChoiceChip(
                          label: Text(option),
                          selected: selectedOptions.contains(option),
                          onSelected: (bool selected) {
                            setState(() {
                              selectedOptions
                                  .clear(); // Garante que apenas uma opção seja selecionada
                              if (selected) {
                                selectedOptions.add(option);
                              }
                            });
                          },
                          selectedColor: const Color(
                            0xffFF5069,
                          ), // Cor do botão selecionado
                          backgroundColor:
                              Colors.grey[200], // Cor do botão não selecionado
                          labelStyle: TextStyle(
                            color:
                                selectedOptions.contains(option)
                                    ? Colors.white
                                    : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ), // Ajuste do tamanho interno do botão
                        ),
                      ),
                    );
                  }).toList(),
            ),

          if (widget.step.type == StepType.imagePicker)
            Wrap(
              spacing: 10,
              children:
                  widget.step.imageOptions!.map((image) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImage = image;
                        });
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                selectedImage == image
                                    ? Colors.blue
                                    : Colors.grey,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          image,
                        ), // Supondo que as imagens estão na pasta assets
                      ),
                    );
                  }).toList(),
            ),
        ],
      ),
    );
  }
}
