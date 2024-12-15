import 'package:event_management/birthday_budget.dart';
import 'package:event_management/venue_service.dart'; // Import the new page
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for input formatters
import 'package:intl/intl.dart';

import 'concert_budget.dart';
import 'formal_budget.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _formKey = GlobalKey<FormState>();

  final _eventNameController = TextEditingController();
  final _guestsController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  final List<String> _keywords = ['Wedding', 'Birthday', 'Concert', 'Formal Event'];
  String? _selectedKeyword;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final eventData = {
        'eventName': _eventNameController.text,
        'keyword': _selectedKeyword,
        'date': _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : null,
        'startTime': _startTime?.format(context),
        'endTime': _endTime?.format(context),
        'guests': _guestsController.text,
      };

      // Determine the next page based on the selected keyword
      Widget nextPage;
      if (_selectedKeyword == 'Wedding') {
        nextPage = const VenueService();
      } else if (_selectedKeyword == 'Birthday') {
        nextPage = const BirthdayBudget();
      } else if (_selectedKeyword == 'Concert') {
        nextPage = const ConcertBudget();
      } else {
        nextPage = const FormalBudget();
      }

      // Navigate to the determined page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => nextPage,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event created successfully!')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create an Event'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildFormField(
                headerText: 'Name of the Event',
                hintText: 'Write name of the event...',
                field: TextFormField(
                  controller: _eventNameController,
                  decoration: _inputDecoration('Write name of the event...'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter event name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 24),
              _buildFormField(
                headerText: 'Select a Keyword',
                hintText: 'Choose a keyword',
                field: DropdownButtonFormField<String>(
                  value: _selectedKeyword,
                  items: _keywords.map((String keyword) {
                    return DropdownMenuItem<String>(
                      value: keyword,
                      child: Text(keyword),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedKeyword = newValue;

                    });
                  },
                  decoration: _inputDecoration('Choose a keyword'),
                  validator: (value) {
                    if (value == null) { // Adjusted for null check
                      return 'Please Choose a valid Keyword';
                    }
                    return null;
                  },
                  hint: const Text('Choose a keyword'),
                ),
              ),
              const SizedBox(height: 24),
              _buildFormField(
                headerText: 'Date of the Event',
                hintText: 'When are you planning...',
                field: InkWell(
                  onTap: _selectDate,
                  child: IgnorePointer(
                    child: TextFormField(
                      decoration: _inputDecoration('When are you planning...'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter Valid Date';
                        }
                        return null;
                      },
                      controller: TextEditingController(
                        text: _selectedDate != null
                            ? DateFormat('MM/dd/yyyy').format(_selectedDate!)
                            : '',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Time',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectTime(true),
                      child: IgnorePointer(
                        child: TextFormField(
                          decoration: _inputDecoration('Start'),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Valid Start Time';
                            }
                            return null;
                          },
                          controller: TextEditingController(
                            text: _startTime?.format(context) ?? '',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectTime(false),
                      child: IgnorePointer(
                        child: TextFormField(
                          decoration: _inputDecoration('End'),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Valid End time';
                            }
                            return null;
                          },
                          controller: TextEditingController(
                            text: _endTime?.format(context) ?? '',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildFormField(
                headerText: 'Add Guests',
                hintText: 'How many people would you like to invite?',
                field: TextFormField(
                  controller: _guestsController,
                  keyboardType: TextInputType.number, // Use numeric keyboard
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly // Allow only digits
                  ],
                  decoration: _inputDecoration('How many people would you like to invite?'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'So you don\'t want to invite anyone?';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Before you proceed forward, make sure to check your details...',
                style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Proceed Forward ->',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String headerText,
    required String hintText,
    required Widget field,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        field,
      ],
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey), // Grey hint text
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.all(16), // Padding inside the box
    );
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _guestsController.dispose();
    super.dispose();
  }
}
