abstract class ISharedStorage {
  Future<bool> containsKey({required String key});
  Future<void> delete({required String key});
  Future<void> clear();
  Future<String?> read({required String key});
  Future<Map<String, String>> readAll();
  Future<void> write({required String key, required String? value});
}
