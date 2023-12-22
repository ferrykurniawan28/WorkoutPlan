import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final db = FirebaseFirestore.instance;

class Sugestion extends StatefulWidget {
  const Sugestion({super.key});

  @override
  State<Sugestion> createState() => _SugestionState();
}

class _SugestionState extends State<Sugestion> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.collection('workouts').get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
          return Center(
            child: SizedBox(
              height: 430,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        // setState(() {
                        //   if (_selectedIndex.contains(index)) {
                        //     _selectedIndex.remove(index);
                        //   } else {
                        //     _selectedIndex.add(index);
                        //   }
                        // });
                      },
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: (_selectedIndex.contains(index))
                          //     ? Colors.blue
                          //     : Colors.grey,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              documents[index]['img'],
                              height: 200,
                              width: 200,
                            ),
                            Text(
                              documents[index]['name'],
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            // const SizedBox(height: 10),
                            // Text(
                            //   documents[index]['description'],
                            //   style: const TextStyle(
                            //     fontSize: 15,
                            //     color: Colors.white,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
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
