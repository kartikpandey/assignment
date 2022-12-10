import 'package:assignment/models/users_list_model.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://api.github.com/search/users?q=';

  Future<UsersListModel> fetchUserList(String query) async {
    try {
      Response response = await _dio.get(_url + query + '&sort=repositories');
      return UsersListModel.fromJson(response.data);
    } catch (error) {
      return UsersListModel.withError("Data not found");
    }
  }
}
