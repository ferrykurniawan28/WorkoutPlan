import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final db = FirebaseFirestore.instance;

class Workoutplan extends StatefulWidget {
  const Workoutplan({super.key});

  @override
  State<Workoutplan> createState() => _WorkoutplanState();
}

class _WorkoutplanState extends State<Workoutplan> {
  List<int> workoutPlanList = [];
  final docRef = db.collection("userWorkoutPlans").doc("user");

  @override
  void initState() {
    docRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      if (doc.exists) {
        setState(() {
          workoutPlanList = List<int>.from(data['selectedExercises'] ?? []);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.collection('workouts').snapshots(),
      builder: (context, snapshot) {
        if (workoutPlanList.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No workpout plan'),
              ],
            ),
          );
        }
        if (snapshot.hasData) {
          final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: workoutPlanList.length,
            itemBuilder: (context, index) {
              final int docIndex = workoutPlanList[index];
              final doc = documents[docIndex];
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(doc['name']),
                        content: SizedBox(
                          height: 340,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                                child: Image.network(doc['img']),
                              ),
                              const SizedBox(height: 20),
                              Text(doc['description']),
                              const SizedBox(height: 20),
                              Text('Do this exercise ${doc['duration']}'),
                              const SizedBox(height: 20),
                              Text('Do this exercise ${doc['sets']} sets'),
                              const SizedBox(height: 20),
                              Text('Do this exercise ${doc['reps']} reps'),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'))
                        ],
                      );
                    },
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(doc['name']),
                      // subtitle: Text(doc['description']),
                      leading: SizedBox(
                        width: 70,
                        child: Image.network(
                          doc['img'],
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          setState(() {
                            workoutPlanList.remove(docIndex);
                          });
                          await db
                              .collection('userWorkoutPlans')
                              .doc('user')
                              .set({
                            'selectedExercises': workoutPlanList,
                          });
                        },
                        icon: const Icon(Icons.done),
                      ),
                      // trailing: IconButton(
                      //   icon: const Icon(Icons.check_circle),
                      //   onPressed: () async {
                      //     setState(() {
                      //       workoutPlanList.remove(index);
                      //     });
                      //     await db
                      //         .collection('userWorkoutPlans')
                      //         .doc('user')
                      //         .set({
                      //       'selectedExercises': workoutPlanList,
                      //     });
                      //   },
                      // ),
                      // trailing: IconButton(
                      //   icon: const Icon(Icons.delete),
                      //   onPressed: () {
                      //     db.collection('workouts').doc(doc.id).delete();
                      //   },
                      // ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// final db = FirebaseFirestore.instance;

// class Workoutplan extends StatefulWidget {
//   const Workoutplan({super.key});

//   @override
//   State<Workoutplan> createState() => _WorkoutplanState();
// }

// class _WorkoutplanState extends State<Workoutplan> {
//   List<int> workoutPlanList = [];
//   final docRef = db.collection("userWorkoutPlans").doc("user");

//   @override
//   void initState() {
//     docRef.get().then((DocumentSnapshot doc) {
//       final data = doc.data() as Map<String, dynamic>;
//       if (doc.exists) {
//         setState(() {
//           workoutPlanList = List<int>.from(data['selectedExercises'] ?? []);
//         });
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: db.collection('workouts').get(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
//           return Center(
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text(
//                   'Select Exercises',
//                   style: TextStyle(fontSize: 30),
//                 ),
//                 const SizedBox(height: 10),
//                 SizedBox(
//                   height: 430,
//                   child: ListView.builder(
//                     itemCount: documents.length,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) {
//                       final doc = documents[index];
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               if (workoutPlanList.contains(index)) {
//                                 workoutPlanList.remove(index);
//                               } else {
//                                 workoutPlanList.add(index);
//                               }
//                             });
//                           },
//                           child: Container(
//                             width: 300,
//                             decoration: BoxDecoration(
//                               color: workoutPlanList.contains(index)
//                                   ? Colors.blue
//                                   : Colors.grey,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   doc['name'],
//                                   style: const TextStyle(
//                                     fontSize: 30,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   doc['description'],
//                                   style: const TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     docRef.set({
//                       'selectedExercises': workoutPlanList,
//                     });
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('Save'),
//                 ),
//               ],
//             ),
//           );
//         }
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );
//   }
// }
