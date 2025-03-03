import turtle, random

tim = turtle.Turtle()
tim.speed("fastest")


def random_color():
    r = random.randint(1, 255)
    g = random.randint(1, 255)
    b = random.randint(1, 255)
    color = (r, g, b)
    return color


rotation = [0, 1, 2, 3]

for _ in range(5000):
    turtle.colormode(255)
    tim.pen(pencolor=random_color(), pensize=5)
    tim.right(random.choice(rotation) * 90)
    tim.forward(20)


screen = turtle.Screen()
screen.exitonclick()
