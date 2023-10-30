import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:status_bloc/models/usuario.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
    UserBloc() : super(const UserInitialState()) {
        on<ActivateUser>((event, emit) {

        });
    }
}