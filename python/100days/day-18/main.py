import turtle, random

tim = turtle.Turtle()

# tim.shape("arrow")
# tim.penup()
# tim.sety(200)
# tim.pendown()


# # Random walk
# speed = 1
# width = 1
# x = 0

# def draw_line():
#     angles = [0, 90, 180, 270]
#     tim.right(random.choice(angles))
#     tim.speed(speed)
#     tim.forward(25)
#     print(speed)
#
#
# for _ in range(1000):
#     r = random.randint(1, 255)
#     g = random.randint(1, 255)
#     b = random.randint(1, 255)
#     turtle.colormode(255)
#     tim.pen(pencolor=(r, g, b), pensize=width)
#     draw_line()
#     x += 1
#     if x % 25 == 0:
#         speed += 1
#         width += 1

# screen = turtle.Screen()
# screen.exitonclick()

# Draw shapes:
# def draw_shape(sides):
#     angle = 360 / sides
#     # r = random.randint(1,255)
#     # g = random.randint(1,255)
#     # b = random.randint(1,255)
#     # turtle.colormode(255)
#     # tim.pen(pencolor=(r, g, b), pensize=5)
#     for _ in range(sides):
#         r = random.randint(1, 255)
#         g = random.randint(1, 255)
#         b = random.randint(1, 255)
#         turtle.colormode(255)
#         tim.pen(pencolor=(r, g, b), pensize=5)
#         print(r, g, b)
#         tim.forward(150)
#         tim.right(angle)
#
#
# for i in range(3, 11):
#     draw_shape(i)


# Spirograph
tim = turtle.Turtle()
tim.speed("fastest")


def random_color():
    r = random.randint(1, 255)
    g = random.randint(1, 255)
    b = random.randint(1, 255)
    color = (r, g, b)
    return color


for _ in range(120):
    turtle.colormode(255)
    tim.pen(pencolor=random_color(), pensize=5)
    tim.circle(260)
    tim.right(3)

screen = turtle.Screen()
screen.exitonclick()
