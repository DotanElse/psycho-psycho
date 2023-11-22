import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          ToolsScreen(),
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
      backgroundColor: theme.colorScheme.primary,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: FittedBox(
            child: Icon(
              Icons.analytics,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            width: (AppBar().preferredSize.height - 20),
            height: (AppBar().preferredSize.height - 20),
            child: FittedBox(
              child: Icon(
                Icons.settings,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        )
      ],
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
          icon: Icon(Icons.book, color: theme.colorScheme.onPrimary),
          label: 'Tools',
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Screen'),
    );
  }
}

class ToolsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tools Screen'),
    );
  }
}

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Analytics Screen'),
    );
  }
}
