import 'package:hive/hive.dart';
import '../../../../core/models/movies_model.dart';
import '../../../auth/data/models/user.dart';

class ProfileLocalDataSource {
  final Box<dynamic> userBox = Hive.box('userBox');
  final Box<MovieModel> wishlistBox = Hive.box<MovieModel>('wishlistBox');
  final Box<MovieModel> historyBox = Hive.box<MovieModel>('historyBox');

  Future<void> saveUserData(MyUserModel user) async {
    await userBox.put(user.id, user.toJson());
  }

  MyUserModel? getUserData(String uid) {

    final json = userBox.get(uid);

    if (json != null) {
      return MyUserModel.fromJson(
        Map<String, dynamic>.from(json),
      );
    }

    return null;
  }

  Future<void> saveWishlist(List<MovieModel> movies) async {
    await wishlistBox.clear();
    for (var movie in movies) {
      await wishlistBox.put(movie.id, movie);
    }
  }

  List<MovieModel> getWishlist() {
    return wishlistBox.values.toList();
  }

  Future<void> saveHistory(List<MovieModel> movies) async {
    await historyBox.clear();
    for (var movie in movies) {
      await historyBox.put(movie.id, movie);
    }
  }

  List<MovieModel> getHistory() {
    return historyBox.values.toList();
  }

  Future<void> clearProfileLocalData() async {
    await userBox.clear();
    await wishlistBox.clear();
    await historyBox.clear();
  }
}