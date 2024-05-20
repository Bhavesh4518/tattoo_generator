import 'package:artbox/controllers/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TattooGenerationScreen extends StatelessWidget {
  TattooGenerationScreen({super.key});

  final TextEditingController _textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageGenerationController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Generate Tattoo with AI',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 12),
              TextFormField(
                maxLength: 50,
                maxLines: 5,
                style: TextStyle(
                  color: Colors.blueGrey.shade800,
                  fontWeight: FontWeight.bold,
                ),
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Enter tattoo description...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    controller.generateImage(_textController.text);
                  },
                  child: Text('Generate Tattoo'),
                ),
              ),
              SizedBox(height: 20.0),


            ],
          ),
        ),
      ),
    );
  }
}
