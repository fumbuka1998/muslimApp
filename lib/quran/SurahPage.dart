

// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:tasbih_app/api/quran_api_service.dart';

// class SurahPage extends StatefulWidget {
//   final String surahName;
//   final int surahIndex;

//   SurahPage({required this.surahName, required this.surahIndex});

//   @override
//   _SurahPageState createState() => _SurahPageState();
// }

// class _SurahPageState extends State<SurahPage> {
//   final QuranApiService apiService = QuranApiService();
//   late Future<List<dynamic>> surahVerses;
//   final AudioPlayer audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   String audioUrl = '';

//   @override
//   void initState() {
//     super.initState();
//     surahVerses = apiService.getSurahVerses(widget.surahIndex);
//     fetchSurahAudioUrl();
//   }

//   Future<void> fetchSurahAudioUrl() async {
//     try {
//       final url = await apiService.getSurahAudioUrl(widget.surahIndex);
//       setState(() {
//         audioUrl = url;
//       });
//     } catch (e) {
//       print('Failed to load audio URL: $e');
//     }
//   }

//   void toggleAudio() async {
//     if (isPlaying) {
//       await audioPlayer.pause();
//     } else {
//       await audioPlayer.play(UrlSource(audioUrl));
//     }
//     setState(() {
//       isPlaying = !isPlaying;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 19, 55, 22),
//          iconTheme: IconThemeData(color: Colors.white), 
//         title: Text(
//           widget.surahName,
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//         actions: [
//           if (audioUrl.isNotEmpty)
//             IconButton(
//               icon: Icon(
//                 isPlaying ? Icons.pause : Icons.play_arrow,
//                 size: 36.0,
//                 color: Colors.white,
//               ),
//               onPressed: toggleAudio,
//             )
//           else
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text('Audio not available', style: TextStyle(color: Colors.white)),
//             ),
//         ],
//       ),
//       body: Column(
//         children: [
//           FutureBuilder<List<dynamic>>(
//             future: surahVerses,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else {
//                 final verses = snapshot.data!;
//                 return Expanded(
//                   child: ListView.builder(
//                     itemCount: verses.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           verses[index]['text'],
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tasbih_app/api/quran_api_service.dart';

class SurahPage extends StatefulWidget {
  final String surahName;
  final int surahIndex;

  SurahPage({required this.surahName, required this.surahIndex});

  @override
  _SurahPageState createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  final QuranApiService apiService = QuranApiService();
  late Future<Map<String, List<dynamic>>> surahWithTranslation;
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String audioUrl = '';

  @override
  void initState() {
    super.initState();
    surahWithTranslation = apiService.getSurahWithTranslation(widget.surahIndex);
    fetchSurahAudioUrl();
  }

  Future<void> fetchSurahAudioUrl() async {
    try {
      final url = await apiService.getSurahAudioUrl(widget.surahIndex);
      setState(() {
        audioUrl = url;
      });
    } catch (e) {
      print('Failed to load audio URL: $e');
    }
  }

  void toggleAudio() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(UrlSource(audioUrl));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 55, 22),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.surahName,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          if (audioUrl.isNotEmpty)
            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 36.0,
                color: Colors.white,
              ),
              onPressed: toggleAudio,
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Audio not available', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder<Map<String, List<dynamic>>>(
            future: surahWithTranslation,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final arabicVerses = snapshot.data!['arabic']!;
                final translationVerses = snapshot.data!['translation']!;

                return Expanded(
                  child: ListView.builder(
                    itemCount: arabicVerses.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              arabicVerses[index]['text'],
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              translationVerses[index]['text'],
                              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey[700]),
                            ),
                            Divider(color: Colors.grey),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
