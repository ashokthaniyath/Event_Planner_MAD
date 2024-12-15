import 'package:flutter/material.dart';

class FormalBudget extends StatefulWidget {
  const FormalBudget({Key? key}) : super(key: key);

  @override
  _FormalEventBudgetState createState() => _FormalEventBudgetState();
}

class _FormalEventBudgetState extends State<FormalBudget> {
  final _formKey = GlobalKey<FormState>();

  final _venueBudgetController = TextEditingController();
  final _cateringBudgetController = TextEditingController();
  final _entertainmentBudgetController = TextEditingController();
  final _decorationsBudgetController = TextEditingController();
  final _audioVisualBudgetController = TextEditingController();
  final _additionalRequirementsController = TextEditingController();

  String _billDetails = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formal Event Budget'),
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
                  label: 'Venue Budget',
                  controller: _venueBudgetController,
                ),
                _buildBudgetField(
                  label: 'Catering Budget',
                  controller: _cateringBudgetController,
                ),
                _buildBudgetField(
                  label: 'Entertainment Budget',
                  controller: _entertainmentBudgetController,
                ),
                _buildBudgetField(
                  label: 'Decorations Budget',
                  controller: _decorationsBudgetController,
                ),
                _buildBudgetField(
                  label: 'Audio/Visual Budget',
                  controller: _audioVisualBudgetController,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _additionalRequirementsController,
                  decoration: InputDecoration(
                    labelText: 'Additional Requirements',
                    hintText: 'Enter any additional requirements for the event',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculateTotalBudget,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text('Display Budgets'),
                ),
                const SizedBox(height: 20),
                // Display the bill details if they are set
                if (_billDetails.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      _billDetails,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _calculateTotalBudget() {
    // Create the bill details string with the entered budgets
    setState(() {
      _billDetails = 'Bill Details:\n'
          'Venue Budget: ₹${_venueBudgetController.text}\n'
          'Catering Budget: ₹${_cateringBudgetController.text}\n'
          'Entertainment Budget: ₹${_entertainmentBudgetController.text}\n'
          'Decorations Budget: ₹${_decorationsBudgetController.text}\n'
          'Audio/Visual Budget: ₹${_audioVisualBudgetController.text}\n'
          'Additional Requirements: ${_additionalRequirementsController.text}';
    });
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
    _venueBudgetController.dispose();
    _cateringBudgetController.dispose();
    _entertainmentBudgetController.dispose();
    _decorationsBudgetController.dispose();
    _audioVisualBudgetController.dispose();
    _additionalRequirementsController.dispose();
    super.dispose();
  }
}
