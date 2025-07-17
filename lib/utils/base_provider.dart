import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Base provider class that handles common functionality
/// such as SharedPreferences caching and error handling
abstract class BaseProvider extends ChangeNotifier {
  static SharedPreferences? _cachedPrefs;
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Get cached SharedPreferences instance to avoid repeated async calls
  static Future<SharedPreferences> getPrefs() async {
    _cachedPrefs ??= await SharedPreferences.getInstance();
    return _cachedPrefs!;
  }

  /// Set loading state and notify listeners
  void setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  /// Set error state and notify listeners
  void setError(String? error) {
    if (_error != error) {
      _error = error;
      notifyListeners();
    }
  }

  /// Clear error state
  void clearError() {
    setError(null);
  }

  /// Safe wrapper for async operations with error handling
  Future<T?> safeAsync<T>(Future<T> Function() operation, {String? errorContext}) async {
    try {
      clearError();
      return await operation();
    } catch (e, stackTrace) {
      final errorMessage = errorContext != null 
          ? '$errorContext: ${e.toString()}'
          : e.toString();
      setError(errorMessage);
      
      // Log error in debug mode
      if (kDebugMode) {
        print('Error in ${errorContext ?? 'operation'}: $e');
        print('Stack trace: $stackTrace');
      }
      return null;
    }
  }

  /// Safe wrapper for SharedPreferences operations
  Future<T?> safePrefOperation<T>(Future<T> Function(SharedPreferences prefs) operation, {String? errorContext}) async {
    return safeAsync<T>(() async {
      final prefs = await getPrefs();
      return await operation(prefs);
    }, errorContext: errorContext);
  }

}