import '../exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isMenuOpen = false;

  final _tenantTabs = [
    PropertiesTab(),
    const NewsTab(),
    const ChatTab(),
    ProfileTab(),
  ];

  final _proprietorTabs = [
    PropertiesTab(),
    const RentTab(),
    const ChatTab(),
    ProfileTab(),
  ];

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<RoleProvider>(builder: (context, userRole, child) {
      return GestureDetector(
        onTap: () => setState(() {
          _isMenuOpen = false;
        }),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    CustomAppBar(
                      onMenuTap: () {
                        setState(() {
                          _isMenuOpen = !_isMenuOpen;
                        });
                      },
                    ),
                    userRole.userRole == RoleType.tenant
                        ? _tenantTabs[_selectedTab]
                        : _proprietorTabs[_selectedTab],
                  ],
                ),
                _isMenuOpen
                    ? Positioned(
                        top: Responsive.screenHeight(context) * 0.055,
                        left: Responsive.screenWidth(context) * 0.034,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  Responsive.screenWidth(context) * 0.04,
                              vertical:
                                  Responsive.screenHeight(context) * 0.01),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(
                                  Responsive.screenWidth(context) * 0.02)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _menuItem(
                                  icon: Icons.payment,
                                  label: 'My Rent',
                                  onPressed: () {
                                    context.read<RentProvider>().viewRents({
                                      'tenantId': context
                                          .read<AuthProvider>()
                                          .currentUser!
                                          .uid
                                    }).then((value) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              RentHistoryScreen(
                                                  rentHistroy: value.docs.first
                                                      .data()
                                                      .entries
                                                      .first
                                                      .value)),
                                        ),
                                      );
                                    });
                                  }),
                              _menuItem(
                                  icon: Icons.switch_account,
                                  label: userRole.userRole == RoleType.tenant
                                      ? 'Switch to Proprietor'
                                      : 'Switch to Tenant',
                                  onPressed: () {
                                    userRole.toggleRole();
                                    _isMenuOpen = false;
                                  }),
                              _menuItem(
                                icon: Icons.logout,
                                label: 'Logout',
                                onPressed: () =>
                                    context.read<AuthProvider>().logout(),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                Positioned(
                  bottom: Responsive.screenHeight(context) * 0.005,
                  left: Responsive.screenWidth(context) * 0.04,
                  right: Responsive.screenWidth(context) * 0.04,
                  child: _bottomNavigationBar(
                      userRole.userRole == RoleType.tenant
                          ? _tenantTabs
                          : _proprietorTabs),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _bottomNavigationBar(List tabs) {
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
        children: tabs
            .asMap()
            .entries
            .map(
              (e) => IconButton(
                onPressed: () {
                  setState(() {
                    _selectedTab = tabs.indexOf(e.value);
                  });
                },
                icon: Icon(
                  context.read<RoleProvider>().userRole == RoleType.tenant
                      ? tenantTabIcon(
                          tabs.indexOf(e.value),
                        )
                      : proprietorTabIcon(
                          tabs.indexOf(e.value),
                        ),
                  size: 28,
                  color: _selectedTab == tabs.indexOf(e.value)
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

  Widget _menuItem(
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Responsive.screenHeight(context) * 0.01),
      child: InkWell(
        splashColor: Theme.of(context).scaffoldBackgroundColor,
        onTap: onPressed,
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).scaffoldBackgroundColor),
            SizedBox(width: Responsive.screenWidth(context) * 0.015),
            Text(label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).scaffoldBackgroundColor))
          ],
        ),
      ),
    );
  }
}

IconData tenantTabIcon(int index) {
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

IconData proprietorTabIcon(int index) {
  switch (index) {
    case 0:
      return Icons.home;
    case 1:
      return Icons.attach_money_outlined;
    case 2:
      return Icons.question_answer;
    default:
      return Icons.person;
  }
}
