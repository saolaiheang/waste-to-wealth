import 'package:waste_to_wealth/models/user_mdel.dart';
import 'package:waste_to_wealth/bloc/user_bloc.dart';
import 'package:waste_to_wealth/services/api_service.dart';


class UserController {
  final ApiService _apiService=ApiService();
  Future <UserMdel?>login (String username,String password,[UserBloc?userBloc])async{
    final user=await _apiService.login(username, password);
    if (user != null && userBloc !=null){
      userBloc.add(
        SetUserEvent(user)
      );
    }
    return user;
  }

  
}
