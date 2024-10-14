import 'package:flutter/material.dart';
import 'package:tasbih_app/api/quran_api_service.dart';
import 'package:tasbih_app/quran/SurahPage.dart';

class SurahSelectionPage extends StatefulWidget {
  @override
  _SurahSelectionPageState createState() => _SurahSelectionPageState();
}

class _SurahSelectionPageState extends State<SurahSelectionPage> {
  final QuranApiService apiService = QuranApiService();
  late Future<List<dynamic>> surahList;

  @override
  void initState() {
    super.initState();
    surahList = apiService.getSurahList(); // Load from cache or API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 55, 22),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Select Surah',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: surahList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingPlaceholder(); // Show loading UI
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final surahs = snapshot.data!;
            return buildSurahList(surahs); // Build the Surah list
          }
        },
      ),
    );
  }

  Widget buildLoadingPlaceholder() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Container(
            height: 20,
            color: Colors.grey[300],
            margin: const EdgeInsets.symmetric(vertical: 5),
          ),
          subtitle: Container(
            height: 14,
            color: Colors.grey[200],
            margin: const EdgeInsets.only(top: 5),
          ),
        );
      },
    );
  }

  Widget buildSurahList(List<dynamic> surahs) {
    return ListView.separated(
      itemCount: surahs.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey,
      ),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(surahs[index]['englishName']),
          subtitle: Text(surahs[index]['name']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurahPage(
                  surahName: surahs[index]['englishName'],
                  surahIndex: surahs[index]['number'],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
