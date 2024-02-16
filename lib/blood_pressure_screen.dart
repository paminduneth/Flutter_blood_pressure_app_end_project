import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'result_screen.dart';
import 'app_bar.dart';

class BloodPressureController extends GetxController {
  final TextEditingController systolicController = TextEditingController();
  final TextEditingController diastolicController = TextEditingController();
  final TextEditingController pluseController = TextEditingController();

  final RxList<Map<String, String>> readings = <Map<String, String>>[].obs;

  void addReading(BuildContext context) {
    String systolic = systolicController.text;
    String diastolic = diastolicController.text;
    String pluse = pluseController.text;

    if (!_isValidInput(systolic, diastolic, pluse)) {
      _showInvalidInputPopup(context);
      return;
    }

    readings.add({
      'systolic': systolic,
      'diastolic': diastolic,
      'pluse': pluse,
      'date': DateTime.now().toString(),
    });

    systolicController.clear();
    diastolicController.clear();
    pluseController.clear();

    Get.to(() => ResultScreen(readings: readings));
  }

  void viewHistory() {
    Get.to(() => ResultScreen(readings: readings));
  }

  bool _isValidInput(String systolic, String diastolic, String pluse) {
    try {
      double systolicValue = double.parse(systolic);
      double diastolicValue = double.parse(diastolic);
      double pluseValue = double.parse(pluse);

      return systolicValue >= 80 &&
          systolicValue <= 200 &&
          diastolicValue >= 50 &&
          diastolicValue <= 120 &&
          pluseValue >= 30 &&
          pluseValue <= 150;
    } catch (e) {
      return false;
    }
  }

  void _showInvalidInputPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Inputs'),
          content: const Text(
              'Please enter valid blood pressure values for systolic and diastolic pressures.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class BloodPressureScreen extends StatelessWidget {
  final BloodPressureController controller = Get.put(BloodPressureController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onHistoryPressed: controller.viewHistory),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepPurple,
                  Colors.purpleAccent,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/download.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.systolicController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Systolic (mmHg)',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.diastolicController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Diastolic (mmHg)',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.pluseController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Pulse (BPM)',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () => controller.addReading(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      backgroundColor: Colors.white,
                    ),
                    child: const Text('Check'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
