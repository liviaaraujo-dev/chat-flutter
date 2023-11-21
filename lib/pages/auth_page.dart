import 'package:chat/components/auth_form.dart';
import 'package:chat/core/model/auth_form_data.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoading = false;

  Future<void>_handleSubmit(AuthFormData formData)async {
    try{
      setState(() => isLoading = true);

      if(formData.isLogin){
        // login
        await AuthService().login(formData.email, formData.password);
      }else{
        // sign up
        await AuthService().signup(formData.name, formData.email, formData.password, formData.image);
      }
    }catch(error){
      // tratar erro
    }finally{
      setState(() => isLoading = false);

    }
    // setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: _handleSubmit),
            ),
          ),
          if(isLoading) Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.5)
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
