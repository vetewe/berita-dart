import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app_berita/homepage.dart';
import 'package:app_berita/dashpage.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final String nama;
  final String password;
  final String id;
  const EditPage({super.key, required this.nama, required this.password, required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  // inisialisasi field
  var judulController = TextEditingController();
  var isiContoller = TextEditingController();
  var gambarController = TextEditingController();

  @override
  void initState(){
    super.initState();
    _getData();
  }

  Future _getData() async{
    try{
      final response = await http.get(Uri.parse(
        url+"/${widget.id}"
      ));
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          judulController = TextEditingController(text: data['judul']);
          isiContoller = TextEditingController(text: data['isi']);
          gambarController = TextEditingController(text: data['gambar']);
        });
      }
    }catch(e){
      print(e);
    }
  }

  Future _onUpdate() async {
    try{
      return await http.put(Uri.parse(url+"/${widget.id}"),
      body: {
        "id" : widget.id,
        "judul" : judulController.text,
        "isi" : isiContoller.text,
        "gambar" : gambarController.text,
      }
      ).then((value) {
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

  Future _onDelete() async {
    try{
      return await http.delete(Uri.parse(url+"/${widget.id}"),
      body: {
        "id" : widget.id,
      }
      ).then((value) {
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
        title: Center(child: Text('Ubah Berita')),
        actions: [
          Container(
            child: IconButton(
              onPressed: () {
                showDialog(context: context, 
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Apakah Ingin Menghapus Berita Ini?"),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(), 
                        child: Icon(Icons.cancel)),
                      ElevatedButton(
                        onPressed: () => _onDelete(), 
                        child: Icon(Icons.check_circle)
                        )
                    ],
                  );
                  }
                );
              }, 
              icon: Icon(Icons.delete)
            ),
          )
        ],
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
                    _onUpdate();
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