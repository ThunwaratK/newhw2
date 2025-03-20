import 'package:cp_213_sqflife_thunwarat/boon_entity.dart';
import 'package:cp_213_sqflife_thunwarat/sqflite_floor_service.dart';
import 'package:flutter/material.dart';

class BoonFormScreen extends StatefulWidget {
  final String mode;
  final int? boonId;

  const BoonFormScreen({super.key, required this.mode, this.boonId});

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
  void initState() {
    super.initState();
    if (widget.mode == "edit" || widget.mode == "view") {
      _loadBoonData(widget.boonId!);
    }
  }

  Future<void> _loadBoonData(int boonId) async {
    final database = SqfliteFloorService.instance.database;
    final boon = await database.boonDao.findBoonByBId(boonId);

    if (boon != null) {
      setState(() {
        _titleController.text = boon.title;
        _descController.text = boon.desc ?? '';
        _eventDateController.text = boon.eventDate;
        _startHourController.text = boon.startHour;
        _startMinuteController.text = boon.startMinute;
        _locationController.text = boon.location;
      });
    }
  }

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
    final isViewMode = widget.mode == "view";

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          widget.mode == "add"
              ? 'Create Boon'
              : widget.mode == "edit"
              ? 'Edit Boon'
              : 'View Boon',
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
                SizedBox(height: 20),
                _buildTextField(
                  controller: _titleController,
                  label: 'Title',
                  hint: 'Enter title',
                  isReadOnly: isViewMode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title CANNOT be empty.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                _buildTextField(
                  controller: _descController,
                  label: 'Description',
                  hint: 'Enter description',
                  isReadOnly: isViewMode,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  controller: _eventDateController,
                  label: 'Event Date',
                  hint: 'Enter event date: mm/dd/yyyy',
                  isReadOnly: isViewMode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Event date CANNOT be empty.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                _buildTextField(
                  controller: _startHourController,
                  label: 'Start Hour',
                  hint: 'Enter start hour: hh',
                  isReadOnly: isViewMode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Start hour CANNOT be empty.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                _buildTextField(
                  controller: _startMinuteController,
                  label: 'Start Minute',
                  hint: 'Enter start minute: mm',
                  isReadOnly: isViewMode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Start minute CANNOT be empty.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                _buildTextField(
                  controller: _locationController,
                  label: 'Location',
                  hint: 'Enter location',
                  isReadOnly: isViewMode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Location CANNOT be empty.';
                    }
                    return null;
                  },
                ),
                if (!isViewMode) SizedBox(height: 25),
                if (!isViewMode && widget.mode != "edit")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [_buildSaveButton(), _buildResetButton()],
                  ),
                if (!isViewMode && widget.mode == "edit")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [_buildSaveButton()],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isReadOnly = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
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
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              labelText: label,
              border: InputBorder.none,
            ),
            readOnly: isReadOnly,
            validator: validator,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
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
        onPressed: () async {
          if (_boonFormKey.currentState!.validate()) {
            final title = _titleController.text.trim();
            final desc = _descController.text.trim();
            final eventDate = _eventDateController.text.trim();
            final startHour = _startHourController.text.trim();
            final startMinute = _startMinuteController.text.trim();
            final location = _locationController.text.trim();

            final boonEntity = BoonEntity(
              bid: widget.mode == "edit" ? widget.boonId : null,
              title: title,
              desc: desc,
              eventDate: eventDate,
              startHour: startHour,
              startMinute: startMinute,
              location: location,
            );

            final database = SqfliteFloorService.instance.database;
            if (widget.mode == "edit") {
              await database.boonDao.updateBoon(boonEntity);
            } else {
              await database.boonDao.insertBoon(boonEntity);
            }

            Navigator.pop(context);
          }
        },
        child: Text(
          'Save',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildResetButton() {
    return SizedBox(
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
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
