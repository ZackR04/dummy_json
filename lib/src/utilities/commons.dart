part of 'x_utilities.dart';

class Commons {
  final prefs = SharedPreferences.getInstance();
  
  void setPrefs(UserModel userModel) async {
    final storage = await prefs;
    await storage.setInt(id, userModel.id!);
    await storage.setString(username, userModel.username!);
    await storage.setString(email, userModel.email!);
    await storage.setString(image, userModel.image!);
    await storage.setString(token, userModel.token!);
  }

  Future<UserModel> getPrefs() async {
    final storage = await prefs;
    return UserModel(
      id: storage.getInt(id),
      username: storage.getString(username),
      email: storage.getString(email),
      image: storage.getString(image),
      token: storage.getString(token),
    );
  }
}