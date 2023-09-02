import 'dart:io';
import 'package:flutter/services.dart';
import '../exports.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PropertyProvider with ChangeNotifier {
  Map<String, String> _status = {};
  bool _isLoading = false;
  bool _isImageLoading = false;

  bool get isLoading => _isLoading;
  bool get isImageLoading => _isImageLoading;
  Map<String, String> get status => _status;

  static final _propertyCollection =
      FirebaseFirestore.instance.collection('properties');
  static final _storage = FirebaseStorage.instance;

  Future<void> create(Property property, List<XFile> images) async {
    _isLoading = true;
    notifyListeners();

    final List<String> imagesURL = [];

    try {
      for (XFile image in images) {
        imagesURL.add(await _uploadImage(await image.readAsBytes(),
            '${property.title}-${imagesURL.length + 1}'));
      }
      await _propertyCollection.add(property.toMap()).then(
        (value) {
          _propertyCollection
              .doc(value.id)
              .update({'id': value.id, 'imagesURL': imagesURL});
          _status = {'status': 'success', 'message': 'Successfully Created!'};
        },
      );
    } on FirebaseException catch (e) {
      _status = {'status': 'error', 'message': e.message ?? ''};
    } catch (e) {
      _status = {'status': 'error', 'message': e.toString()};
    }

    _isLoading = false;
    notifyListeners();
  }

  Stream<QuerySnapshot> myProperties(String userID) {
    return _propertyCollection
        .where('uploadByUser', isEqualTo: userID)
        .snapshots();
  }

  Stream<QuerySnapshot> inventoryProperties(String value, String userID) {
    return _propertyCollection
        .where('isSold', isEqualTo: false)
        .where('uploadByUser', isNotEqualTo: userID)
        .snapshots();
  }

  Future<void> delete(String id) async {
    try {
      await _propertyCollection.doc(id).delete();
      _status = {'status': 'success', 'message': 'Successfully Removed!'};
    } on FirebaseException catch (e) {
      _status = {'status': 'error', 'message': e.message ?? ''};
    } catch (e) {
      _status = {'status': 'error', 'message': e.toString()};
    }
  }

  Future<void> update(Property property, List<XFile>? images) async {
    _isLoading = true;
    notifyListeners();

    List<dynamic> imagesURL = [];

    try {
      if (images == null) {
        imagesURL = property.imagesURL;
      } else {
        for (XFile image in images) {
          imagesURL.add(await _uploadImage(await image.readAsBytes(),
              '${property.title}-${imagesURL.length + 1}'));
        }
      }
      await _propertyCollection.doc(property.id).update(property.toMap()).then(
        (value) {
          _propertyCollection.doc(property.id).update({'imagesURL': imagesURL});
          _status = {'status': 'success', 'message': 'Successfully Updated!'};
        },
      );
    } on FirebaseException catch (e) {
      _status = {'status': 'error', 'message': e.message ?? ''};
    } catch (e) {
      _status = {'status': 'error', 'message': e.toString()};
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<String> _uploadImage(Uint8List file, String name) async {
    final ref = _storage.ref("images/properties/$name");
    final uploadTask = ref.putData(file);
    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }

  Future<File> convertNetworkImageToFile(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final tempImagePath =
            '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';

        final File imageFile = File(tempImagePath);
        await imageFile.writeAsBytes(response.bodyBytes);

        return imageFile;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<XFile>> convertFileToXFile(List<dynamic> imageURL) async {
    _isImageLoading = true;

    List<XFile> images = [];
    for (String image in imageURL) {
      File tempFile = await convertNetworkImageToFile(image);
      images.add(XFile(tempFile.path));
    }

    _isImageLoading = false;
    notifyListeners();
    return images;
  }

  Future<Property> getProperty(String properyId) async {
    DocumentSnapshot property = await _propertyCollection.doc(properyId).get();
    return Property(
        id: property.id,
        title: property['title'],
        description: property['description'],
        imagesURL: property['imagesURL'],
        bedrooms: property['bedrooms'],
        area: property['area'],
        monthlyRent: property['monthlyRent'],
        address: property['address'],
        hasLounge: property['hasLounge'],
        uploadByUser: property['uploadByUser'],
        isSold: property['isSold']);
  }
}
