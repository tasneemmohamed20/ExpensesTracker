import 'package:expenses_tracker/widgets/chart/chart.dart';
import 'package:expenses_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter course 1',
        amount: 19.99,
        category: Category.food,
        date: DateTime.now()),
    Expense(
        title: 'Flutter course 2',
        amount: 18.99,
        category: Category.work,
        date: DateTime.now()),
    Expense(
        title: 'Flutter course 3',
        amount: 17.99,
        category: Category.leisure,
        date: DateTime.now()),
    Expense(
        title: 'Flutter course 4',
        amount: 16.99,
        category: Category.travel,
        date: DateTime.now()),
    Expense(
        title: 'Flutter course 5',
        amount: 15.99,
        category: Category.food,
        date: DateTime.now()),
    Expense(
        title: 'Flutter course 6',
        amount: 19.99,
        category: Category.food,
        date: DateTime.now()),
    Expense(
        title: 'Flutter course 7',
        amount: 18.99,
        category: Category.work,
        date: DateTime.now()),
    Expense(
        title: 'Flutter course 8',
        amount: 17.99,
        category: Category.leisure,
        date: DateTime.now()),
    Expense(
        title: 'Flutter course 9',
        amount: 16.99,
        category: Category.travel,
        date: DateTime.now()),
    Expense(
        title: 'Flutter course 10',
        amount: 15.99,
        category: Category.food,
        date: DateTime.now()),
  ];
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: const Text('Expense deleted..'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('There is no Expenses found.. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Expenses Tracker'),
          actions: [
            IconButton(
                onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
          ],
        ),
        body: width<600? Column(
          children: [
            Chart(expenses: _registeredExpenses),
            Expanded(child: mainContent),
            // const Text('Expenses list..'),
          ],
        ) : Row(
          children: [
            Expanded(child: Chart(expenses: _registeredExpenses)),
            Expanded(child: mainContent),
            // const Text('Expenses list..'),
          ],
        )
      ),
    );
  }
}
