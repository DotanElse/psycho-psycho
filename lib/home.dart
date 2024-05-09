import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home_body.dart';
import 'pages/analytics_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void ChangeOrientation(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: homeAppBar(theme),
      body: PageView(
        controller: _pageController,
        children: [
          HomeScreen(),
          AnalyticsScreen(),
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: bottomNavBar(theme),
    );
  }

  AppBar homeAppBar(ThemeData theme) {
    return AppBar(
      title: Text(
        'PsychoPsycho',
        style: TextStyle(color: theme.colorScheme.onPrimary),
      ),
      actions: [
      IconButton(
      icon: Icon(Icons.rotate_left),
      onPressed: () => ChangeOrientation(context),
      ),
      ],
      backgroundColor: theme.colorScheme.primary,
      centerTitle: true,
    );

  }

  Widget bottomNavBar(ThemeData theme) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: theme.colorScheme.onPrimary),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics, color: theme.colorScheme.onPrimary),
          label: 'Analytics',
        ),
      ],
      backgroundColor: theme.colorScheme.primary,
      selectedItemColor: theme.colorScheme.onPrimary,
      unselectedItemColor: theme.colorScheme.onPrimary.withOpacity(0.6),
    );
  }
}
