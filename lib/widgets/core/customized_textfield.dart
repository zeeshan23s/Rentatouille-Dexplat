import '../../exports.dart';

class CustomizedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String labelText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool readOnly;
  const CustomizedTextField(
      {super.key,
      required this.controller,
      this.validator,
      required this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      cursorColor: Theme.of(context).primaryColor,
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          prefixIcon: prefixIcon ?? const SizedBox(),
          suffixIcon: suffixIcon ?? const SizedBox(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: !readOnly
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor))
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      obscureText: obscureText,
      readOnly: readOnly,
    );
  }
}
