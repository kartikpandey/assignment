import 'package:assignment/models/users_list_model.dart';

import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<UsersListModel> fetchUserList(String query) {
    return _provider.fetchUserList(query);
  }
}

class NetworkError extends Error {}