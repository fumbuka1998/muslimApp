import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tasbih_app/adhan/AdhanPage.dart';
import 'package:tasbih_app/quran/SurahSelectionPage.dart';
import 'package:tasbih_app/screen/homescreen.dart';

class TasbihPage extends StatefulWidget {
  const TasbihPage({super.key});

  @override
  State<TasbihPage> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AudioPlayer audioPlayer = AudioPlayer();
  int count = 0;

  void playSound1() async {
    await audioPlayer.play(AssetSource('assets/analog-sound.mp3'));
  }

  void playSound2() async {
    await audioPlayer.play(AssetSource('assets/pop-up-sound.mp3'));
  }

  void counter() {
    setState(() {
      playSound1();
      count++;
    });
  }

  void reset() {
    setState(() {
      playSound2();
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'My Tasbeeh',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // Handle search button press
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {
              // Handle more button press
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 19, 55, 22),
                Color.fromARGB(255, 75, 127, 86)
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        elevation: 10.0,
        shadowColor: const Color.fromARGB(255, 113, 77, 119),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 19, 55, 22),
              ),
              child: Text(
                'Dini-Yangu Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading:Image.asset(
                'assets/house.png',  
                width: 40,  
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.broken_image), // Handles errors gracefully
              ),
              title: const Text('Home'),
              onTap: () {
                // Handle navigation to Home== HomeScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/qrn.png',  
                width: 40,  
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.broken_image), // Handles errors gracefully
              ),
              title: const Text('Quran'),
              onTap: () {
                // Handle navigation to Quran
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurahSelectionPage()),
                );
              },
            ),
            ListTile(
              leading:  Image.asset(
                'assets/tasbih_.png',  
                width: 40,  
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.broken_image), // Handles errors gracefully
              ),
              title: const Text('Tasbih'),
              onTap: () {
                // Handle navigation to Tasbih
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurahSelectionPage()),
                );
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/dua.png',  
                width: 40,  
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.broken_image), // Handles errors gracefully
              ),
              title: const Text('Dua'),
              onTap: () {
                // Handle navigation to Dua
              },
            ),

            ListTile(
              leading: Image.asset(
                'assets/adhan_.png',  
                width: 40,  
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.broken_image), // Handles errors gracefully
              ),
              title: const Text('Adhan'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdhanPage()),
                );
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/hadith.png',  
                width: 40,  
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.broken_image), // Handles errors gracefully
              ),
              title: const Text('Hadith'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdhanPage()),
                );
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/setting_.png',  
                width: 40,  
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.broken_image), // Handles errors gracefully
              ),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdhanPage()),
                );
              },
            ),

            ListTile(
              leading: Image.asset(
                'assets/info.png',  
                width: 40,  
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.broken_image), // Handles errors gracefully
              ),
              title: const Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdhanPage()),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.green[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.teal[900],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    color: Colors.white.withOpacity(.5),
                    spreadRadius: 7,
                    blurRadius: 5,
                  )
                ],
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    count.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -50),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.teal[900],
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 5),
                      color: Colors.white.withOpacity(.5),
                      spreadRadius: 0,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: counter,
                      style: ElevatedButton.styleFrom(
                          maximumSize: const Size(80, 80)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.teal[900],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: reset,
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red[700]),
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
