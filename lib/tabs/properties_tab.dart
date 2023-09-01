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
                  child: Consumer<PropertyProvider>(
                    builder: (context, property, child) {
                      return StreamBuilder(
                          stream: property.myProperties(
                              context.read<AuthProvider>().currentUser!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<QueryDocumentSnapshot> properties =
                                  snapshot.data!.docs;
                              return ListView.builder(
                                itemCount: properties.length,
                                itemBuilder: (context, index) =>
                                    PropertyContainer(
                                  property: Property(
                                      id: properties[index]['id'],
                                      title: properties[index]['title'],
                                      description: properties[index]
                                          ['description'],
                                      imagesURL: properties[index]['imagesURL'],
                                      bedrooms: properties[index]['bedrooms'],
                                      area: properties[index]['area'],
                                      monthlyRent: properties[index]
                                          ['monthlyRent'],
                                      address: properties[index]['address'],
                                      hasLounge: properties[index]['hasLounge'],
                                      uploadByUser: properties[index]
                                          ['uploadByUser'],
                                      isSold: properties[index]['isSold']),
                                ),
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          });
                    },
                  ),
                ),
                SizedBox(height: Responsive.screenHeight(context) * 0.08),
              ],
            ),
            userRole.userRole == RoleType.proprietor
                ? Positioned(
                    bottom: Responsive.screenHeight(context) * 0.085,
                    right: Responsive.screenWidth(context) * 0.01,
                    child: FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddProperty(),
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
