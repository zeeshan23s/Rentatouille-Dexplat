import '../../exports.dart';

class RentTab extends StatefulWidget {
  const RentTab({super.key});

  @override
  State<RentTab> createState() => _RentTabState();
}

class _RentTabState extends State<RentTab> {
  final _remainingRents = [];

  bool _rentLoading = false;

  @override
  void initState() {
    super.initState();
    getRemainingRents();
  }

  void getRemainingRents() async {
    _rentLoading = true;

    if (mounted) {
      QuerySnapshot allRenters = await context.read<RentProvider>().viewRents(
          {'proprietorId': context.read<AuthProvider>().currentUser!.uid});

      List<Map<String, dynamic>> rents = [];

      for (DocumentSnapshot renter in allRenters.docs) {
        debugPrint(renter.data().toString());
        List<dynamic> temp = renter['rentHistory'];
        DateTime currentMonth = DateTime.now();
        if (!temp.any((element) =>
            (element['rentMonth'] == currentMonth.month &&
                element['rentYear'] == currentMonth.year) &&
            element['receivedDate'] != null)) {
          rents.add({
            'propertyId': renter.id,
            'tenantId': renter['tenantId'],
            'rentHistory': renter['rentHistory']
          });
        }
      }

      for (Map<String, dynamic> rent in rents) {
        Property? property = await _getPropertyInfo(rent['propertyId']);
        AppUser? user = await _getUserInfo(rent['tenantId']);
        _remainingRents.add(
          {
            'tenant': user,
            'property': property,
            'rentHistory': rent['rentHistory'],
          },
        );
      }
    }

    setState(() {
      _rentLoading = false;
    });
  }

  Future<Property?> _getPropertyInfo(String propertyId) async {
    if (mounted) {
      return await context.read<PropertyProvider>().getProperty(propertyId);
    }
    return null;
  }

  Future<AppUser?> _getUserInfo(String userId) async {
    if (mounted) {
      return await context.read<UserProvider>().getUser(userId);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RentProvider>(
      builder: (context, rent, child) => Flexible(
        child: _rentLoading == false
            ? _remainingRents.isEmpty
                ? Center(
                    child: Text('No rents available',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500)),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Responsive.screenHeight(context) * 0.02,
                        horizontal: Responsive.screenWidth(context) * 0.04),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Remaining Rents',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.02),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _remainingRents.length,
                            itemBuilder: ((context, index) {
                              return Card(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                          foregroundImage: NetworkImage(
                                              _remainingRents[index]['property']
                                                  .imagesURL[0])),
                                      title: Text(
                                          _remainingRents[index]['property']
                                              .title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      subtitle: Text(
                                          '${_remainingRents[index]['tenant'].name}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      trailing: IconButton(
                                          onPressed: () {
                                            debugPrint(_remainingRents[index]
                                                    ['rentHistory']
                                                .toString());
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RentHistoryScreen(
                                                        rentHistroy:
                                                            _remainingRents[
                                                                    index][
                                                                'rentHistory']),
                                              ),
                                            );
                                          },
                                          icon:
                                              const Icon(Icons.history_sharp)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              Responsive.screenHeight(context) *
                                                  0.02,
                                          horizontal:
                                              Responsive.screenWidth(context) *
                                                  0.02),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: CustomButton(
                                                label: 'Received',
                                                onPressed: () {
                                                  rent.receiveRent(
                                                      _remainingRents[index]
                                                              ['property']
                                                          .id,
                                                      _remainingRents[index]
                                                          ['rentHistory']);
                                                },
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                foregroundColor: Theme.of(
                                                        context)
                                                    .scaffoldBackgroundColor,
                                                isLoading: rent.isLoading),
                                          ),
                                          SizedBox(
                                              width: Responsive.screenWidth(
                                                      context) *
                                                  0.02),
                                          Expanded(
                                            child: CustomButton(
                                              label: 'Request',
                                              onPressed: () {
                                                rent.requestRent(
                                                    _remainingRents[index]
                                                            ['property']
                                                        .id,
                                                    _remainingRents[index]
                                                        ['rentHistory']);
                                              },
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              foregroundColor: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              isLoading: rent.requestLoading,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  )
            : Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              ),
      ),
    );
  }
}
