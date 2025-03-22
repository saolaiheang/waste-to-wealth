

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_to_wealth/controllers/user_controller.dart';
import 'package:waste_to_wealth/bloc/user_bloc.dart';
import 'package:waste_to_wealth/screen/homescreen.dart';
import 'package:waste_to_wealth/screen/login.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;
  final TextEditingController _usernameController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final UserController _userController=UserController();
  void _login()async{
    final  username=_usernameController.text;
    final  password=_passwordController.text;
    final userBloc=BlocProvider.of<UserBloc>(context);
    final user =await _userController.login(username, password,userBloc);
    if(user!=null){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage()),);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid username or password')));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [_buildImageHeader(screenHeight), _buildLoginForm()],
        ),
      ),
    );
  }

  /// Top Image Section
  Widget _buildImageHeader(double screenHeight) {
    return Stack(
      children: [
         ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(50)),
      child: Image.asset(
        'assets/icons/image.png',
        width: double.infinity,
        height: screenHeight * 0.3,
        fit: BoxFit.cover,
      ),
      
    ),
    Positioned(
      top: 50,
      left: 31,
    
      child:IconButton(onPressed: (){
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginPage()),);
      }, icon:Image.asset('assets/icons/Frame 2.png',height: 42,width: 42,) )
    )
        
      ],
    );
   
  }

  /// Login Form Section
  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Sign Up',
            style: TextStyle(
              color: Color(0xFF5DB751),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Create your new account',
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
          const SizedBox(height: 25),

          /// Email Field
          _buildTextField(
            hintText: 'example@gmail.com',
          controller: _usernameController,
            icon: Icons.email,
            obscureText: false,
          ),

          const SizedBox(height: 33),

          /// Password Field
          _buildTextField(
            hintText: '1234@pse!',
            controller: _passwordController,
            icon: Icons.lock,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.green,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),

          const SizedBox(height: 33,),
          _buildTextField(
            hintText: 'Location',
            controller: _passwordController,
            icon: Icons.location_city,
            obscureText: false,
            
          ),

          

          const SizedBox(height: 80),

          /// Login Button
          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5DB751),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),
              ),
            
            ),
          ),

      

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Image.asset('assets/icons/Group 43.png')],
          ),
        ],
      ),
    );
  }

  /// Custom Input Field
  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
    required bool obscureText,
    Widget? suffixIcon,

  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE9F5E9),
        borderRadius: BorderRadius.circular(10),

      ),
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: TextField(
          controller: controller,
        obscureText: obscureText,
        
        decoration: InputDecoration(
          alignLabelWithHint: true,

          
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xff309255)),
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: const Color(0xff309255)),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),

      ),
      
    );
  }
}
