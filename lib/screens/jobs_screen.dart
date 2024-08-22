import 'package:flutter/material.dart';
import 'package:jobs_app/screens/login_screen.dart';
import 'action_tab.dart';

class JobsScreen extends StatelessWidget {
  final String userid;
  const JobsScreen({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text("Jobs"),
          backgroundColor: Colors.grey[300],
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.people_alt)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0)),
                child: TabBar(
                  indicator: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25.0)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  splashBorderRadius: BorderRadius.circular(25.0),
                  dividerHeight: 0,
                  tabs: const [
                    Tab(text: "ACTION"),
                    Tab(
                      text: "FOLLOW UP",
                    ),
                    Tab(
                      text: "REVIEW",
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TabBarView(
                  children: [
                    ActionTab(
                      actUserid: userid,
                    ),
                    const Center(child: Text("FOLLOW UP Tab")),
                    const Center(child: Text("REVIEW Tab")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}