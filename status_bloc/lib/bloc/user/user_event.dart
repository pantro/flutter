part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class ActivateUser extends UserEvent {
  final Usuario user;
  //Constructor
  ActivateUser(this.user);
}

class ChangeUserAge extends UserEvent {
  final int age;
  //Constructor
  ChangeUserAge(this.age);
}

class AddUserProfession extends UserEvent {
  final String newprofession;
  //Constructor
  AddUserProfession(this.newprofession);
}

class DeleteUser extends UserEvent {}
