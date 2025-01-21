import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class  MyApp extends StatelessWidget {
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
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      "image": "assets/img1.png",
      "title": "Find Nearby Parking Spots with Ease",
      "subtitle": "Discover new  way of Parking Solution with Us."
    },
    {
      "image": "assets/img2.png",
      "title": "Save your Favourite Parking Spots for Later",
      "subtitle": "Become our Family member with Prime Subscriptions."
    },
    {
      "image": "assets/img3.png",
      "title": "The Easiest Way to Track Your Parking Booking",
      "subtitle": "Track your progress and achieve your dreams."
    },
    {
      "image": "assets/img4.png",
      "title": "Explore More",
      "subtitle": "Find new opportunities and experiences."
    },
    {
      "image": "assets/img5.png",
      "title": "community support",
      "subtitle": "Enjoy features tailored to your needs."
    },
    {
      "image": "assets/img6.png",
      "title": "let's get started",
      "subtitle": "Let’s begin the journey together!"
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (_currentPage != pages.length - 1) // Show SKIP button
            TextButton(
              onPressed: () {
                _pageController.jumpToPage(pages.length - 1);
              },
              child: const Text(
                'SKIP',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return _buildPageContent(
            image: pages[index]["image"]!,
            title: pages[index]["title"]!,
            subtitle: pages[index]["subtitle"]!,
          );
        },
      ),
      bottomSheet: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Previous Button
            _currentPage > 0
                ? ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15),
                      backgroundColor: Colors.purple,
                      foregroundColor: Color.fromARGB(255, 245, 241, 241),
                    ),
                    child: const Icon(Icons.arrow_back, size: 24),
                  )
                : const SizedBox(width: 60), // Placeholder for alignment

            // Indicators
            Row(
              children: List<Widget>.generate(pages.length, (int index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 10,
                  width: (index == _currentPage) ? 20 : 10,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color:
                        (index == _currentPage) ? Color.fromARGB(255, 249, 143, 5) : Color.fromARGB(255, 244, 167, 90),
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
            ),

            // Next or Get Started Button
            _currentPage < pages.length - 1
                ? ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15),
                      backgroundColor: Colors.purple,
                      foregroundColor: Color.fromARGB(253, 255, 255, 255),
                    ),
                    child: const Icon(Icons.arrow_forward, size: 24),
                  )
                : ElevatedButton(
                    onPressed: () {
                      // Navigate to HomeScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>const HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('GET STARTED'),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image at the top
          Image.asset(image, height: 300, fit: BoxFit.contain),
          const SizedBox(height: 40),

          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Subtitle
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.black26,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// HomeScreen widget
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
