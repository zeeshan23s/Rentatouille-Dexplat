import '../../exports.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onMenuTap;
  CustomAppBar({super.key, required this.onMenuTap});

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.light_mode);
      }
      return const Icon(Icons.dark_mode);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onMenuTap,
          icon: Icon(Icons.menu, color: Theme.of(context).primaryColor),
        ),
        Text(
          "Rentatouille",
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        Consumer<ThemeProvider>(builder: (context, theme, child) {
          return Switch(
            value: theme.themeMode == ThemeMode.light,
            onChanged: (value) => theme.toggleTheme(),
            activeColor: Colors.amber,
            thumbIcon: thumbIcon,
          );
        })
      ],
    );
  }
}
