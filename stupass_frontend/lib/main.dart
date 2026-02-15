import 'package:flutter/material.dart';
import 'package:stupass_frontend/core/theme/app_dimens.dart';
import 'features/account/presentation/setting_page.dart';
import 'features/home/presentation/marketplace_page.dart';
import 'features/chat/presentation/chat_box_page.dart';
import 'features/storage/presentation/storage.dart';
import 'features/home/presentation/add_post_page.dart';
import 'core/components/navigation_bottomappbar.dart';

void main() {
  runApp(const StuPassApp());
}

class StuPassApp extends StatelessWidget {
  const StuPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StuPass',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  List<Widget> pages = [
    MarketplacePage(),
    StoragePage(),
    AddPostPage(),
    ChatBoxPage(),
    SettingPage(),
  ];

  void onDestinationSelected(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (context) => const AddPostPage()),
            );
          },
          backgroundColor: Colors.green,
          elevation: 0,
          mini: true,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: AppDimens.iconDefault),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBottomAppBar(
        currentPageIndex: currentPageIndex,
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}
