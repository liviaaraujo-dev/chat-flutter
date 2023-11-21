import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/core/model/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;
  const AuthForm({super.key, required this.onSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authFormData = AuthFormData();

  void _showError(String msg){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Theme.of(context).errorColor,)
    );
  }

  void _submit(){ 
    final isValid = _formKey.currentState?.validate() ?? false;
    if(!isValid) return;

    if(_authFormData.image == null && _authFormData.isSignUp){
      return _showError('Imagem não selcionada');
    }

    widget.onSubmit(_authFormData);
  }

  void _handleImagePick(File image){
    _authFormData.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if(_authFormData.isSignUp) UserImagePicker(onImagePick: _handleImagePick,),
              if(_authFormData.isSignUp)
              TextFormField(
                key: ValueKey('name'),
                initialValue: _authFormData.name,
                onChanged: (name) => _authFormData.name = name,
                validator: (_name){
                  final name = _name ?? '';
                  if(name.trim().length < 5){
                    return 'Nome deve ter no minímo 5 caracteres';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Nome')
                ),
              ),
              TextFormField(
                key: ValueKey('email'),
                initialValue: _authFormData.email,
                onChanged: (email) => _authFormData.email = email,
                validator: (_email){
                  final email = _email ?? '';
                  if(!email.contains('@')){
                    return 'Email informado não é válido';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Email')
                ),
              ),
              TextFormField(
                key: ValueKey('password'),
                initialValue: _authFormData.password,
                validator: (_password){
                  final password = _password ?? '';
                  if(password.length < 6){
                    return 'Nome deve ter no minímo 6 caracteres';
                  }
                  return null;
                },
                onChanged: (password) => _authFormData.password = password,
                obscureText: true,
                decoration: InputDecoration(
                  label: Text('Senha')
                ),
              ),
              SizedBox(height: 12,),
              ElevatedButton(
                onPressed: (){
                  _submit();
                }, 
              child: Text(_authFormData.isLogin ? 'Entrar' : 'Cadastrar')
            
              ),
              TextButton(
                child: Text(_authFormData.isLogin ? 'Criar uma nova conta?': 'Já possui conta?'),
                onPressed: (){
                  setState(() {
                    _authFormData.toggleAuthMode();
                  });
                }, 
              )
            ],
          ),
        ),
      ),
    );
  }
}
