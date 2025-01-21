import 'package:flutter/material.dart';

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
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      "image": "assets/mock1.png",
      "title": "Find Nearby Parking Spots with Ease",
      "subtitle": "Discover new way of Parking Solution with Us."
    },
    {
      "image": "assets/mock2.png",
      "title": "Save your Favourite Parking Spots for Later",
      "subtitle": "Become our Family member with Prime Subscriptions."
    },
    {
      "image": "assets/mock3.png",
      "title": "The Easiest Way to Track Your Parking Booking",
      "subtitle": "Track your progress and achieve your dreams."
    },
    {
      "image": "assets/mock4.png",
      "title": "Explore More",
      "subtitle": "Find new opportunities and experiences."
    },
    {
      "image": "assets/mock5.png",
      "title": "Community Support",
      "subtitle": "Enjoy features tailored to your needs."
    },
    {
      "image": "assets/mock6.png",
      "title": "Let's Get Started",
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
          if (_currentPage != pages.length - 1)
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
      body: Stack(
        children: [
          // Background with ClipPath
          ClipPath(
            clipper: CurvedClipper(),
            child: Container(
              color: Color.fromARGB(255, 238, 159, 238).withOpacity(0.1),
            ),
          ),

          // PageView
          PageView.builder(
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
        ],
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
                      foregroundColor: const Color.fromARGB(255, 245, 241, 241),
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
                    color: (index == _currentPage)
                        ? Color.fromARGB(234, 90, 36, 113)
                        : Color.fromARGB(255, 128, 88, 220),
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
                      foregroundColor: const Color.fromARGB(253, 255, 255, 255),
                    ),
                    child: const Icon(Icons.arrow_forward, size: 24),
                  )
                : ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      backgroundColor: const Color.fromARGB(255, 245, 241, 241),
                      foregroundColor: const Color.fromARGB(15, 3, 1, 5),
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
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image, height: 260, fit: BoxFit.contain),
          const SizedBox(height: 100),
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
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

// Custom Clipper for Curved Background
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.6); // Lower the start
path.quadraticBezierTo(
  size.width / 2,
  size.height * 0.2, // Adjust the curve height
  size.width,
  size.height * 0.6, // Match start and end
);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
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

