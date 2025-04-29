class ActionModel {
  String text;
  bool enable;
  Function()? onPressed;

  ActionModel({required this.text, this.enable = true, this.onPressed});
}
