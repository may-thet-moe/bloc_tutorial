import 'package:bloc_tutorial/view/account/account.dart';
import 'package:bloc_tutorial/view/dashboard/dashboard_screen.dart';
import 'package:bloc_tutorial/view/search/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          tabs: [
            Tab( icon: Icon(Icons.home),),
            Tab(icon: Icon(Icons.search),),
            Tab(icon: Icon(Icons.person),)
          ]) ,
        body: TabBarView(
          children: [
            DashboardScreen(),
            SearchScreen(),
            AccountScreen()
          ]),
      ),
    );
  }
}