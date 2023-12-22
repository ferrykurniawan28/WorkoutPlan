import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workout/home.dart';

final db = FirebaseFirestore.instance;

class AddWorkPlan extends StatefulWidget {
  const AddWorkPlan({super.key});

  @override
  State<AddWorkPlan> createState() => _AddWorkPlanState();
}

class _AddWorkPlanState extends State<AddWorkPlan> {
  List<int> _selectedIndex = [];

  void addWorkoutPlan() async {
    // Assuming you have a Firestore collection named 'userWorkoutPlans'
    await db.collection('userWorkoutPlans').doc('user').set({
      'selectedExercises': _selectedIndex,
    });
    setState(() {
      _selectedIndex.clear();
    });
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Home(
          index: 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Workout Plan'),
      ),
      body: FutureBuilder(
        future: db.collection('workouts').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            return Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Select Exercises',
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 430,
                    child: ListView.builder(
                      itemCount: documents.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final doc = documents[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_selectedIndex.contains(index)) {
                                  _selectedIndex.remove(index);
                                } else {
                                  _selectedIndex.add(index);
                                }
                                print(_selectedIndex);
                              });
                            },
                            child: SizedBox(
                              width: 300,
                              child: Card(
                                color: (_selectedIndex.contains(index)
                                    ? Colors.green[300]
                                    : null),
                                // color: ,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        child: Image.network(doc['img']),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(doc['name']),
                                      const SizedBox(height: 20),
                                      Text(doc['description']),
                                      const SizedBox(height: 20),
                                      Text(
                                          'Do this exercise ${doc['duration']}'),
                                      const SizedBox(height: 20),
                                      Text(
                                          'Do this exercise ${doc['sets']} sets'),
                                      const SizedBox(height: 20),
                                      Text(
                                          'Do this exercise ${doc['reps']} reps'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: addWorkoutPlan,
                    child: const Text('Add Workout Plan'),
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
