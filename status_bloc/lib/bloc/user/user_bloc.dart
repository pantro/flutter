import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:status_bloc/models/usuario.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitialState()) {
    on<ActivateUser>((event, emit) => emit(UserSetState(event.user)));
    on<ChangeUserAge>((event, emit) {
      if (!state.existUser) return;

      emit(UserSetState(state.user!.copyWith(
          edad: event
              .age))); //Se pone admiracion porque se verifico que no va a ser nulo en el anterior linea
    });

    on<AddUserProfession>((event, emit) {
      if (!state.existUser) return;

      final professions = [...state.user!.profesiones, event.newprofession];
      emit(UserSetState(state.user!.copyWith(profesiones: professions)));
    });

    on<DeleteUser>((event, emit) => emit(const UserInitialState()));
  }
}
