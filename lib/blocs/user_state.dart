// part of 'user_bloc.dart';

import 'package:equatable/equatable.dart';
import '../models/users_list_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UsersListModel userModel;
  const UserLoaded(this.userModel);
}

class UserError extends UserState {
  final String? message;
  const UserError(this.message);
}
