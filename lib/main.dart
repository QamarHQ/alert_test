import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestAlertScreen(),
    );
  }
}

class TestAlertScreen extends StatefulWidget {
  const TestAlertScreen({super.key});

  @override
  State<TestAlertScreen> createState() => _TestAlertScreenState();
}

class _TestAlertScreenState extends State<TestAlertScreen> {
  final TextEditingController _controller = TextEditingController();
  bool? isSuccess;

  void _checkNumber() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final number = int.tryParse(text);
    if (number != null) {
      setState(() {
        isSuccess = number % 2 == 0; // Even number = success, odd = error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 22, 22),
      appBar: AppBar(title: const Text('Test Custom Alert')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter a number',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkNumber,
              child: const Text('Check Number'),
            ),
            const SizedBox(height: 20),
            if (isSuccess != null)
              CustomAlert(
                message: "Actualizaste tu almacén", 
                isSuccess: isSuccess!,
              ),
          ],
        ),
      ),
    );
  }
}

// Custom Alert Widget
class CustomAlert extends StatelessWidget {
  final String message;
  final bool isSuccess;

  const CustomAlert({super.key, required this.message, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF302C2D),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF302C2D), width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26983E1B),
            blurRadius: 8,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: isSuccess ? const Color(0xFF82DE91) : const Color(0xFFF76C6C),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xFFFAF7F7),
                fontSize: 16,
                fontFamily: 'Instrument Sans',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

