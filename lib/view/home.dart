import 'package:flutter/material.dart';

import 'package:simple_api/model/user_model.dart';
import 'package:simple_api/service/user_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Users"),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          //final name = user['name']['first'];
          // final email = user.email;
          final phone = user.phone;
          // final color = user.gender == 'male'
          //     ? const Color.fromARGB(255, 228, 129, 246)
          //     : Color.fromARGB(255, 216, 111, 146);
          // final imageUrl = user['picture']['thumbnail'];

          return ListTile(
            // leading: ClipRRect(
            //   borderRadius: BorderRadius.circular(100),
            //   child: Image.network(imageUrl)),
            title: Text(user.fullName),
            subtitle: Text(phone),
            //tileColor: color,
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   fetchUsers();
      // }),
    );
  }

  Future<void> fetchUsers() async {
    final response = await UserApi.fetchUsers();
    setState(() {
      users = response;
    });
  }
}
