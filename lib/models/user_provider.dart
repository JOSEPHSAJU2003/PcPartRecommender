import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  int _currentUserId = 1; // Default to 1 for now
  
  int get currentUserId => _currentUserId;
  
  void setCurrentUserId(int userId) {
    _currentUserId = userId;
    notifyListeners();
  }
  
  bool get isLoggedIn => _currentUserId > 0;
}