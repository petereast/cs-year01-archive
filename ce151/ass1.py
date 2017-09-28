"""
ass1.py
CE151 assignment 1 template
created by sands 30/10/10
modified by sands 28/10/11 - number of exercises changed
modified by sands 28/10/6 - number of exercises changed, example added
modified by pe16564 30/10/16 - Started assignments
"""

from math import sqrt
import math

def ex0():
    """
    example
    use 8 at exercise selection prompt in my code to select it
    """
    i = int(input("Enter a non-negative integer: "))
    if i<0:
        print("Negative numbers do not have real square roots")
    else:
        root = sqrt(i)
        print("The square root is", round(root, 2))

def ex1() :
    """
    exercise 1
    """
    print("Exercise 1 - Triangle stuff")

    height = float(input("Enter the height: "))
    width = float(input("Enter the width: "))

    print("The length of the hypotenuse is {0}".format(sqrt(height**2 + width**2)))

    angle_in_degrees = math.degrees(math.atan(height/width))
    print("The first of the two interior angles is {0:.1f}".format(angle_in_degrees))

    print("The 2nd of the two interior angles is {0:.1f}".format(180-(90+angle_in_degrees)))

def ex2() :
    """
    exercise 2
    """
    print("Exercise 2 - Fibonacci")

    n = int(input("Enter the value for n: "))
    seq = [0, 1] + [i for i in range(n)]

    for index, num in enumerate(range(n)):
        seq[index+2] = seq[index+1] + seq[index]
        print(seq[index+2], end=",")

def ex3() :
    """
    exercise 3
    """
    print("Exercise 3 - Binomial Coefficient")

    x = int(input("Please enter a positive integer value for x: "))
    y = int(input("Please enter a positive integer value for y: "))
    coef = None
    if x == y:
        coef = 1
    elif y < x:
        seq = [x for x in range(x-(y+1), x)]
        mul = 1
        for number in seq:
            mul *= number

        coef = mul // math.factorial(y)
    else:
        print("Invalid value for X or Y")


    print("The Coefficient is {0}".format(coef))


def ex4() :
    """
    exercise 4
    """
    print("Exercise 4 - Sentence processing")
    print("Note: I did this exercise twice as my primary method of completing this task seemed too easy.")

    string = input("Enter some words: ")

    longest = 0
    shortest = len(string)

    for word in string.split():
        print(word)
        if len(word) > longest:
            longest = len(word)
        if len(word) < shortest:
            shortest = len(word)

    print("Longest word: {0}\nShortest word: {1}".format(longest, shortest))

    # Because that's the easy way of doing it, I'll write a more longwinded solution here

    def ex4_extra():
        """
        Exercise 4 - Longwinded edition
        """
        string = input("Enter some words: ")
        words = []
        current_word = ""
        for char in string:
            if char not in [" ", "\n", "\t"]:
                current_word += char
            else:
                if current_word != "": words.append(current_word)
                current_word = ""
        for w in words: print(w)
    #ex4_extra()

def ex5() :
    """
    exercise 5
    """
    print("Exercise 5 - Vowels")

    vowels = {"a":0, "e":0, "i":0, "o":0, "u":0}
    vowels_list = list("aeiou")

    string = input("Please enter a string: ")

    for char in string:
        if char in vowels_list:
            vowels.update({char:vowels[char]+1})


    lowest_v = ''
    lowest_c = len(string)
    for pair in vowels:

        if vowels[pair] < lowest_c:
            lowest_c = vowels[pair]
            lowest_v = pair
        elif vowels[pair] == lowest_c:
            lowest_v+=pair

    grammar = " is"
    if len(lowest_v) != 1: grammar = "s are"
    print("The least frequent vowel{2}: {0} ({1})".format(lowest_v, lowest_c, grammar))


def ex6() :
    """
    exercise 6
    """
    print("Exercise 6 - Bubble Sort")
    print("Enter a sequence of positive integers, enter -1 to end")

    numbers = []

    x = int(input(">>> "))
    while x > 0:
        numbers.append(x)
        xa = input(">>> ")
        try:
            x = int(xa)
        except ValueError:
            print("Number list accepted")
            break

    print("before:", numbers)

    # TODO: Sort the numbers

    unchanged = False

    while not unchanged:
        unchanged = True
        for index, value in enumerate(numbers):
            if index != 0:
                if value > numbers[index-1]:
                    numbers[index], numbers[index-1] = numbers[index-1], numbers[index]
                    unchanged = False
    print(numbers)

def ex7() :
    """
    exercise 7 - Reverse Polish Notation
    """
    print("Exercise 7 - RPN")

    VALID_OPERATORS = ["-", "+", "*"]

    ops = {"-":lambda x, y: x - y, "+":lambda x, y: x + y, "*":lambda x, y: x*y}

    s_expr = input("Enter an expression using RPN to be evaluated: ")
    # Remove spaces from expression, convert into list.
    expr = list("".join(s_expr.split()))

    values = []

    for item in expr:
        print(values)
        try:
            values.append(int(item))
        except ValueError:
            if item in VALID_OPERATORS and len(values) >= 2:
                #  Valid state

                values.append(ops[item](values.pop(), values.pop()))
                print(values)
            elif item not in VALID_OPERATORS:
                print("Invalid Operation: invalid operator")

    if len(values) == 1:
        print("The value of this espression is: {0}".format(values[0]))
    else:
        print("Invalid Operation: operator-operand mismatch")



    # print(expr)
    # OPERATORS = {"-":0, "+":1,"*":2}
    #
    # expr.reverse()
    #
    # for index, item in enumerate(expr):
    #     if item in OPERATORS:
    #         expr[index] = ops[OPERATORS[item]](expr[index+1], index[expr+2])
# modify the following line so that your name is displayed instead of Lisa's
print("CE151 assignment 1 - Peter East")

# do not modify anything beneath this line
exlist = [None, ex1, ex2, ex3, ex4, ex5, ex6, ex7, ex0]
running = True
while running :
    line = input("Select exercise (0 to quit): ")
    if line == "0" : running = False
    elif len(line)==1 and "1"<=line<="8": exlist[int(line)]()
    else : print("Invalid input - try again")
