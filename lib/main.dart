import 'package:flutter/material.dart';
import 'package:videocallingapp/chat.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_zimkit/services/services.dart';

void main() async {
  await ZIMKit().init(
    appID: 280310796, // your appid
    appSign:
        '650b9e7ab813be9b1a0067515412442df902a8b0c01a185484c57c58581710c8', // your appSign
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final formkey = GlobalKey<FormState>();
  final namecontroller = TextEditingController(text: 'USER-NAME');
  final idcontroller = TextEditingController(text: 'ID');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Video call app',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: idcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        await ZIMKit().connectUser(
                            id: idcontroller.text, name: namecontroller.text);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const ZIMKitDemoHomePage(),
                          ),
                        );
                      },
                      child: Text("Chat")),
                )
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CallPage(
                callID: "1",
                username: namecontroller.text.toString(),
                id: idcontroller.text.toString(),
              ),
            ),
          );
        },
        child: Text('call'),
      ),
    );
  }
}

class CallPage extends StatelessWidget {
  const CallPage(
      {Key? key,
      required this.callID,
      required this.username,
      required this.id})
      : super(key: key);
  final String callID;
  final String username;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          280310796, 
      appSign:
          '650b9e7ab813be9b1a0067515412442df902a8b0c01a185484c57c58581710c8',
      userID: id,
      userName: username,
      callID: callID,
      
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (_) => Navigator.of(context).pop(),
    );
  }
}
