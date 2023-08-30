import '../../exports.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isLoading;
  const CustomButton(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.backgroundColor,
      required this.foregroundColor,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: Responsive.screenHeight(context) * 0.065,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius:
              BorderRadius.circular(Responsive.screenHeight(context) * 0.08),
        ),
        child: Center(
          child: isLoading
              ? LoadingIndicator(
                  indicatorType: Indicator.ballPulse, colors: [foregroundColor])
              : Text(
                  label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600, color: foregroundColor),
                ),
        ),
      ),
    );
  }
}
