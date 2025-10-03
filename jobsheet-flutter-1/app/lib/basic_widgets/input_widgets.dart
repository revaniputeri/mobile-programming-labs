import 'package:flutter/material.dart';

class InputWidgets extends StatefulWidget {
  const InputWidgets({Key? key}) : super(key: key);

  @override
  State<InputWidgets> createState() => _InputWidgetsState();
}

class _InputWidgetsState extends State<InputWidgets> {
  // State variables for all input widgets
  bool _checkboxValue = false;
  bool _switchValue = false;
  double _sliderValue = 50.0;
  String _radioValue = 'Option 1';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _textController = TextEditingController();

  // Date picker method
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Time picker method
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Show form data method
  void _showFormData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Form Data'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Name: ${_textController.text}'),
                Text('Checkbox: $_checkboxValue'),
                Text('Switch: $_switchValue'),
                Text('Slider: ${_sliderValue.round()}'),
                Text('Radio: $_radioValue'),
                Text('Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                Text('Time: ${_selectedTime.format(context)}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TextField
          const Text(
            'TextField:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your name',
              hintText: 'Type here...',
            ),
          ),
          const SizedBox(height: 20),

          // Checkbox
          const Text(
            'Checkbox:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          CheckboxListTile(
            title: const Text('Accept Terms and Conditions'),
            value: _checkboxValue,
            onChanged: (bool? value) {
              setState(() {
                _checkboxValue = value ?? false;
              });
            },
          ),
          const SizedBox(height: 20),

          // Switch
          const Text(
            'Switch:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: _switchValue,
            onChanged: (bool value) {
              setState(() {
                _switchValue = value;
              });
            },
          ),
          const SizedBox(height: 20),

          // Slider
          const Text(
            'Slider:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Value: ${_sliderValue.round()}'),
          Slider(
            value: _sliderValue,
            min: 0,
            max: 100,
            divisions: 10,
            label: _sliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _sliderValue = value;
              });
            },
          ),
          const SizedBox(height: 20),

          // Radio Button
          const Text(
            'Radio Button:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          RadioListTile<String>(
            title: const Text('Option 1'),
            value: 'Option 1',
            groupValue: _radioValue,
            onChanged: (String? value) {
              setState(() {
                _radioValue = value ?? 'Option 1';
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Option 2'),
            value: 'Option 2',
            groupValue: _radioValue,
            onChanged: (String? value) {
              setState(() {
                _radioValue = value ?? 'Option 1';
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Option 3'),
            value: 'Option 3',
            groupValue: _radioValue,
            onChanged: (String? value) {
              setState(() {
                _radioValue = value ?? 'Option 1';
              });
            },
          ),
          const SizedBox(height: 20),

          // Date Picker
          const Text(
            'Date Picker:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Selected Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Select Date'),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Time Picker
          const Text(
            'Time Picker:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Selected Time: ${_selectedTime.format(context)}'),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: const Text('Select Time'),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Submit Button
          Center(
            child: ElevatedButton(
              onPressed: _showFormData,
              child: const Text('Show Form Data'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}