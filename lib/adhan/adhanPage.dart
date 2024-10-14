// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// class AdhanPage extends StatelessWidget {
//   const AdhanPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AudioPlayer audioPlayer = AudioPlayer();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Adhan'),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color.fromARGB(255, 19, 55, 22),
//                 Color.fromARGB(255, 75, 127, 86)
//               ],
//               begin: Alignment.bottomRight,
//               end: Alignment.topLeft,
//             ),
//           ),
//         ),
//       ),
//       backgroundColor: Colors.green[300],
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Adhan is the Islamic call to prayer.',
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'It is recited five times a day to call Muslims for prayer.',
//                 style: TextStyle(fontSize: 16),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: () async {
//                   // Replace with the path to your Adhan audio file
//                   // await audioPlayer.play('assets/audio/adhan.mp3'); 
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.teal[900], // Background color
//                   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                 ),
//                 child: const Text(
//                   'Play Adhan',
//                   style: TextStyle(fontSize: 20),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class AdhanPage extends StatefulWidget {
  const AdhanPage({Key? key}) : super(key: key);

  @override
  State<AdhanPage> createState() => _AdhanPageState();
}

class _AdhanPageState extends State<AdhanPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _nextPrayerTime;
  String? _cityName = 'Loading...';
  String? _plateCode;
  bool _isAdhanPlaying = false;

  @override
  void initState() {
    super.initState();
    _getLocationAndFetchPrayerTimes();
  }

  // Updated to handle permission and location service checks
  Future<void> _getLocationAndFetchPrayerTimes() async {
    try {
      Position position = await _determinePosition();
      _plateCode = await _getPlateCode(position.latitude, position.longitude);

      if (_plateCode != null) {
        await _fetchPrayerTimes(_plateCode!);
      }
    } catch (e) {
      _showErrorSnackBar(e.toString());
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled. Please enable them.');
    }

    // Check and request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<String?> _getPlateCode(double latitude, double longitude) async {
    String apiUrl = 'https://api.example.com/reverse?lat=$latitude&lon=$longitude';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['plate'];
    } else {
      throw Exception('Failed to fetch plate code: ${response.statusCode}');
    }
  }

  Future<void> _fetchPrayerTimes(String plateCode) async {
    final String apiUrl = 'https://ezan-vakitleri-adhan-times.p.rapidapi.com/api/adhan-times?plate=$plateCode';
    final Map<String, String> headers = {
      'x-rapidapi-host': 'ezan-vakitleri-adhan-times.p.rapidapi.com',
      'x-rapidapi-key': '2eb1165eabmsha87faf93783bacep147ce8jsnf9c63bc05a71',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final timings = data['data'];

        setState(() {
          _cityName = data['city_en'];
          _nextPrayerTime = _getNextPrayerTime(timings);
        });
      } else {
        throw Exception('Failed to fetch prayer times: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorSnackBar(e.toString());
    }
  }

  String _getNextPrayerTime(List<dynamic> timings) {
    final now = DateTime.now();
    for (var time in timings) {
      final prayerTime = DateTime.parse(time['time']);
      if (now.isBefore(prayerTime)) {
        return time['time'];
      }
    }
    return 'No more prayers today';
  }

  void _playAdhan() async {
    if (_nextPrayerTime != null && !_isAdhanPlaying) {
      setState(() {
        _isAdhanPlaying = true;
      });
      await _audioPlayer.play(UrlSource('https://www.islamcan.com/audio/adhan/azan1.mp3'));
      _audioPlayer.onPlayerComplete.listen((_) {
        setState(() {
          _isAdhanPlaying = false;
        });
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adhan'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 19, 55, 22),
                Color.fromARGB(255, 75, 127, 86),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/tasbih_.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white.withOpacity(0.9),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'City: $_cityName',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _nextPrayerTime != null
                          ? 'Next Prayer Time: $_nextPrayerTime'
                          : 'Loading prayer times...',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _playAdhan,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[900],
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        _isAdhanPlaying ? 'Playing...' : 'Play Adhan',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
