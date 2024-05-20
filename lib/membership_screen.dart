import 'package:flutter/material.dart';

class MembershipScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Membership Levels', style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1F1F1F), // Darker gray
                      Color(0xFF141414), // Even darker gray
                      Color(0xFF0A0A0A), // Almost black
                    ],
                  ),
                ),
                child: Center(child: Text('Oh, You don\'t have any membership right now !',style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: 18),)),
              ),
              SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MembershipCard(title: 'Basic',
                      price: '\$09.99/month',
                      features: '7 images',
                      color: Colors.blue,
                      onPressed: (){},
                  ),
                  MembershipCard(title: 'premium',
                    price: '\$29.99/month',
                    features: '24 images',
                    color: Colors.orange,
                    onPressed: (){},
                  )
                ],
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MembershipCard(title: 'Platinum',
                    price: '\$49.99/month',
                    features: '101 images',
                    color: Colors.grey.shade300,
                    onPressed: (){},
                  ),
                  MembershipCard(title: 'Elite',
                    price: '\$99.99/month',
                    features: 'unlimited images',
                    color: Colors.purple,
                    onPressed: (){},
                  ),

                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}

class MembershipCard extends StatelessWidget {
  final String title;
  final String price;
  final String features;
  final Color color;
  final VoidCallback onPressed;

  const MembershipCard({
    Key? key,
    required this.title,
    required this.price,
    required this.features,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            features,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: onPressed,
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }
}