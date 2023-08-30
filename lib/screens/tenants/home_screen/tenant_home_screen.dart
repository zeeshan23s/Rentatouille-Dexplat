import '../../../exports.dart';

class TenantHomeScreen extends StatefulWidget {
  const TenantHomeScreen({super.key});

  @override
  State<TenantHomeScreen> createState() => _TenantHomeScreenState();
}

class _TenantHomeScreenState extends State<TenantHomeScreen> {
  final _tabs = [
    const NewTab(),
    const NewTab(),
    const NewTab(),
    const NewTab(),
  ];

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(),
            _tabs[_selectedTab],
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      height: Responsive.screenHeight(context) * 0.08,
      margin: EdgeInsets.symmetric(
          vertical: Responsive.screenHeight(context) * 0.01,
          horizontal: Responsive.screenWidth(context) * 0.02),
      padding: EdgeInsets.symmetric(
          vertical: Responsive.screenHeight(context) * 0.01,
          horizontal: Responsive.screenWidth(context) * 0.02),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius:
              BorderRadius.circular(Responsive.screenHeight(context) * 0.05)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _tabs
            .asMap()
            .entries
            .map(
              (e) => IconButton(
                onPressed: () {
                  setState(() {
                    _selectedTab = _tabs.indexOf(e.value);
                  });
                },
                icon: Icon(
                  tabIcon(
                    _tabs.indexOf(e.value),
                  ),
                  size: 28,
                  color: _selectedTab == _tabs.indexOf(e.value)
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.4),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

IconData tabIcon(int index) {
  switch (index) {
    case 0:
      return Icons.home;
    case 1:
      return Icons.newspaper;
    case 2:
      return Icons.question_answer;
    default:
      return Icons.person;
  }
}
