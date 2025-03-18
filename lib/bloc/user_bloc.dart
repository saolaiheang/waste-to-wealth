import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_to_wealth/models/user_mdel.dart';

abstract class UserEvent {}
class SetUserEvent extends UserEvent{
  final UserMdel user;
  SetUserEvent(this.user);
}
abstract class UserState{}
class UserInitial extends UserState{}
class UserLoaded extends UserState{
  final UserMdel user;
  UserLoaded(this.user);

}
class UserBloc extends Bloc<UserEvent,UserState>{
  UserBloc():super (UserInitial()){
    on<SetUserEvent>((event, emit) {
      emit(UserLoaded(event.user));
    });
  }
}