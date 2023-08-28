import '../../exports.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  const CustomButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.backgroundColor = AppColors.secondaryColor,
      this.foregroundColor = AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: Responsive.screenHeight(context) * 0.08,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius:
              BorderRadius.circular(Responsive.screenHeight(context) * 0.08),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600, color: foregroundColor),
          ),
        ),
      ),
    );
  }
}
