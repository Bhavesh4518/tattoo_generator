

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/on_boarding_controller.dart';


class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});
  final controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D1B2A) , Color(0xFF000000)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingWidget(
                image: 'assets/demo_tattoo/search.png',
                title: "Search which tattoo you want to try",
                subtitle: "You can easily find any tattoo by searching it",
              ),
              OnBoardingWidget(
                image: 'assets/demo_tattoo/ai.png',
                title: "Not found in List?",
                subtitle: "Don't worry! You can generate your own tattoo with AI",
              ),
              OnBoardingWidget(
                image: 'assets/demo_tattoo/girl.png',
                title: "You can try it on several body parts",
                subtitle: 'See how you look with tattoo',
              ),
            ],
          ),
          const OnBoardingSkipWidget(),
          OnBoardingNavigationDots(),
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //  final dark = MyHelperFunctions.isDarkMode(context);
    return Positioned(
        right: 24,
        bottom: kBottomNavigationBarHeight - 10,
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade900,
                  shape: const CircleBorder()),
              onPressed: () {
                OnBoardingController.instance.nextPage();
              },
              child: const Icon(Icons.arrow_forward_ios_rounded)),
        ));
  }
}

class OnBoardingNavigationDots extends StatelessWidget {
  final controller = OnBoardingController.instance;
  OnBoardingNavigationDots({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //   final dark = MyHelperFunctions.isDarkMode(context);
    return Positioned(
        left: 18,
        bottom: kBottomNavigationBarHeight + 15,
        child: SmoothPageIndicator(
            effect: ExpandingDotsEffect(
                activeDotColor:  Colors.blueGrey.shade900,
                dotHeight: 6),
            controller: controller.pageController,
            onDotClicked: controller.dotNavigationClick,
            count: 3));
  }
}

class OnBoardingSkipWidget extends StatelessWidget {
  const OnBoardingSkipWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //  final dark = MyHelperFunctions.isDarkMode(context);
    return Positioned(
        top: kToolbarHeight,
        right: 5,
        child: TextButton(
          onPressed: () => OnBoardingController.instance.skipPage(),
          child: const Text(
            'skip',
            style: TextStyle(color: Colors.blue, fontSize: 12),
          ),
        ));
  }
}

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });
  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox( height: MediaQuery.of(context).size.height * 0.05,),
        Image(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.6,
            image: AssetImage(image)),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
