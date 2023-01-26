MENU = {
    "espresso": {
        "ingredients": {
            "water": 50,
            "coffee": 18,
        },
        "cost": 1.5,
    },
    "latte": {
        "ingredients": {
            "water": 200,
            "milk": 150,
            "coffee": 24,
        },
        "cost": 2.5,
    },
    "cappuccino": {
        "ingredients": {
            "water": 250,
            "milk": 100,
            "coffee": 24,
        },
        "cost": 3.0,
    }
}

resources = {
    "water": 300,
    "milk": 200,
    "coffee": 100,
}

money = 0

is_on = True


def check_resources(choice):
    """Checks if there are enough resources and returns the received money."""
    resources_ok = False
    for ingredient in MENU[choice]["ingredients"]:
        if MENU[choice]["ingredients"][ingredient] > resources[ingredient]:
            print(f"Not enough {ingredient}. Only {resources[ingredient]} left.")
        else:
            resources_ok = True
    if resources_ok:
        money = get_money(choice)
        return money


def make_coffee(choice):
    """Makes the coffee according to the choice and returns the amount of money received"""
    print(f"Here is your {choice} ☕️. Enjoy!")
    for ingredient in MENU[choice]["ingredients"]:
        resources[ingredient] -= MENU[choice]["ingredients"][ingredient]
    return MENU[choice]["cost"]


def print_report():
    print(f'Water: {resources["water"]}')
    print(f'Milk: {resources["milk"]}')
    print(f'Coffee: {resources["coffee"]}')
    print(f'Money: ${money}')


def get_money(choice):
    print("Please insert coins.")
    money = 0
    quarters = int(input("How many quarters: "))
    dimes = int(input("How many dimes: "))
    nickles = int(input("How many nickles: "))
    pennies = int(input("How many pennies: "))
    paid = 25 * quarters + 10 * dimes + 5 * nickles + pennies
    if paid > 100 * MENU[choice]["cost"]:
        change = (paid - 100 * MENU[choice]["cost"]) / 100
        print(f"Here is ${change} back.")
        money = make_coffee(choice)
        return money
    elif paid == 100 * MENU[choice]["cost"]:
        print(f"You paid the exact amount. No change required.")
        money = make_coffee(choice)
    else:
        print("You don't have enough money.")
        return money


def refill():
    for ingredient in resources:
        resources[ingredient] += int(input(f"How much {ingredient} do you want to add: "))


while is_on:
    choice = input("What would you like? (espresso/latte/cappuccino): ")
    if choice == "off":
        print("Turning off")
        is_on = False
    elif choice == "espresso" or choice == "latte" or choice == "cappuccino":
        money += int(check_resources(choice))
    elif choice == "report":
        print_report()
    elif choice == "refill":
        refill()
    else:
        print("Wrong choice, we don't make that.")
