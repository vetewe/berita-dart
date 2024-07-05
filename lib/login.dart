import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_berita/dashpage.dart';


class Login extends StatelessWidget {
  // const Login({super.key});
  final myUsernameController = TextEditingController();
  final myPasswordController = TextEditingController();
  late String nUsername, nPassword;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login Page')),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                // cek data field jika kosong
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Username diisi dong';
                  }
                    return null;
                },
                controller: myUsernameController,
                decoration: InputDecoration(
                  hintText: 'Input Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                // cek data field jika kosong
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Password diisi dong';
                  }
                    return null;
                },
                maxLength: 16,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                obscureText: true,
                controller: myPasswordController,
                decoration: InputDecoration(
                  hintText: 'Input Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 25.0),
              MaterialButton(
                minWidth: 85.0,
                height: 50.0,
                color: Colors.green,
                textColor: Colors.white,
                onPressed: (){
                  // dapatkan value dari textformfield
                  nUsername = myUsernameController.text;
                  nPassword = myPasswordController.text;
          
                  if(_formKey.currentState!.validate()){
                    if(nUsername != 'vtw' ){
                      print("username salah");
                    }else if(nPassword.length <= 5){
                      print("password harus lebih dari 5 karakter");
                    }else{
                      // aksi untuk menuju dashbord karena berhasil login
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_){
                          return DashPage(nama: nUsername, password: nPassword);
                        })
                      );
                    }
                  }
                },
                child: Text('Submit'),
                )
            ],
          ),
        )
        ),
    );
  }
}