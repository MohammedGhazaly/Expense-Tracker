import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/chart_widgets/chart.dart';
import 'package:expense_tracker/widgets/expenses_widgets/expenses_list.dart';
import 'package:expense_tracker/widgets/expenses_widgets/new_expense.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> expenses = [];
  void addNewExpense(Expense newExpense) {
    setState(() {
      expenses.add(newExpense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(
          onAddExpense: addNewExpense,
        );
      },
    );
  }

  void _removeExpense(Expense expense) {
    final int expenseIndex = expenses.indexOf(expense);
    setState(() {
      expenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text(
          "Expense deleted.",
        ),
        action: SnackBarAction(
            label: "UNDO",
            onPressed: () {
              setState(() {
                expenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text("No expenses found. Start adding some!"),
    );
    if (expenses.isNotEmpty) {
      mainContent =
          ExpensesList(expensesList: expenses, onRemoveExpense: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter Expense Tracker",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: width < 600
          ? Column(children: [
              Chart(expenses: expenses),
              Expanded(
                child: mainContent,
              ),
            ])
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: expenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
