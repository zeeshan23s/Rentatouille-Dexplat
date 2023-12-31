import '../exports.dart';

class PropertiesTab extends StatelessWidget {
  PropertiesTab({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userRole = Provider.of<RoleProvider>(context);

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
                        labelText: 'Search By Location',
                        prefixIcon: Icon(Icons.search,
                            color: Theme.of(context).primaryColor),
                      )
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
                          stream: userRole.userRole == RoleType.tenant
                              ? property.inventoryProperties(
                                  _searchController.text,
                                  context.read<AuthProvider>().currentUser!.uid)
                              : property.myProperties(context
                                  .read<AuthProvider>()
                                  .currentUser!
                                  .uid),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500)),
                              );
                            } else if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Text('No data available',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500)),
                              );
                            } else {
                              List<QueryDocumentSnapshot> properties =
                                  snapshot.data!.docs;
                              properties.removeWhere((element) =>
                                  !element['address'].contains(
                                      _searchController.text.toLowerCase()));
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
                            builder: (context) => const ManageProperty(),
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
