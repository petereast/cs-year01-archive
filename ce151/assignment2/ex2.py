#! /bin/env python3

#Peter East - 1604513

#Hangman

import random

class game_state:
    def __init__(self, secret_word = '', lives=-1):
        """this function describes the start of the game"""

        self.secret_word = secret_word # To be loaded in another function

        self.current_guess = ['*']*len(secret_word) # A combination of correct characters & asterisks

        self.lives = lives


    def wordGuessed(self):
        return self.secret_word == "".join(self.current_guess)

    def getLives(self):
        return self.lives

    def getOutput(self):
        return "WORD: {0}; you have {1} lives left".format("".join(self.current_guess), self.getLives())

    def takeTurn(self, guess):

        if guess in self.secret_word:
            for index, char in enumerate(self.secret_word):
                if char == guess:
                    self.current_guess[index] = guess
        else:
            self.lives -= 1

    def getSecretWord(self):
        return self.secret_word

def playGame(word, number_of_lives):

    game = game_state(word, number_of_lives)

    while game.getLives() and not game.wordGuessed():
        print(game.getOutput())

        guess = input("Please enter a single, upper case character:\n>>>")
        while len(guess) != 1 or not guess.istitle():
            guess = input("Please enter a single, upper case character:\n>>>")

        game.takeTurn(guess)

    print(game.getOutput())
    if not game.getLives():
        print("You have no lives left, you lose\nThe word was {0}!".format(game.getSecretWord()))
    elif game.wordGuessed():
        print("Well done! You guessed the word")

def main():

    words = []

    filename = input("Please enter a filename:\n>>>")
    try:
        with open(filename) as words_file:
            words = words_file.readlines()
    except:
        print("Error - Invalid file or filename")
        return 0

    for index, word in enumerate(words):
        words[index] = word.strip()

    levels = {"e":10, "i":7, "h":5}
    while True:
        selection = input("Please select a level:\n  e - easy\n  i - intermediate\n  h - hard\n  q - quit\n\n>>>")
        while selection not in "eihq":
            print("invaid choice")
            selection = input("Please select a level:\n  e - easy\n  i - intermediate\n  h - hard\n  q - quit\n\n>>>")

        if selection == "q":
            break
        else:
            playGame(random.choice(words), levels[selection])

    print("Thank you for playing")

main()
