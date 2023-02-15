from turtle import Turtle, Screen

tim = Turtle()
tim.pen(pensize=5)
screen = Screen()


def move_forwards():
    tim.forward(10)


def turn_left():
    tim.left(10)

def turn_right():
    tim.right(10)


def move_backwards():
    tim.backward(10)

def clear_scr():
    tim.up()
    tim.home()
    tim.clear()
    tim.down()


screen.listen()
screen.onkey(key="Up", fun=move_forwards)
screen.onkey(key="Right", fun=turn_right)
screen.onkey(key="Left", fun=turn_left)
screen.onkey(key="Down", fun=move_backwards)
screen.onkey(key="c", fun=clear_scr)


screen.exitonclick()