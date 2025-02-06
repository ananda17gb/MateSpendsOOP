import 'dart:io';
import 'dart:convert';
import 'expense_manager.dart';
import 'expense.dart';
import 'user.dart';

void main() {
  ExpenseManager manager = ExpenseManager();
  User user = User(name: '');
  List<Expense> expenses = [];
  List<String> categories = [
    "Food and Drinks",
    "Transportation",
    "Education",
    "Housing and Utilities",
    "Entertainment and Social Activities"
  ];

  print("\n==================== MateSpends ====================");
  String? name = user.loadName();
  if (name == null) {
    print(
        "\nHello there😊! Welcome to MateSpends, track your daily expenses at your fingertips!\n");
    print("Please enter your name:");
    name = stdin.readLineSync();
    user.saveName(name!);
  } else {
    print("\nWelcome back, $name!\n");
    expenses = manager.loadExpenses();
  }
  mainMenu(name, expenses, categories, manager);
}

void mainMenu(String? name, List<Expense> expenses, List<String> categories,
    ExpenseManager manager) {
  bool hadExpenses = false;
  while (true) {
    print("\n==================== Main Menu ====================");
    if (expenses.isEmpty && !hadExpenses) {
      print(
          "It seems you haven't added any expenses. Let's start with adding your first expense!\n");
      manager.addExpense(name, categories);
      hadExpenses = manager.expenses.isNotEmpty;
      expenses = manager.expenses;
    } else {
      print("Please choose an option:");
      print("1. Add Expense");
      print("2. Edit Expense");
      print("3. Delete Expense");
      print("4. View Expenses");
      print("0. Exit\n");

      stdout.write("Your choice: ");
      String? option = stdin.readLineSync();
      switch (option) {
        case "1":
          manager.addExpense(name, categories);
          expenses = manager.expenses;
          break;
        case "2":
          manager.editExpense(categories);
          expenses = manager.expenses;
          break;
        case "3":
          manager.deleteExpense();
          expenses = manager.expenses;
          break;
        case "4":
          manager.printExpenses();
          break;
        case "0":
          print("\nThank you for using MateSpends! Goodbye.\n");
          return;
        default:
          print("Invalid option. Please try again.\n");
      }
    }
  }
}
