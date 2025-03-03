# from turtle import Turtle, Screen
# import another_module
#
# print(another_module.another_variable)
#
# timmy = Turtle()
# print(timmy)
# timmy.shape("turtle")
# timmy.color("DarkOrchid1")
# timmy.forward(100)
#
# my_screen = Screen()
# print(my_screen.canvheight)
#
# print(my_screen.canvwidth)
# my_screen.exitonclick()

from prettytable import PrettyTable

table = PrettyTable()
table.field_names = ["Pokemon Name", "Type"]
table.add_row(["Pikachu", "Electric"])
table.add_row(["Squirtle", "Water"])
table.add_row(["Charmander", "Fire"])
print(table)

table2 = PrettyTable()
table2.add_column("Pokemon Name", ["Pikachu", "Squirtle", "Carmander"])
table2.add_column("Type", ["Electric", "Water", "Fire"])
table2.add_column("Age", [3, 5, 4])
table2.add_column("Height", [1.5, 2, 1])
table2.align = "r"
print(table2)
