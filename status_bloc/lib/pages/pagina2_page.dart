import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:status_bloc/bloc/user/user_bloc.dart';
import 'package:status_bloc/models/usuario.dart';

class Pagina2Page extends StatelessWidget {
  const Pagina2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina 2'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            color: Colors.blue,
            onPressed: () {
              final newUser = Usuario(
                  edad: 36,
                  nombre: 'Fernando',
                  profesiones: ['fullstack developer']);
              //BlocProvider.of<UserBloc>(context, listen: false).add(ActivateUser(newUser));
              userBloc.add(ActivateUser(newUser));
            },
            child: const Text('Establecer Usuario',
                style: TextStyle(color: Colors.white)),
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () {
              userBloc.add(ChangeUserAge(25));
            },
            child: const Text('Cambiar Edad',
                style: TextStyle(color: Colors.white)),
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () {
              userBloc.add(AddUserProfession("Drupal"));
            },
            child: const Text('Añadir Profesion',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      )),
    );
  }
}
