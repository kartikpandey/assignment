import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserList extends UserEvent {
  final String query;

  const GetUserList(this.query);

  @override
  String toString() => query;
}
