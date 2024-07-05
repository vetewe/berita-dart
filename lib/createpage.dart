import 'dart:convert';
// import 'dart:html';

import 'package:app_berita/dashpage.dart';
import 'package:flutter/material.dart';
import 'package:app_berita/homepage.dart';
import 'package:http/http.dart' as http;

class CreatePage extends StatefulWidget {
  final String nama;
  final String password;
  const CreatePage({super.key, required this.nama, required this.password});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final judulController = TextEditingController();
  final isiContoller = TextEditingController();
  final gambarController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future _onSubmit() async{
    try{
      return await http.post(
        Uri.parse(url), 
        body: {
          "judul": judulController.text,
          "isi" : isiContoller.text,
          "gambar" : gambarController.text,
        }
      ).then((value){
        var data = jsonDecode(value.body);
        print(data["message"]);

        Navigator.push(context, MaterialPageRoute(builder: (context) => 
          DashPage(nama: widget.nama, password: widget.password))
        );
      });
    }catch(e){
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Tambah Berita')),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Judul',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: judulController,
                decoration: InputDecoration(
                  hintText: "Input Judul Berita",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)
                  )
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Judul Wajib Diisi !';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              // 
              Text(
                'Isi Berita',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: isiContoller,
                // minLines: 5,
                maxLength: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Input Isi Berita",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)
                  )
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Isi Berita Wajib Diisi !';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              // 

              Text(
                'Gambar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: gambarController,
                decoration: InputDecoration(
                  hintText: "Input Gambar Berita",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)
                  )
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Gambar Diisi dong !';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              // 

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)
                  )
                ),
                child : Text(
                  "Submit",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  // validasi
                  if(_formKey.currentState!.validate()){
                    _onSubmit();
                  }
                }
              )
            ],
          ),
        )
        ),
    );
  }
}