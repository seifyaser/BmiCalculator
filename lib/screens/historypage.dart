import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:bmi/models/bmiRecord_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryScreen extends StatelessWidget {
  final Box<BMIRecordModel> box;

  const HistoryScreen({super.key, required this.box});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              box.clear();
            },
            icon: Icon(Icons.delete),
          ),
        ],
        title: Text('BMI History'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<BMIRecordModel> box, _) {
          if (box.isEmpty) {
            return Center(
              child: Text('No records found.', style: TextStyle(fontSize: 20)),
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final bmiRecord = box.values.toList().reversed.toList()[index];
                if (bmiRecord != null) {
                  return ListTile(
                    title: Text(
                      "BMI: ${bmiRecord.bmi.toStringAsFixed(1)} kg/m²",
                    ),
                    subtitle: Text("Date: ${bmiRecord.formattedDate}"),
                    leading: Icon(Icons.history),
                  );
                }
                return SizedBox.shrink();
              },
            );
          }
        },
      ),
    );
  }
}
