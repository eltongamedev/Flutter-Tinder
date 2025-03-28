enum StepType { text, checkbox, imagePicker, age, gender }

class ProfileStep {
  final String title;
  final String subtitle;
  final List<String>? gender;
  final StepType type;
  final String? hintText;
  final List<String>? options; // Para checkboxes
  final List<String>? imageOptions; // Para seleção de imagens

  ProfileStep({
    required this.title,
    this.subtitle = "",
    required this.type,
    this.gender,
    this.hintText,
    this.options,
    this.imageOptions,
  });
}
