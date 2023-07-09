import 'dart:io';

import 'package:expense_tracker/enums/category_enum.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/expenses_widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.onAddExpense,
  });
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstData = DateTime(
      now.year - 1,
      now.month,
      now.day,
    );

    _selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstData,
      lastDate: now,
    ) as DateTime;

    setState(() {});
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Invalid input"),
            content: const Text(
              "Please make sure a valid title, amount and date were entered.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Okay"),
              )
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Invalid input"),
            content: const Text(
              "Please make sure a valid title, amount and date were entered.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Okay"),
              )
            ],
          );
        },
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final softKeyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 16, left: 16, right: 16, bottom: softKeyBoardSpace + 32),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextField(
                              titleController: _titleController,
                              labelString: "Title",
                              inputMaxLength: 50),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: CustomTextField(
                            titleController: _amountController,
                            labelString: "Amount",
                            inputType: TextInputType.number,
                            prefexText: "\$ ",
                          ),
                        ),
                      ],
                    )
                  else
                    CustomTextField(
                        titleController: _titleController,
                        labelString: "Title",
                        inputMaxLength: 50),
                  const SizedBox(
                    height: 12,
                  ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items: Category.values.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_selectedDate == null
                                  ? "No date selected"
                                  : formatter.format(_selectedDate!)),
                              IconButton(
                                  onPressed: _presentDatePicker,
                                  icon: const Icon(
                                    Icons.calendar_month,
                                  ))
                            ],
                          ),
                        )
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            titleController: _amountController,
                            labelString: "Amount",
                            inputType: TextInputType.number,
                            prefexText: "\$ ",
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_selectedDate == null
                                  ? "No date selected"
                                  : formatter.format(_selectedDate!)),
                              Expanded(
                                child: IconButton(
                                    onPressed: _presentDatePicker,
                                    icon: const Icon(
                                      Icons.calendar_month,
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (width >= 600)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              // هنا الكونتيكست خاص بالمودال
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Save Expense"),
                        )
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items: Category.values.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        TextButton(
                            onPressed: () {
                              // هنا الكونتيكست خاص بالمودال
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Save Expense"),
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
