import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};
  bool newLocation = false;

  @override
  Widget build(BuildContext context) {

    data = newLocation ? data : ModalRoute.of(context)!.settings.arguments as Map;
    // print(data['isDayTime']);

    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png' ;
    Color? bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[900];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async{
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'flag': result['flag'],
                        'isDayTime': result['isDayTime']
                      };
                      newLocation = true;
                    });
                  },
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14.0,
                      letterSpacing: 1.0
                    ),
                  ),
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: const TextStyle(
                        fontSize: 28.0,
                        color: Colors.white,
                        letterSpacing: 2.0
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['time'],
                      style: const TextStyle(
                          fontSize: 66.0,
                          color: Colors.white,
                          letterSpacing: 2.0
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
