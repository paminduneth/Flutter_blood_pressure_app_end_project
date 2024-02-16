import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class ResultScreen extends StatelessWidget {
  final RxList<Map<String, String>> readings;

  const ResultScreen({super.key, required this.readings});

  double getAverageValue(String key) {
    double sum = 0;
    for (var reading in readings) {
      sum += double.parse(reading[key]!);
    }
    return sum / readings.length;
  }

  String determineHeartRateStatus(double heartRate) {
    if (heartRate < 80) {
      return 'Normal';
    } else if (heartRate >= 80 && heartRate <= 100) {
      return 'Elevated';
    } else if (heartRate >= 101 && heartRate <= 120) {
      return 'Hypertension Stage 1';
    } else if (heartRate >= 121 && heartRate <= 130) {
      return 'Hypertension Stage 2';
    } else {
      return 'Hypertensive Crisis (Medical Attention Required)';
    }
  }

  @override
  Widget build(BuildContext context) {
    double averageSystolic = getAverageValue('systolic');
    double averageDiastolic = getAverageValue('diastolic');
    double averagePluse = getAverageValue('pluse');

    double heartRate = (averageSystolic + averageDiastolic + averagePluse) / 3;

    List<double> pieChartValues = [
      averageSystolic,
      averageDiastolic,
      averagePluse,
    ];

    String heartRateStatus = determineHeartRateStatus(heartRate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Overall Results',
            style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Results',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Average Systolic: ${averageSystolic.toStringAsFixed(2)} mmHg',
                  style: const TextStyle(
                      fontSize: 18.0, color: Color.fromARGB(255, 22, 70, 230)),
                ),
                Text(
                  'Average Diastolic: ${averageDiastolic.toStringAsFixed(2)} mmHg',
                  style: const TextStyle(
                      fontSize: 18.0, color: Color.fromARGB(255, 192, 12, 12)),
                ),
                Text(
                  'Average Pulse: ${averagePluse.toStringAsFixed(2)} BPM',
                  style: const TextStyle(
                      fontSize: 18.0, color: Color.fromARGB(255, 52, 143, 10)),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Heart Rate Status: $heartRateStatus',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Overall Results Chart',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 60,
                      sections: [
                        PieChartSectionData(
                          value: pieChartValues[0],
                          color: Colors.blue,
                          title: 'Systolic',
                          radius: 80,
                        ),
                        PieChartSectionData(
                          value: pieChartValues[1],
                          color: Colors.red,
                          title: 'Diastolic',
                          radius: 70,
                        ),
                        PieChartSectionData(
                          value: pieChartValues[2],
                          color: Colors.green,
                          title: 'Pulse',
                          radius: 60,
                        ),
                      ],
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
}
