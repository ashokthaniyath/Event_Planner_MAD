import 'package:flutter/material.dart';

class ConcertBudget extends StatefulWidget {
  const ConcertBudget({Key? key}) : super(key: key);

  @override
  _ConcertBudgetState createState() => _ConcertBudgetState();
}

class _ConcertBudgetState extends State<ConcertBudget> {
  final _formKey = GlobalKey<FormState>();

  final _advertisingBudgetController = TextEditingController();
  final _insurancePermitsBudgetController = TextEditingController();
  final _securityBudgetController = TextEditingController();
  final _talentFeesBudgetController = TextEditingController();
  final _concertExpensesController = TextEditingController();

  // State to hold the budget display data
  String _billDetails = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Concert Budget'),
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
                  label: 'Advertising Budget',
                  controller: _advertisingBudgetController,
                ),
                _buildBudgetField(
                  label: 'Insurance and Permits Budget',
                  controller: _insurancePermitsBudgetController,
                ),
                _buildBudgetField(
                  label: 'Security Budget',
                  controller: _securityBudgetController,
                ),
                _buildBudgetField(
                  label: 'Talent Fees Budget',
                  controller: _talentFeesBudgetController,
                ),
                _buildBudgetField(
                  label: 'Concert Expenses Budget',
                  controller: _concertExpensesController,
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
          'Advertising Budget: ₹${_advertisingBudgetController.text}\n'
          'Insurance and Permits Budget: ₹${_insurancePermitsBudgetController.text}\n'
          'Security Budget: ₹${_securityBudgetController.text}\n'
          'Talent Fees Budget: ₹${_talentFeesBudgetController.text}\n'
          'Concert Expenses Budget: ₹${_concertExpensesController.text}';
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
    _advertisingBudgetController.dispose();
    _insurancePermitsBudgetController.dispose();
    _securityBudgetController.dispose();
    _talentFeesBudgetController.dispose();
    _concertExpensesController.dispose();
    super.dispose();
  }
}
