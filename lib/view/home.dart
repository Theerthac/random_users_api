import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_api/model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];

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
          final email = user.email;
          final phone = user.phone;
          // final color = user.gender == 'male'
          //     ? const Color.fromARGB(255, 228, 129, 246)
          //     : Color.fromARGB(255, 216, 111, 146);
          // final imageUrl = user['picture']['thumbnail'];

          return ListTile(
            // leading: ClipRRect(
            //   borderRadius: BorderRadius.circular(100),
            //   child: Image.network(imageUrl)),
            title: Text(user.name.first),
            subtitle: Text(phone),
            //tileColor: color,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        fetchUsers();
      }),
    );
  }

  void fetchUsers() async {
    final url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final transformed = results.map((e) {
      final name = UserName(
        title: e['name']['title'],
        first: e['name']['first'],
        last: e['name']['last'],
      );
      return User(
        gender: e['gender'],
        email: e['email'],
        phone: e['phone'],
        cell: e['cell'],
        nat: e['nat'], 
        name: name,
        
      );
    }).toList();
    setState(() {
      users = transformed;
    });
    print('fetch users completed');
  }
}
