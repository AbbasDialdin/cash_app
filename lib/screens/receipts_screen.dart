import 'package:flutter/material.dart';
import '../models/receipt_model.dart';
import '../widgets/receipt_card.dart';

class ReceiptsScreen extends StatelessWidget {
  final List<Receipt> receipts;

  const ReceiptsScreen({super.key, required this.receipts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("قائمة الفواتير"), centerTitle: true),
      body:
          receipts.isEmpty
              ? const Center(child: Text("لا توجد فواتير حتى الآن"))
              : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: receipts.length,
                itemBuilder: (context, index) {
                  return ReceiptCard(receipt: receipts[index]);
                },
              ),
    );
  }
}
