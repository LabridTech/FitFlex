import 'package:app/firebase.dart';
import 'package:flutter/material.dart';

class TrainerInputPage extends StatefulWidget {
  static String routeName = '/trianerinput';
  @override
  _TrainerInputPageState createState() => _TrainerInputPageState();
}

class _TrainerInputPageState extends State<TrainerInputPage> {
  TextEditingController trainerNameController = TextEditingController();
  TextEditingController trainerRoleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController traineesController = TextEditingController();
  TextEditingController experienceController = TextEditingController();

  // TextEditingController for each day's working hours
  Map<String, TextEditingController> workingHoursControllers = {
    'Monday': TextEditingController(),
    'Tuesday': TextEditingController(),
    'Wednesday': TextEditingController(),
    'Thursday': TextEditingController(),
    'Friday': TextEditingController(),
    'Saturday': TextEditingController(),
    'Sunday': TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Enter Trainer Details',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Photo
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Image.asset(
                    'images/dumbbell.png', // Replace 'lib/images/dumbbell.png' with the path to your image asset
                    height: 150, // Adjust the height as needed
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // Trainer Details Inputs

              TextField(
                controller: trainerRoleController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Trainer Role',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: locationController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Location',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: traineesController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Trainees',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: experienceController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Experience',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
              ),

              const SizedBox(height: 20),

              // Working Hours Inputs
              Text(
                'Working Hours',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // TextFields for each day of the week
              Column(
                children: workingHoursControllers.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${entry.key}:',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: entry.value,
                                  readOnly: true,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: 'Tap to select time',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.schedule),
                                onPressed: () async {
                                  final TimeOfDay? pickedTime =
                                      await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (pickedTime != null) {
                                    setState(() {
                                      entry.value.text =
                                          pickedTime.format(context);
                                    });
                                  }
                                },
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Save Details Button
              ElevatedButton(
                onPressed: () {
                  // Save trainer details to the database
                  saveTrainerDetails();
                  // Navigate back to previous screen
                  //Navigator.pop(context);
                },
                child: Text(
                  'Save Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveTrainerDetails() {
    // Save trainer details to the database
    // Example: You can use a database service to save the details
    // For simplicity, let's just print the details here
    print('Trainer Role: ${trainerRoleController.text}');
    print('Location: ${locationController.text}');
    print('Trainees: ${traineesController.text}');
    print('Experience: ${experienceController.text}');
    Map<String, String> workingHours = {};
    // Print working hours for each day
    workingHoursControllers.forEach((day, controller) {
      workingHours.addAll({
        day: controller.text,
      });
    });
    FirebaseCrud().addtrainer(
        trainerRoleController.text,
        locationController.text,
        traineesController.text,
        experienceController.text,
        workingHours);
  }
}
