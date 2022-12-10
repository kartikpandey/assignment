import 'package:assignment/blocs/user_event.dart';
import 'package:assignment/blocs/user_state.dart';
import 'package:assignment/resources/api_repository.dart';
import 'package:bloc/bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final ApiRepository _apiRepository = ApiRepository();
    on<GetUserList>((event, emit) async {
      try {
        emit(UserLoading());
        final mList = await _apiRepository.fetchUserList(event.query);
        emit(UserLoaded(mList));
        if (mList.error != null) {
          emit(UserError(mList.error));
        }
      } on NetworkError {
        emit(const UserError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
