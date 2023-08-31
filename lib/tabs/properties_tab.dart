import '../exports.dart';

class PropertiesTab extends StatelessWidget {
  const PropertiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final userRole = Provider.of<RoleProvider>(context);

    final TextEditingController _searchController = TextEditingController();

    return Flexible(
        child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: Responsive.screenHeight(context) * 0.02,
          horizontal: Responsive.screenWidth(context) * 0.04),
      child: Stack(
        children: [
          Column(
            children: [
              userRole.userRole == RoleType.tenant
                  ? CustomizedTextField(
                      controller: _searchController,
                      labelText: 'Search',
                      prefixIcon: const Icon(Icons.search))
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'My Properties',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => const PropertyContainer(),
                ),
              )
            ],
          ),
          userRole.userRole == RoleType.proprietor
              ? Positioned(
                  bottom: Responsive.screenHeight(context) * 0.085,
                  right: Responsive.screenWidth(context) * 0.01,
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: const Icon(Icons.add),
                    onPressed: () {},
                  ),
                )
              : const SizedBox(),
        ],
      ),
    ));
  }
}
