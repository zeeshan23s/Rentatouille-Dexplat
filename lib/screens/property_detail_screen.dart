import '../exports.dart';

class PropertyDetailScreen extends StatefulWidget {
  final Property property;
  const PropertyDetailScreen({super.key, required this.property});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  int _displayImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    String location = '';
    List<String> locationList = widget.property.address.split(' ');
    for (String txt in locationList) {
      location = '$location${txt.replaceFirst(txt[0], txt[0].toUpperCase())} ';
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.property.title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Responsive.screenHeight(context) * 0.02,
            horizontal: Responsive.screenWidth(context) * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: Responsive.screenHeight(context) * 0.35,
                    width: Responsive.screenWidth(context),
                    padding: EdgeInsets.symmetric(
                        horizontal: Responsive.screenWidth(context) * 0.025),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              widget.property.imagesURL[_displayImageIndex]),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(
                          Responsive.screenWidth(context) * 0.05),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _displayImageIndex > 0
                            ? imageChangeButton(
                                context,
                                Icons.arrow_back_ios,
                                () {
                                  setState(() {
                                    _displayImageIndex = _displayImageIndex - 1;
                                  });
                                },
                              )
                            : const SizedBox(),
                        _displayImageIndex <
                                widget.property.imagesURL.length - 1
                            ? imageChangeButton(
                                context,
                                Icons.arrow_forward_ios,
                                () {
                                  setState(() {
                                    _displayImageIndex = _displayImageIndex + 1;
                                  });
                                },
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                  Positioned(
                    left: Responsive.screenWidth(context) * 0.2,
                    right: Responsive.screenWidth(context) * 0.2,
                    top: Responsive.screenHeight(context) * 0.01,
                    child: imageAttribute(
                        context,
                        Text(
                          'RS ${widget.property.monthlyRent}/month',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Theme.of(context).scaffoldBackgroundColor),
                  ),
                  Positioned(
                    left: Responsive.screenWidth(context) * 0.2,
                    right: Responsive.screenWidth(context) * 0.2,
                    bottom: Responsive.screenHeight(context) * 0.01,
                    child: imageAttribute(
                        context,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.property.imagesURL
                              .asMap()
                              .entries
                              .map((e) => Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Responsive.screenWidth(context) *
                                                0.005),
                                    child: CircleAvatar(
                                        backgroundColor:
                                            widget.property.imagesURL[
                                                        _displayImageIndex] ==
                                                    e.value.toString()
                                                ? Theme.of(context)
                                                    .scaffoldBackgroundColor
                                                : Theme.of(context)
                                                    .scaffoldBackgroundColor
                                                    .withOpacity(0.2),
                                        radius:
                                            Responsive.screenWidth(context) *
                                                0.012),
                                  ))
                              .toList(),
                        ),
                        Colors.transparent),
                  ),
                ],
              ),
              SizedBox(height: Responsive.screenHeight(context) * 0.015),
              ListTile(
                leading: Icon(Icons.location_on,
                    color: Theme.of(context).primaryColor),
                title: Text(
                  'Location',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  location,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              StreamBuilder(
                  stream: context
                      .read<ReviewProvider>()
                      .viewReview(widget.property.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<dynamic> reviewsId =
                          snapshot.data!['reviewProviderIds'];
                      double reviews =
                          double.parse(snapshot.data!['reviews'].toString());
                      bool alreadyReviewed = reviewsId.contains(
                          context.read<AuthProvider>().currentUser!.uid);
                      return Card(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  Responsive.screenWidth(context) * 0.02,
                              vertical:
                                  Responsive.screenHeight(context) * 0.01),
                          child: SizedBox(
                            height: Responsive.screenHeight(context) * 0.1,
                            width: Responsive.screenWidth(context) * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Reviews (${reviewsId.length})',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    alreadyReviewed ||
                                            context
                                                    .read<RoleProvider>()
                                                    .userRole ==
                                                RoleType.proprietor
                                        ? const SizedBox()
                                        : GestureDetector(
                                            onTap: () =>
                                                CustomModelSheets.bottomSheet(
                                              context: context,
                                              child: ReviewForm(
                                                  propertyId:
                                                      widget.property.id),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      Responsive.screenHeight(
                                                              context) *
                                                          0.01,
                                                  horizontal:
                                                      Responsive.screenWidth(
                                                              context) *
                                                          0.02),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Responsive
                                                                  .screenWidth(
                                                                      context) *
                                                              0.05)),
                                              child: Text(
                                                'Give Reviews',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Theme.of(context)
                                                            .scaffoldBackgroundColor),
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Responsive.screenWidth(context) *
                                              0.02),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        reviews.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                          height:
                                              Responsive.screenHeight(context) *
                                                  0.05),
                                      Row(
                                        children: List.generate(
                                          5,
                                          (index) {
                                            if (index + 1 <= reviews.floor()) {
                                              return const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              );
                                            } else if (reviews.floor() <
                                                    index + 1 &&
                                                reviews.ceil() == index + 1) {
                                              return const Icon(
                                                Icons.star_half,
                                                color: Colors.amber,
                                              );
                                            } else {
                                              return const Icon(
                                                Icons.star_border,
                                                color: Colors.amber,
                                              );
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor),
                      );
                    }
                  }),
              SizedBox(height: Responsive.screenHeight(context) * 0.015),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    propertyAttribute(
                        context, Icons.bed, '${widget.property.bedrooms} Beds'),
                    propertyAttribute(context, Icons.zoom_out_map,
                        '${widget.property.area} m'),
                    widget.property.hasLounge
                        ? propertyAttribute(context, Icons.check_box, 'Lounge')
                        : const SizedBox()
                  ],
                ),
              ),
              SizedBox(height: Responsive.screenHeight(context) * 0.025),
              Text(
                'Description',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: Responsive.screenHeight(context) * 0.008),
              Text(
                widget.property.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: Responsive.screenHeight(context) * 0.08),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: Responsive.screenWidth(context) * 0.08),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                onPressed: () async {
                  if (context.read<RoleProvider>().userRole ==
                      RoleType.tenant) {
                    await context
                        .read<ChatProvider>()
                        .initialize(
                          Chat(
                            id: '',
                            tenantID:
                                context.read<AuthProvider>().currentUser!.uid,
                            proprietorID: widget.property.uploadByUser,
                            propertyID: widget.property.id,
                            chat: [],
                          ),
                        )
                        .then((value) {
                      if (value != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(chatId: value),
                          ),
                        );
                      }
                    });
                  } else {
                    context
                        .read<PropertyProvider>()
                        .delete(widget.property.id)
                        .whenComplete(() => Navigator.pop(context));
                  }
                },
                child: Icon(
                    context.read<RoleProvider>().userRole == RoleType.tenant
                        ? Icons.chat
                        : Icons.delete)),
            Consumer<PropertyProvider>(builder: (context, property, child) {
              return SizedBox(
                width: Responsive.screenWidth(context) * 0.75,
                child: CustomButton(
                    label:
                        context.read<RoleProvider>().userRole == RoleType.tenant
                            ? 'Book Now'
                            : 'Edit',
                    onPressed: () {
                      if (context.read<RoleProvider>().userRole ==
                          RoleType.tenant) {
                        property
                            .update(
                                Property(
                                    id: widget.property.id,
                                    title: widget.property.title,
                                    description: widget.property.description,
                                    imagesURL: widget.property.imagesURL,
                                    bedrooms: widget.property.bedrooms,
                                    area: widget.property.area,
                                    monthlyRent: widget.property.monthlyRent,
                                    address: widget.property.address,
                                    hasLounge: widget.property.hasLounge,
                                    buyerId: context
                                        .read<AuthProvider>()
                                        .currentUser!
                                        .uid,
                                    uploadByUser: widget.property.uploadByUser,
                                    isSold: true),
                                null)
                            .then(
                              (value) => context.read<RentProvider>().create(
                                    PropertyRent(
                                        propertyId: widget.property.id,
                                        proprietorId:
                                            widget.property.uploadByUser,
                                        tenantId: context
                                            .read<AuthProvider>()
                                            .currentUser!
                                            .uid,
                                        rentHistory: []),
                                  ),
                            );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ManageProperty(property: widget.property),
                          ),
                        );
                      }
                    },
                    isLoading: property.isLoading,
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).scaffoldBackgroundColor),
              );
            })
          ],
        ),
      ),
    );
  }
}

