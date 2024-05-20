import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> generateTattooFromText(String text) async {
  // Replace 'YOUR_TEXT_HERE' with the actual text description
  final response = await http.post(
    'https://api.deepai.org/api/text2img' as Uri,
    headers: {
      'Content-Type': 'application/json',
      'api-key': '6c441352-5804-4380-97d3-69ed7de2824a', // Replace with your API key
    },
    body: '{"text": "$text"}',
  );
  print('RES : $response');

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    // Handle the response data, which may contain the generated image URL or other details
    print(data);
  } else {
    throw Exception('Failed to generate tattoo: ${response.reasonPhrase}');
  }
}
