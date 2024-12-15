import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart'; // Add this line

class BirthdayBudget extends StatefulWidget {
  const BirthdayBudget({Key? key}) : super(key: key);

  @override
  _BirthdayBudgetState createState() => _BirthdayBudgetState();
}

class _BirthdayBudgetState extends State<BirthdayBudget> {
  final _formKey = GlobalKey<FormState>();

  final _foodBudgetController = TextEditingController();
  final _decorationsBudgetController = TextEditingController();
  final _cakeBudgetController = TextEditingController();
  final _emailController = TextEditingController();
  double _totalBudget = 0.0;

  List<Map<String, String>> _helpers = [];
  final List<String> _helpOptions = [
    'Setting up decorations',
    'Arranging food',
    'Managing guests',
    'Organizing activities',
    'Cleaning up',
  ];

  void _addHelper() {
    final email = _emailController.text;

    // Validate email format using the email_validator package
    if (!EmailValidator.validate(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email.')),
      );
      return; // Exit if the email is invalid
    }

    if (_helpers.length < 5) {
      setState(() {
        _helpers.add({'email': email, 'help': ''});
        _emailController.clear(); // Clear the email input after adding
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maximum 5 helpers can be assigned.')),
      );
    }
  }

  void _calculateTotalBudget() {
    if (_formKey.currentState?.validate() ?? false) {
      double foodBudget = double.tryParse(_foodBudgetController.text) ?? 0.0;
      double decorationsBudget = double.tryParse(_decorationsBudgetController.text) ?? 0.0;
      double cakeBudget = double.tryParse(_cakeBudgetController.text) ?? 0.0;

      setState(() {
        _totalBudget = foodBudget + decorationsBudget + cakeBudget;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Birthday Budget'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildBudgetField(
                  label: 'Food Budget',
                  controller: _foodBudgetController,
                ),
                _buildBudgetField(
                  label: 'Decorations Budget',
                  controller: _decorationsBudgetController,
                ),
                _buildBudgetField(
                  label: 'Cake Budget',
                  controller: _cakeBudgetController,
                ),
                const SizedBox(height: 16),
                _buildHelperField(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculateTotalBudget,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text('Calculate Total Budget'),
                ),
                const SizedBox(height: 20),
                Text(
                  'Total Budget: ₹$_totalBudget',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHelperField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Assign tasks to Friends and Family', style: TextStyle(color: Colors.grey, fontSize: 12)),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter email of helper',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _helpers.length < 5 ? _addHelper : null, // Disable if max helpers reached
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (_helpers.isNotEmpty) ...[
          const Text('Assigned Helpers:', style: TextStyle(fontWeight: FontWeight.bold)),
          for (var i = 0; i < _helpers.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_helpers[i]['email']!),
                DropdownButton<String>(
                  hint: const Text('Select Help'),
                  value: _helpers[i]['help'],
                  items: _helpOptions.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _helpers[i]['help'] = newValue!; // Update the selected help type
                    });
                  },
                ),
              ],
            ),
        ],
      ],
    );
  }

  Widget _buildBudgetField({
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          hintText: 'Enter budget for $label',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a budget';
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _foodBudgetController.dispose();
    _decorationsBudgetController.dispose();
    _cakeBudgetController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
