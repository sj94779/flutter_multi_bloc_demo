import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/internet_bloc/internet_bloc.dart';
import '../blocs/user_bloc/app_blocs.dart';
import '../blocs/user_bloc/app_events.dart';
import '../blocs/user_bloc/app_states.dart';
import '../model/user_model.dart';
import '../repo/repositories.dart';
import 'detailed_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(UserRepository()),
        ),
        BlocProvider<InternetBloc>(
          create: (BuildContext context) => InternetBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('The BloC App')),
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserRepository>(context),
      )..add(LoadUserEvent()),
      child: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is UserLoadedState) {
                  List<UserModel> userList = state.users;
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Card(
                              color: Theme.of(context).primaryColor,
                              child: ListTile(
                                title: Text(
                                  '${userList[index].firstName}  ${userList[index].lastName}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  '${userList[index].email}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      userList[index].avatar.toString()),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          DetailedScreen(e: userList[index])));
                                },
                              )),
                        );
                      });
                }
                if (state is UserErrorState) {
                  return const Center(
                    child: Text("Error"),
                  );
                }

                return Container();
              },
            );
          }),
    );
  }
}
