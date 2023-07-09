import 'package:expense_tracker/enums/category_enum.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expenseData});
  final Expense expenseData;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseData.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${expenseData.amount.toStringAsFixed(2)}",
                ),
                Row(
                  children: [
                    Icon(categoryIcons[expenseData.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      expenseData.formattedDate,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
