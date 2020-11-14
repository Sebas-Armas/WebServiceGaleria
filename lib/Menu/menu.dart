import 'package:app_camara_y_web_service/Camara/camara.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_camara_y_web_service/WebService/webservice.dart';

class MenuPage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cámara y Web Service"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          ListTile(
            title: MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage())
                  );
                },
                child: Text(
                  "Camara",
                  style: TextStyle(color: Colors.white),
                ),
                height: 40.0,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
          ),
          ListTile(
            title: MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WebServicePage())
                  );
                },
                child: Text(
                  "Web Service",
                  style: TextStyle(color: Colors.white),
                ),
                height: 40.0,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
          )
        ],
      ),
    );
  }
}