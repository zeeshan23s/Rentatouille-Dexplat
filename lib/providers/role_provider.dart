import '../exports.dart';

enum RoleType {
  tenant,
  proprietor,
}

class RoleProvider with ChangeNotifier {
  RoleType _userRole = RoleType.tenant;

  RoleType get userRole => _userRole;

  void toggleRole() {
    _userRole =
        _userRole == RoleType.tenant ? RoleType.proprietor : RoleType.tenant;
    notifyListeners();
  }
}
