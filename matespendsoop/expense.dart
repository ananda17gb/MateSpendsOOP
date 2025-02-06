abstract class Expense {
  String? _category;
  double? _amount;
  String? _note;

  Expense({category, amount, note})
      : _category = category,
        _amount = amount,
        _note = note;

  String? get category => _category;
  double? get amount => _amount;
  String? get note => _note;

  set category(String? value) => _category = value;
  set amount(double? value) => _amount = value;
  set note(String? value) => _note = value;

  void display();
}

class FoodAndDrinksExpense extends Expense {
  FoodAndDrinksExpense(double amount, String note)
      : super(category: "Food and Drinks", amount: amount, note: note);
  @override
  void display() {
    print(
        "Food and Drinks Expense: $note, Amount: $amount, Category: $category");
  }
}

class TransportationExpense extends Expense {
  TransportationExpense(double amount, String note)
      : super(category: "Transportation", amount: amount, note: note);
  @override
  void display() {
    print(
        "Transportation Expense: $note, Amount: $amount, Category: $category");
  }
}

class EducationExpense extends Expense {
  EducationExpense(double amount, String note)
      : super(category: "Education", amount: amount, note: note);
  @override
  void display() {
    print("Education Expense: $note, Amount: $amount, Category: $category");
  }
}

class HousingAndUtilitiesExpense extends Expense {
  HousingAndUtilitiesExpense(double amount, String note)
      : super(category: "Housing and Utilities", amount: amount, note: note);
  @override
  void display() {
    print(
        "Housing and Utilities Expense: $note, Amount: $amount, Category: $category");
  }
}

class EntertainmentAndSocialActivitiesExpense extends Expense {
  EntertainmentAndSocialActivitiesExpense(double amount, String note)
      : super(
            category: "Entertainment and Social Activities",
            amount: amount,
            note: note);
  @override
  void display() {
    print(
        "Entertainment and Social Activities Expense: $note, Amount: $amount, Category: $category");
  }
}
