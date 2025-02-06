import 'dart:convert';
import 'dart:io';
import 'expense.dart';

class ExpenseManager {
  List<Expense> expenses = [];

  ExpenseManager() {
    expenses = loadExpenses();
  }

  void addExpense(String? name, List<String> categories) {
    print("\n==================== Add Expense ====================");
    for (int i = 0; i < categories.length; i++) {
      print("${i + 1}. ${categories[i]}");
    }
    stdout.write("Choose a category (1-${categories.length}): ");
    String? input = stdin.readLineSync();
    int categoryIndex = int.parse(input!);

    if (categoryIndex > 0 && categoryIndex <= categories.length) {
      String category = categories[categoryIndex - 1];
      print("\nYou've chosen $category.");
      stdout.write("What do you want to do with the money? ");
      String? note = stdin.readLineSync();
      stdout.write("How much money did you spend? ");
      String? amountInput = stdin.readLineSync();
      double amount = double.parse(amountInput!);

      Expense expense;
      switch (category) {
        case 'Food and Drinks':
          expense = FoodAndDrinksExpense(amount, note!);
          break;
        case 'Transportation':
          expense = TransportationExpense(amount, note!);
          break;
        case 'Education':
          expense = EducationExpense(amount, note!);
          break;
        case 'Housing and Utilities':
          expense = HousingAndUtilitiesExpense(amount, note!);
          break;
        case 'Entertainment and Social Activities':
          expense = EntertainmentAndSocialActivitiesExpense(amount, note!);
          break;
        default:
          print("Invalid category. Please try again.");
          return;
      }

      expenses.add(expense);
      saveExpenses();
      print("\nExpense added successfully!\n");
      printExpenses();
    } else {
      print("Invalid category. Please try again.\n");
    }
  }

  void editExpense(List<String> categories) {
    if (expenses.isEmpty) {
      print("\nThere are no expenses to edit.\n");
      return;
    }

    print("\n==================== Edit Expense ====================");
    printExpenses();
    stdout.write("Select the expense number to edit: ");
    String? input = stdin.readLineSync();
    int index = int.parse(input!) - 1;

    if (index >= 0 && index < expenses.length) {
      Expense expense = expenses[index];
      print("\nEditing expense #${input}: ${expense.note}");
      print("1. Edit Category");
      print("2. Edit Amount");
      print("3. Edit Note");
      print("4. Cancel\n");

      stdout.write("Your choice: ");
      String? choice = stdin.readLineSync();
      switch (choice) {
        case "1":
          for (int i = 0; i < categories.length; i++) {
            print("${i + 1}. ${categories[i]}");
          }
          stdout.write("Enter new category: ");
          String? categoryChoice = stdin.readLineSync();
          int newCategoryIndex = int.parse(categoryChoice!) - 1;
          String newCategory = categories[newCategoryIndex];

          switch (newCategory) {
            case 'Food and Drinks':
              expenses[index] =
                  FoodAndDrinksExpense(expense.amount!, expense.note!);
              break;
            case 'Transportation':
              expenses[index] =
                  TransportationExpense(expense.amount!, expense.note!);
              break;
            case 'Education':
              expenses[index] =
                  EducationExpense(expense.amount!, expense.note!);
              break;
            case 'Housing and Utilities':
              expenses[index] =
                  HousingAndUtilitiesExpense(expense.amount!, expense.note!);
              break;
            case 'Entertainment and Social Activities':
              expenses[index] = EntertainmentAndSocialActivitiesExpense(
                  expense.amount!, expense.note!);
              break;
            default:
              print("Invalid category.");
              return;
          }
          break;
        case "2":
          stdout.write("Enter new amount: ");
          String? newAmount = stdin.readLineSync();
          expenses[index].amount = double.parse(newAmount!);
          break;
        case "3":
          stdout.write("Enter new note: ");
          expenses[index].note = stdin.readLineSync();
          break;
        case "4":
          print("Edit canceled.\n");
          return;
        default:
          print("Invalid choice. Returning to the menu.\n");
          return;
      }
      saveExpenses();
      print("Expense updated successfully!\n");
      printExpenses();
    } else {
      print("Invalid selection.\n");
    }
  }

  void deleteExpense() {
    if (expenses.isEmpty) {
      print("\nThere are no expenses to delete.\n");
      return;
    }

    print("\n==================== Delete Expense ====================");
    printExpenses();
    stdout.write("Select the expense number to delete: ");
    String? input = stdin.readLineSync();
    int index = int.parse(input!) - 1;

    if (index >= 0 && index < expenses.length) {
      stdout.write("Are you sure you want to delete this expense? (y/n): ");
      String? confirm = stdin.readLineSync();
      if (confirm?.toLowerCase() == 'y') {
        expenses.removeAt(index);
        saveExpenses();
        print("Expense deleted successfully!\n");
        printExpenses();
      } else {
        print("Deletion canceled.\n");
      }
    } else {
      print("Invalid selection.\n");
    }
  }

  void printExpenses() {
    print("\n==================== Your Expenses ====================");
    double totalSpent = 0;
    for (int i = 0; i < expenses.length; i++) {
      print("${i + 1}. ${expenses[i].note}");
      print("   You spent Rp.${expenses[i].amount}");
      print("   Category: ${expenses[i].category}\n");
      totalSpent += expenses[i].amount!;
    }
    print("Total amount spent: Rp.${totalSpent}\n");
  }

  void saveExpenses() {
    try {
      File file = File('expenses.json');
      List<Map<String, dynamic>> data = [];
      for (var expense in expenses) {
        data.add({
          'category': expense.category,
          'amount': expense.amount,
          'note': expense.note,
        });
      }
      file.writeAsStringSync(jsonEncode(data));
    } catch (e) {
      print("Error saving expenses: $e");
    }
  }

  List<Expense> loadExpenses() {
    List<Expense> expenses = [];
    try {
      File file = File('expenses.json');
      if (file.existsSync()) {
        String contents = file.readAsStringSync();
        List<dynamic> data = jsonDecode(contents);
        for (var expense in data) {
          switch (expense['category']) {
            case 'Food and Drinks':
              expenses.add(
                  FoodAndDrinksExpense(expense['amount'], expense['note']));
              break;
            case 'Transportation':
              expenses.add(
                  TransportationExpense(expense['amount'], expense['note']));
              break;
            case 'Education':
              expenses
                  .add(EducationExpense(expense['amount'], expense['note']));
              break;
            case 'Housing and Utilities':
              expenses.add(HousingAndUtilitiesExpense(
                  expense['amount'], expense['note']));
              break;
            case 'Entertainment and Social Activities':
              expenses.add(EntertainmentAndSocialActivitiesExpense(
                  expense['amount'], expense['note']));
              break;
            default:
              print("Unknown category: ${expense['category']}");
          }
        }
      }
    } catch (e) {
      print("Error loading expenses: $e");
    }
    return expenses;
  }
}
