import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class QuranApiService {
  static const String _baseUrl = 'http://api.alquran.cloud/v1';
  static const String _surahListKey = 'cachedSurahList'; // Key for SharedPreferences


  // Fetch list of available editions
  Future<List<dynamic>> getEditions({String format = 'text', String language = 'en', String type = 'translation'}) async {
    final response = await http.get(Uri.parse('$_baseUrl/edition?format=$format&language=$language&type=$type'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load editions');
    }
  }

  // Fetch list of Surahs
  // Future<List<dynamic>> getSurahList({String edition = 'quran-uthmani'}) async {
  //   final response = await http.get(Uri.parse('$_baseUrl/quran/$edition'));

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     return data['data']['surahs'];
  //   } else {
  //     throw Exception('Failed to load Surahs');
  //   }
  // }

  // Fetch Surah list with caching
  Future<List<dynamic>> getSurahList({String edition = 'quran-uthmani'}) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_surahListKey);

    if (cachedData != null) {
      print('Loaded Surah list from cache');
      return jsonDecode(cachedData);
    } else {
      print('Fetching Surah list from API');
      final response = await http.get(Uri.parse('$_baseUrl/quran/$edition'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data']['surahs'];
        // Cache the fetched data
        prefs.setString(_surahListKey, jsonEncode(data));
        return data;
      } else {
        throw Exception('Failed to load Surahs');
      }
    }
  }

  // Fetch verses of a specific Surah
  Future<List<dynamic>> getSurahVerses(int surahNumber, {String edition = 'quran-uthmani'}) async {
    final response = await http.get(Uri.parse('$_baseUrl/surah/$surahNumber/$edition'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['ayahs'];
    } else {
      throw Exception('Failed to load Surah verses');
    }
  }


    // Fetch verses of a specific Surah along with Swahili translation
  Future<Map<String, List<dynamic>>> getSurahWithTranslation(int surahNumber, {String arabicEdition = 'quran-uthmani', String translationEdition = 'sw.barwani'}) async {
    final arabicResponse = await http.get(Uri.parse('$_baseUrl/surah/$surahNumber/$arabicEdition'));
    final translationResponse = await http.get(Uri.parse('$_baseUrl/surah/$surahNumber/$translationEdition'));

    if (arabicResponse.statusCode == 200 && translationResponse.statusCode == 200) {
      final arabicData = jsonDecode(arabicResponse.body);
      final translationData = jsonDecode(translationResponse.body);

      return {
        'arabic': arabicData['data']['ayahs'],
        'translation': translationData['data']['ayahs'],
      };
    } else {
      throw Exception('Failed to load Surah verses or translation');
    }
  }

  // Fetch list of languages in which editions are available
  Future<List<dynamic>> getLanguages() async {
    final response = await http.get(Uri.parse('$_baseUrl/edition/language'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load languages');
    }
  }


   // Fetch the list of available audio editions
  Future<List<dynamic>> getAudioEditions() async {
    final response = await http.get(Uri.parse('$_baseUrl/edition?format=audio'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load audio editions');
    }
  }

  // Fetch audio URL for a specific Surah using an audio edition identifier
  Future<String> getSurahAudioUrl(int surahNumber, {String editionId = 'ar.alafasy'}) async {
    final response = await http.get(Uri.parse('$_baseUrl/surah/$surahNumber/$editionId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['ayahs'][0]['audio'];
    } else {
      throw Exception('Failed to load Surah audio');
    }
  }
}
