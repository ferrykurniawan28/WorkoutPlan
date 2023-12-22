import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final db = FirebaseFirestore.instance;

class Workoutlist extends StatelessWidget {
  const Workoutlist({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.collection('workouts').get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final doc = documents[index];
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
                      leading:
                          SizedBox(width: 70, child: Image.network(doc['img'])),
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
