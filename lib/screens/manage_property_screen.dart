import 'dart:io';
import '../exports.dart';

class ManageProperty extends StatefulWidget {
  final Property? property;
  const ManageProperty({super.key, this.property});

  @override
  State<ManageProperty> createState() => _ManagePropertyState();
}

class _ManagePropertyState extends State<ManageProperty> {
  bool hasLounge = false;

  List<XFile> _images = [];

  final ImagePicker picker = ImagePicker();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _bedroomController = TextEditingController();
  final _areaController = TextEditingController();
  final _monthlyRentController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.property != null) {
      _titleController.text = widget.property!.title;
      _descriptionController.text = widget.property!.description;
      _bedroomController.text = widget.property!.bedrooms.toString();
      _areaController.text = widget.property!.area.toString();
      _monthlyRentController.text = widget.property!.monthlyRent.toString();
      _addressController.text = widget.property!.address;

      hasLounge = widget.property!.hasLounge;

      getPropertyImages();
    }
  }

  void getPropertyImages() async {
    _images = await context
        .read<PropertyProvider>()
        .convertFileToXFile(widget.property!.imagesURL);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertyProvider>(builder: (context, property, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
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
            widget.property == null
                ? 'Add Your Property'
                : 'Edit Your Property',
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
          child: property.isImageLoading
              ? Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                )
              : Column(
                  children: [
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                _images = await picker.pickMultiImage();
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        Responsive.screenWidth(context) * 0.02),
                                height: Responsive.screenWidth(context) * 0.25,
                                width: Responsive.screenWidth(context) * 0.25,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                child: Center(
                                  child: Icon(
                                    Icons.camera_enhance,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            ..._images
                                .asMap()
                                .entries
                                .map(
                                  (e) => Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: Responsive.screenWidth(
                                                    context) *
                                                0.02),
                                        height:
                                            Responsive.screenWidth(context) *
                                                0.25,
                                        width: Responsive.screenWidth(context) *
                                            0.25,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.1),
                                          image: DecorationImage(
                                            image: FileImage(
                                              File(e.value.path),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: Responsive.screenHeight(context) *
                                            0.0025,
                                        right: Responsive.screenWidth(context) *
                                            0.025,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _images.remove(e.value);
                                            });
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            radius: Responsive.screenWidth(
                                                    context) *
                                                0.025,
                                            child: Icon(
                                              Icons.close,
                                              size: 14,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.screenHeight(context) * 0.015),
                    CustomizedTextField(
                        controller: _titleController, labelText: 'Title'),
                    SizedBox(height: Responsive.screenHeight(context) * 0.015),
                    CustomizedTextField(
                        controller: _descriptionController,
                        labelText: 'Description'),
                    SizedBox(height: Responsive.screenHeight(context) * 0.015),
                    CustomizedTextField(
                        controller: _bedroomController, labelText: 'Bedrooms'),
                    SizedBox(height: Responsive.screenHeight(context) * 0.015),
                    CustomizedTextField(
                        controller: _areaController, labelText: ' Area'),
                    SizedBox(height: Responsive.screenHeight(context) * 0.015),
                    CustomizedTextField(
                        controller: _monthlyRentController,
                        labelText: 'Monthly Rent'),
                    SizedBox(height: Responsive.screenHeight(context) * 0.015),
                    CustomizedTextField(
                        controller: _addressController, labelText: 'Address'),
                    SizedBox(height: Responsive.screenHeight(context) * 0.015),
                    CheckboxListTile.adaptive(
                        value: hasLounge,
                        onChanged: (value) {
                          setState(() {
                            hasLounge = value!;
                          });
                        },
                        title: Text('Has a Lounge',
                            style: Theme.of(context).textTheme.bodyMedium))
                  ],
                ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).scaffoldBackgroundColor,
          onPressed: () async {
            if (widget.property == null) {
              await property
                  .create(
                      Property(
                          id: '',
                          title: _titleController.text,
                          description: _descriptionController.text,
                          imagesURL: [],
                          bedrooms: int.parse(_bedroomController.text),
                          area: int.parse(_areaController.text),
                          monthlyRent: int.parse(_monthlyRentController.text),
                          address: _addressController.text,
                          hasLounge: hasLounge,
                          uploadByUser:
                              context.read<AuthProvider>().currentUser!.uid,
                          isSold: false,
                          buyerId: null),
                      _images)
                  .whenComplete(
                    () => Navigator.pop(context),
                  );
            } else {
              await property
                  .update(
                      Property(
                          id: widget.property!.id,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          imagesURL: [],
                          bedrooms: int.parse(_bedroomController.text),
                          area: int.parse(_areaController.text),
                          monthlyRent: int.parse(_monthlyRentController.text),
                          address: _addressController.text,
                          hasLounge: hasLounge,
                          uploadByUser:
                              context.read<AuthProvider>().currentUser!.uid,
                          isSold: widget.property!.isSold,
                          buyerId: widget.property!.buyerId),
                      _images)
                  .whenComplete(
                    () => Navigator.pop(context),
                  );
            }
          },
          child: property.isLoading
              ? Padding(
                  padding:
                      EdgeInsets.all(Responsive.screenWidth(context) * 0.05),
                  child: CircularProgressIndicator(
                      color: Theme.of(context).scaffoldBackgroundColor),
                )
              : Text(
                  widget.property == null ? 'Add' : 'Update',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
        ),
      );
    });
  }
}
