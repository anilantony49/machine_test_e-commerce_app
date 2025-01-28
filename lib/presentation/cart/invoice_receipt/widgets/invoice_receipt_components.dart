import 'package:flutter/material.dart';
import 'package:machine_test/core/utils/text.dart';

class DetailsBox extends StatelessWidget {
  final String label1;
  final String value1;
  final String label2;
  final String value2;

  const DetailsBox({
    super.key,
    required this.label1,
    required this.value1,
    required this.label2,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return buildBox(
      Column(
        children: [
          _buildKeyValueRow(label1, value1),
          const SizedBox(height: 20),
          _buildKeyValueRow(label2, value2),
        ],
      ),
      minHeight: 60,
      maxHeight: 80,
    );
  }
}

class SummaryBox extends StatelessWidget {
  final String title;
  final String label;
  final String value;

  const SummaryBox({
    super.key,
    required this.title,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return buildBox(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildKeyValueRow(label, value),
        ],
      ),
      minHeight: 60,
      maxHeight: 80,
    );
  }
}

class CustomerInfoBox extends StatelessWidget {
  const CustomerInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return buildBox(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.customerInfo,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                AppText.customerName,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(
                height: 20,
                child: VerticalDivider(color: Colors.grey, thickness: 1),
              ),
              Text(
                AppText.customerNumber,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            AppText.customerAddress,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
      minHeight: 60,
      maxHeight: 120,
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 30,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

Widget buildBox(Widget child,
    {required double minHeight, required double maxHeight}) {
  return ConstrainedBox(
    constraints: BoxConstraints(minHeight: minHeight, maxHeight: maxHeight),
    child: DecoratedBox(
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 231, 229, 229)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    ),
  );
}

Widget _buildKeyValueRow(String key, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        key,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      Text(
        value,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
