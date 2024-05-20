import 'dart:convert';
import 'package:http/http.dart' as http;

class DynapicturesService {
  final String apiKey;
  final String designUID;

  DynapicturesService({required this.apiKey, required this.designUID});

  Future<Map<String, dynamic>> generateImage(Map<String, dynamic> params) async {
    final url = Uri.parse('https://api.dynapictures.com/designs/$designUID');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(params),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to generate image: ${response.body}');
      throw Exception('Failed to generate image: ${response.body}');
    }
  }
}
