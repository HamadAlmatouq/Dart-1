class Item {
  String name;
  double price;

  Item(this.name, this.price);

  String displayItem() {
    return "$name - Price is ${price.toStringAsFixed(2)}";
  }
}

class ItemStock {
//Attributes
  Item item;
  int stock;

  //Con
  ItemStock(this.item, this.stock);

  //Check if in stock or not
  bool isInStock() {
    if (stock > 0) {
      return true;
    } else {
      return false;
    }
  }
}

class VendingMachine {
  List<ItemStock> items = [];
  double balance = 0;

  void addItem(Item item, int stock) {
    items.add(ItemStock(item, stock));
  }

  void displayItems() {
    print("Items Available:");

    //Should check in in stock or not and display status
    for (var itemStock in items) {
      String stockStatus;
      if (itemStock.isInStock()) {
        stockStatus = "In stock";
      } else {
        stockStatus = "Out of stock";
      }
      print(
          "${itemStock.item.displayItem()} (Stock: ${itemStock.stock}) - $stockStatus");
    }
  }

  void insertMoney(double amount) {
    balance = balance + amount;

    print("Inserted: ${amount.toStringAsFixed(2)}");
  }

  void selectItem(String itemName) {
    for (var itemStock in items) {
      if (itemStock.item.name == itemName) {
        // Check if in stock
        if (itemStock.isInStock()) {
          // Check if balance < item price after checkin
          if (balance < itemStock.item.price) {
            print("Not Enough for $itemName. please add more money: ");
            return;
          }

          // Dispense
          dispenseItem(itemStock);
          return;
        }
        // Print if not in stock
        print("$itemName is out of stock.");
        return;
      }
    }
    // If the item name was not found
    print("Item not found.");
  }

  void dispenseItem(ItemStock itemStock) {
    //After buying -1 to the stock
    balance = balance - itemStock.item.price;
    itemStock.stock - 1;

    print("Disspensing ${itemStock.item.name}...");
    print("Remaining balance: ${balance.toStringAsFixed(2)}");
  }

  double getChange() {
    double change = balance;
    balance = 0;
    return change;
  }
}

void main() {
  print("Welcome to the Vending Machine!");
  print("");

  var vendingMachine = VendingMachine();

  vendingMachine.addItem(Item("Soda", 2.50), 10);
  vendingMachine.addItem(Item("Chips", 1.50), 5);
  vendingMachine.addItem(Item("Candy", 1.00), 0);

  vendingMachine.displayItems();
  print("");

  double inserted = 3;
  vendingMachine.insertMoney(inserted);
  print("");

  String chosenitem = "Soda";
  print("Select item $chosenitem");
  vendingMachine.selectItem(chosenitem);

  print("");
  print("Thank you for using the vending machine!");
}
