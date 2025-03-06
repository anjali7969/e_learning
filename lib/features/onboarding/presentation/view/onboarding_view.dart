import 'package:e_learning/app/di/di.dart';
import 'package:e_learning/app/shared_prefs/onboarding_shared_prefs.dart';
import 'package:e_learning/features/auth/presentation/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF81D4FA), // Light blue
                Color(0xFFFFFFFF), // White
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: onboardingData.length,
                      itemBuilder: (context, index) {
                        return _buildOnboardingContent(
                          image: onboardingData[index]['image']!,
                          title: onboardingData[index]['title']!,
                          description: onboardingData[index]['description']!,
                        );
                      },
                    ),

                    // Skip Button (Only on First and Second Page)
                    if (_currentPage < onboardingData.length - 1)
                      Positioned(
                        top: 50,
                        right: 20,
                        child: GestureDetector(
                          onTap: () {
                            _pageController
                                .jumpToPage(onboardingData.length - 1);
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              _buildBottomControls(),
            ],
          ),
        ),
      ),
    );
  }

  /// **📌 Build Onboarding Content**
  Widget _buildOnboardingContent({
    required String image,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// **📌 Bottom Navigation Controls**
  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Column(
        children: [
          // **Dot Indicator**
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => _buildDot(index),
            ),
          ),
          const SizedBox(height: 20),

          // **Gradient Button**
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.black, Colors.blueAccent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (_currentPage == onboardingData.length - 1) {
                  getIt<OnboardingSharedPrefs>().saveFirstTime();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterView()),
                  );
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Text(
                _currentPage == onboardingData.length - 1
                    ? 'Get Started'
                    : 'Next',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// **📌 Dot Indicator**
  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue[700] : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

/// **📌 Onboarding Data (Images & Texts)**
const List<Map<String, String>> onboardingData = [
  {
    'image': 'assets/images/onboarding4.png',
    'title': 'Enter the World of E-Learning',
    'description':
        'Begin your educational journey with access to a diverse range of courses.',
  },
  {
    'image': 'assets/images/onboarding5.png',
    'title': 'Embark on Your Learning Adventure',
    'description':
        'Explore interactive lessons, quizzes, and multimedia content to enhance your understanding.',
  },
  {
    'image': 'assets/images/onboarding6.png',
    'title': 'Unlock Your Learning Potential',
    'description':
        'Your gateway to personalized courses and guidance for success.',
  },
];
