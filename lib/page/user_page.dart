import 'package:assignment/blocs/user_bloc.dart';
import 'package:assignment/blocs/user_state.dart';
import 'package:assignment/models/users_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/user_event.dart';
import '../debouncer.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserBloc _newsBloc = UserBloc();
  final debouncer = Debouncer(milliseconds: 3000);

  @override
  void initState() {
    // _newsBloc.add(const GetUserList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff362A32),
          title: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: TextField(
                    onChanged: (term) {
                      debouncer.run(() {
                        _newsBloc.add(GetUserList(term));
                      });
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                      hintText: 'Search Some User',
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        size: 30.0,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
      body: _buildListUser(),
    );
  }

  Widget _buildListUser() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserInitial) {
                return const Center(child: Text('No Data Available'));
              } else if (state is UserLoading) {
                return _buildLoading();
              } else if (state is UserLoaded) {
                return _buildCard(context, state.userModel);
              } else if (state is UserError) {
                return const Center(child: Text('No Data Available'));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, UsersListModel model) {
    return ListView.builder(
      itemCount: model.items!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(blurRadius: 5.0, color: Colors.black26),
              ],
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xffA5A5A5),
                  Color(0xff362A32),
                ],
              )),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(model.items![index].avatarUrl ?? '')),
              const SizedBox(
                width: 20,
              ),
              Text(
                model.items![index].login ?? '',
                style: const TextStyle(fontSize: 17, color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
