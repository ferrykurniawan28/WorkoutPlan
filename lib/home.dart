import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workout/add.dart';
import 'package:workout/addworkplan.dart';
import 'package:workout/sugestion.dart';
import 'package:workout/workoutlist.dart';
import 'package:workout/workoutplan.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.index = 0});
  final int index;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selected = 0;
  @override
  void initState() {
    _selected = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout'),
      ),
      floatingActionButton: (_selected == 1)
          ? FloatingActionButton(
              onPressed: () {
                if (_selected == 0) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddWorkout(),
                    ),
                  );
                }
                if (_selected == 1) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddWorkPlan(),
                    ),
                  );
                }
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: ListView(
        shrinkWrap: true,
        children: [
          if (_selected == 0)
            const Center(
              child: SizedBox(
                height: 30,
                child: Text(
                  'Sugestion',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          if (_selected == 0)
            const SizedBox(
              height: 300,
              child: Sugestion(),
            ),
          if (_selected == 0)
            const Center(
              child: SizedBox(
                height: 30,
                child: Text(
                  'Workout List',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          if (_selected == 0)
            const SizedBox(
              height: 700,
              child: Workoutlist(),
            ),
          if (_selected == 1)
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Workoutplan(),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Workout Plan',
            icon: Icon(Icons.person),
          ),
        ],
        currentIndex: _selected,
        selectedIconTheme: const IconThemeData(color: Colors.amber),
        onTap: (index) {
          setState(() {
            _selected = index;
          });
        },
      ),
    );
  }
}
