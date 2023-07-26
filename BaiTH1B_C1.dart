import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My app', // used by the OS task switcher
      home: MyHomeScreen(),
    ),
  );
}

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chu'),
      ),
      body: Center(
        child: Container(
            alignment: Alignment.center,
            width: 390,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'HOME SCREEN',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 20,
                ),
                buildRowLayout(),
                const SizedBox(
                  height: 20,
                ),
                Image.network(
                  'https://dart.dev/assets/shared/dart-logo-for-shares.png?2',
                  height: 100,
                  width: 250,
                ),
                Image.network(
                  'https://www.alisco-it.com/wp-content/uploads/2022/01/Flutter_Featured_Logo.png',
                  height: 100,
                  width: 250,
                ),
                Image.network(
                  'https://pngimg.com/d/android_logo_PNG3.png',
                  height: 150,
                  width: 250,
                ),

                ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Nut da duoc bam!')));
                    },
                    child: const Text('Click here!')),
              ],
            )),
      ),
    );
  }
}

Widget buildRowLayout() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        color: Colors.blue,
        height: 100,
        width: 100,
      ),
      Container(
        color: Colors.green,
        height: 100,
        width: 100,
      ),
      Container(
        color: Colors.orange,
        height: 100,
        width: 100,
      )
    ],
  );
}
