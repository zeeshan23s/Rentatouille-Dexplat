import '../exports.dart';

class CustomModelSheets {
  static void bottomSheet(
      {required BuildContext context, required Widget child}) async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      builder: (context) => Material(
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}
