import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ImageGenerationController extends GetxController {
  RxString generatedImageUrl = ''.obs;
  var apiKey = '8d5b05ff-5b64-4350-98c0-7d078d67049a';

  Future<void> generateImage(String text) async {
    try {
      var response = await http.post(
        Uri.parse('https://api.deepai.org/api/text2img'), // Parsing URL to Uri
        headers: {
          'Content-Type': 'application/json',
          'api-key': apiKey,
        },
        body: '{"text": "$text"}',
      );

      if (response.statusCode == 200) {
        generatedImageUrl.value = response.body;
      } else {
        throw Exception('Failed to generate image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to generate image: $e');
    }
  }

}
