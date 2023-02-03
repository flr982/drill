import colorgram

# rgb_colors = []
# colors = colorgram.extract('image.jpg', 30)
#
# for color in colors:
#     r = color.rgb.r
#     g = color.rgb.g
#     b = color.rgb.b
#     new_color = (r, g, b)
#     rgb_colors.append(new_color)
#
# print(rgb_colors)

import turtle, random

color_list = [(207, 156, 100), (194, 138, 156), (139, 171, 200), (232, 209, 219), (145, 68, 91), (202, 215, 229),
              (169, 88, 55), (186, 150, 48), (225, 200, 117), (183, 94, 111), (196, 98, 77), (213, 227, 219),
              (137, 176, 147), (221, 173, 187), (129, 34, 58), (225, 176, 168), (99, 151, 98), (172, 187, 221),
              (160, 204, 214), (83, 128, 88), (84, 95, 134), (168, 205, 193), (115, 118, 161), (142, 34, 27),
              (85, 28, 56), (46, 56, 112), (88, 143, 158), (84, 36, 25), (220, 204, 27)]

y = -250

tim = turtle.Turtle()
turtle.colormode(255)
tim.penup()
tim.hideturtle()
tim.speed(10)

for _ in range(10):
    tim.sety(y)
    y += 50
    x = -250
    for _ in range(10):
        tim.setx(x)
        tim.dot(20, random.choice(color_list))
        x += 50

screen = turtle.Screen()
screen.exitonclick()
