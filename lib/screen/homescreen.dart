import 'package:flutter/material.dart';
import 'package:tasbih_app/adhan/AdhanPage.dart';
import 'package:tasbih_app/quran/SurahSelectionPage.dart';
import 'package:tasbih_app/settings/setting.dart';
import 'package:tasbih_app/tasbih/TasbihPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Dini Yangu',
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
                Color.fromARGB(255, 52, 118, 52),
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
              leading: Image.asset(
                'assets/house.png',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.broken_image), // Handles errors gracefully
              ),
              title: const Text('Home'),
              onTap: () {
                // Handle navigation to Home
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurahSelectionPage()),
                );
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/tasbih_.png',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.broken_image), // Handles errors gracefully
              ),
              title: const Text('Tasbih'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TasbihPage()),
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
                  MaterialPageRoute(builder: (context) => SettingsPage()),
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
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            _buildGridItem(
              imagePath: 'assets/qrn.png',
              label: 'Quran',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurahSelectionPage()),
                );
              },
            ),
            _buildGridItem(
              imagePath: 'assets/tasbih_.png',
              label: 'Tasbih',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TasbihPage()),
                );
              },
            ),
            _buildGridItem(
              imagePath: 'assets/adhan_.png',
              label: 'Adhana',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdhanPage()),
                );
              },
            ),
            _buildGridItem(
              imagePath: 'assets/dua.png',
              label: 'Dua',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdhanPage()),
                );
              },
            ),
             _buildGridItem(
              imagePath: 'assets/hadith.png',
              label: 'Hadith',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdhanPage()),
                );
              },
            ),
            _buildGridItem(
              imagePath: 'assets/setting_.png',
              label: 'Settings',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(
      {required String imagePath,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.teal[900],
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 60, // Adjust as needed
              height: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

//   Widget _buildGridItem({
//   required String imagePath,
//   required String label,
//   required VoidCallback onTap,
// }) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(8), // Optional: Rounds the corners
//           child: Image.asset(
//             imagePath,
//             width: 100, // Adjust as needed
//             height: 100,
//             fit: BoxFit.cover, // Ensures the image fills the widget without distortion
//             errorBuilder: (context, error, stackTrace) =>
//                 const Icon(Icons.broken_image), // Handles broken images
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ],
//     ),
//   );
// }

}
