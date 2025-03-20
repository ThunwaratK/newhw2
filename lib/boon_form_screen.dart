import 'package:flutter/material.dart';

class BoonFormScreen extends StatefulWidget {
  const BoonFormScreen({super.key});

  @override
  State<BoonFormScreen> createState() => _BoonFormScreenState();
}

class _BoonFormScreenState extends State<BoonFormScreen> {
  final _boonFormKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _startHourController = TextEditingController();
  final TextEditingController _startMinuteController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _eventDateController.dispose();
    _startHourController.dispose();
    _startMinuteController.dispose();
    _locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var boonId = ModalRoute.of(context)!.settings.arguments;

    _titleController.text = '';
    _eventDateController.text = '';
    _descController.text = '';
    _startHourController.text = '';
    _startMinuteController.text = '';
    _locationController.text = '';

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          boonId == null ? 'Create Boon' : 'Update Boon',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.grey[400],
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _boonFormKey,
            child: Column(
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.25,
                  child: Image.asset('assets/images/tak_bat.png'),
                ),
                //Image.asset('assets/images/tak_bat.png'),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: 'Enter title',
                          labelText: 'Title',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Title CANNOT be empty.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: TextFormField(
                        controller: _descController,
                        decoration: InputDecoration(
                          hintText: 'Enter description',
                          labelText: 'Description',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: TextFormField(
                        controller: _eventDateController,
                        decoration: InputDecoration(
                          hintText: 'Enter event date: mm/dd/yyyy',
                          labelText: 'Event Date',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Event date CANNOT be empty.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: TextFormField(
                        controller: _startHourController,
                        decoration: InputDecoration(
                          hintText: 'Enter start hour: hh',
                          labelText: 'Start hour',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Start hour CANNOT be empty.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: TextFormField(
                        controller: _startMinuteController,
                        decoration: InputDecoration(
                          hintText: 'Enter start minute: mm',
                          labelText: 'Start minute',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Start minute CANNOT be empty.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          hintText: 'Enter location',
                          labelText: 'Location',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Location CANNOT be empty.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          shadowColor: Colors.deepPurple,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        onPressed: () {
                          if (_boonFormKey.currentState!.validate()) {
                            //
                            final title = _titleController.text.trim();
                            final desc = _descController.text.trim();
                            final eventDate = _eventDateController.text.trim();
                            final startHour = _startHourController.text.trim();
                            final startMinute =
                                _startMinuteController.text.trim();
                            final location = _locationController.text.trim();

                            //Add a document
                            final boonMapDoc = <String, dynamic>{
                              "title": title,
                              "desc": desc,
                              "eventDate": eventDate,
                              "startHour": startHour,
                              "startMinute": startMinute,
                              "location": location,
                            };

                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          shadowColor: Colors.deepPurple,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        onPressed: () {
                          _boonFormKey.currentState!.reset();
                        },
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
