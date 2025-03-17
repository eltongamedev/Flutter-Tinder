enum StepType { text, checkbox, imagePicker, age }

class ProfileStep {
  final String title;
  final String subtitle;
  final StepType type;
  final String? hintText;
  final List<String>? options; // Para checkboxes
  final List<String>? imageOptions; // Para seleção de imagens

  ProfileStep({
    required this.title,
    this.subtitle = "teste",
    required this.type,
    this.hintText,
    this.options,
    this.imageOptions,
  });
}
