import 'package:flutter/material.dart';
import 'package:tes/pages/login_page.dart';
import 'package:tes/widgets/onboarding2.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            controller: _pageViewController,
            onPageChanged: _handlePageViewChanged,
            children: <Widget>[
              Center(
                child: Text('First Page', style: textTheme.titleLarge),
              ),
              const Onboarding2(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    )
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          PageIndicator(
            tabController: _tabController,
            currentPageIndex: _currentPageIndex,
            onUpdateCurrentPageIndex: _updateCurrentPageIndex,
            isOnDesktopAndWeb:
                true, // Ubah ini untuk selalu menampilkan page indicator
          ),
        ],
      ),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.isOnDesktopAndWeb,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // IconButton(
              //   splashRadius: 16.0,
              //   padding: EdgeInsets.zero,
              //   onPressed: () {
              //     if (currentPageIndex == 0) {
              //       return;
              //     }
              //     onUpdateCurrentPageIndex(currentPageIndex - 1);
              //   },
              //   icon: const Icon(
              //     Icons.arrow_left_rounded,
              //     size: 32.0,
              //   ),
              // ),
              TabPageSelector(
                controller: tabController,
                color: colorScheme.surface,
                selectedColor: colorScheme.primary,
              ),
              const SizedBox(
                width: 100,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  if (currentPageIndex == 2) {
                    return;
                  }
                  onUpdateCurrentPageIndex(currentPageIndex + 1);
                },
                child: const Text(
                  'Selanjutnya',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // IconButton(
              //   splashRadius: 16.0,
              //   padding: EdgeInsets.zero,
              //   onPressed: () {
              //     if (currentPageIndex == 2) {
              //       return;
              //     }
              //     onUpdateCurrentPageIndex(currentPageIndex + 1);
              //   },
              //   icon: const Icon(
              //     Icons.arrow_right_rounded,
              //     size: 32.0,
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