Widget imageChangeButton(
    BuildContext context, IconData icon, VoidCallback onPressed) {
  return CircleAvatar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    child: Center(
      child: IconButton(
          onPressed: onPressed,
          icon: Padding(
            padding: EdgeInsets.all(Responsive.screenWidth(context) * 0.008),
            child: Icon(icon, size: 18, color: Theme.of(context).primaryColor),
          )),
    ),
  );
}

Widget imageAttribute(
    BuildContext context, Widget child, Color backgroundColor) {
  return Container(
    height: Responsive.screenHeight(context) * 0.05,
    width: Responsive.screenWidth(context) * 0.45,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius:
          BorderRadius.circular(Responsive.screenWidth(context) * 0.025),
    ),
    child: Center(child: child),
  );
}

Widget propertyAttribute(BuildContext context, IconData icon, String value) {
  return Container(
    height: Responsive.screenHeight(context) * 0.05,
    width: Responsive.screenWidth(context) * 0.35,
    padding: EdgeInsets.symmetric(
        vertical: Responsive.screenHeight(context) * 0.01,
        horizontal: Responsive.screenWidth(context) * 0.02),
    margin: EdgeInsets.symmetric(
        horizontal: Responsive.screenWidth(context) * 0.01),
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      borderRadius:
          BorderRadius.circular(Responsive.screenWidth(context) * 0.01),
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          SizedBox(width: Responsive.screenWidth(context) * 0.03),
          Text(value, style: Theme.of(context).textTheme.bodyMedium)
        ],
      ),
    ),
  );
}
