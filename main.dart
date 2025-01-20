import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: List.generate(6, (index) => buildPage(index)),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                if (_pageController.page! > 0) {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_forward, color: Colors.white),
              onPressed: () {
                if (_pageController.page! < 5) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 6,
                effect: const WormEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  activeDotColor: Colors.white,
                  dotColor: Colors.grey,
                ),
                onDotClicked: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(int index) {
    return Stack(
      children: [
        Container(
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text(
              'Page ${index + 1}',
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 80,
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 6,
                effect: const WormEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  activeDotColor: Colors.white,
                  dotColor: Colors.grey,
                ),
                onDotClicked: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
