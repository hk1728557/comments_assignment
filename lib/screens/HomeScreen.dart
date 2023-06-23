import 'package:add_comments/screens/DataContainer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: const Text(
          "Card",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          //Add Context Container
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color.fromARGB(255, 251, 248, 248),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 212, 210, 210),
                    spreadRadius: 5,
                    blurRadius: 15),
              ],
            ),
            height: 250,
            width: 450,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  height: 60,
                  width: 450,
                  child: const Center(
                    child: Text(
                      "Add Comments",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  child: Lottie.asset(
                    'assets/lottie/credit_card.json',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          //Show search box Container
          _buildSearchBar(),

          //Show Data container
          const DataContainer()
        ],
      ),
    );
  }

  //create method
  Container _buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color.fromARGB(221, 249, 247, 247),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 212, 210, 210),
            spreadRadius: 5,
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Search",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          prefixIcon: Container(
            margin: EdgeInsets.only(left: 20, right: 15),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, size: 30),
            ),
          ),
        ),
      ),
    );
  }
}
