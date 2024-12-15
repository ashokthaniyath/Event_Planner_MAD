import 'package:flutter/material.dart';

class Budget extends StatefulWidget {
  final int totalBudget;
  final int totalCost; // This should include the venue cost
  final bool isPhotographySelected; // Add selection flag

  const Budget({
    Key? key,
    required this.totalBudget,
    required this.totalCost,
    required this.isPhotographySelected,
  }) : super(key: key);

  @override
  State<Budget> createState() => _BudgetPlannerPageState();
}

class _BudgetPlannerPageState extends State<Budget> {
  List<String> _categories = ['Venue', 'Catering', 'Decoration'];
  String _selectedPriority = 'Venue';
  late Map<String, double> _budgetAllocation;

  @override
  void initState() {
    super.initState();
    // Conditionally add Photography
    if (widget.isPhotographySelected) {
      _categories.add('Photography');
    }
    _budgetAllocation = _calculateBudgetAllocation();
  }

  Map<String, double> _calculateBudgetAllocation() {
    double priorityPercentage = 0.4;
    double remainingPercentage =
        (1 - priorityPercentage) / (_categories.length - 1);

    return {
      for (var category in _categories)
        category: category == _selectedPriority
            ? widget.totalBudget * priorityPercentage
            : widget.totalBudget * remainingPercentage,
    };
  }

  void _onPrioritySelected(String? priority) {
    if (priority != null) {
      setState(() {
        _selectedPriority = priority;
        _budgetAllocation = _calculateBudgetAllocation();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalAllocated = _budgetAllocation.values.reduce((a, b) => a + b);
    double amountInHand = widget.totalBudget - totalAllocated - widget.totalCost; // Calculate remaining budget

    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Allocation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Budget Priority',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedPriority,
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: _onPrioritySelected,
            ),
            const SizedBox(height: 20),
            const Text(
              'Budget Allocation:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  ..._budgetAllocation.entries.map((entry) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      elevation: 2,
                      child: ListTile(
                        title: Text(entry.key),
                        trailing: Text(
                          '₹${entry.value.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'Total Budget',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      '₹${widget.totalBudget.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Amount in Hand',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      '₹${amountInHand.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green, // Change color to indicate available amount
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Budget(totalBudget: 500000, totalCost: 0, isPhotographySelected: false), // Example usage
  ));
}
