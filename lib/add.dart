import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddWorkout extends StatefulWidget {
  const AddWorkout({super.key});

  @override
  State<AddWorkout> createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {
  final formKey = GlobalKey<FormState>();
  final imgaCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final durationCtrl = TextEditingController();
  final repsCtrl = TextEditingController();
  final setsCtrl = TextEditingController();

  final db = FirebaseFirestore.instance;

  void _upload() {
    final name = nameCtrl.text;
    final description = descriptionCtrl.text;
    final duration = durationCtrl.text;
    final reps = repsCtrl.text;
    final sets = setsCtrl.text;

    db.collection('workouts').doc(name).set({
      'img': imgaCtrl.text,
      'name': name,
      'description': description,
      'duration': duration,
      'reps': reps,
      'sets': sets,
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Workout'),
      ),
      body: Center(
        child: Form(
            child: Column(
          children: [
            TextFormField(
              controller: imgaCtrl,
              decoration: InputDecoration(
                labelText: 'Image Link',
              ),
            ),
            TextFormField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: 'Workout Name',
              ),
            ),
            TextFormField(
              controller: descriptionCtrl,
              decoration: InputDecoration(
                labelText: 'Workout Description',
              ),
            ),
            TextFormField(
              controller: durationCtrl,
              decoration: InputDecoration(
                labelText: 'Workout Duration',
              ),
            ),
            TextFormField(
              controller: repsCtrl,
              decoration: InputDecoration(
                labelText: 'Workout Reps',
              ),
            ),
            TextFormField(
              controller: setsCtrl,
              decoration: InputDecoration(
                labelText: 'Workout Sets',
              ),
            ),
            TextButton(onPressed: _upload, child: Text('Upload'))
          ],
        )),
      ),
    );
  }
}
