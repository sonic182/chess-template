# Chess - Doofinder Code Challenge 2022

Project skeleton for the Doofinder Code Challenge 2022 (Chess Game)

## How to use this template

1. Press the _Fork_ button at the top-right part of the page to create your own copy.

![imagen](https://user-images.githubusercontent.com/482075/194920831-23fb1e14-83c6-4327-a496-bde225a77561.png)

2. Fill in the details.
3. Clone your newly created repo.
4. Make sure you use at least Elixir 1.12 (asdf!).
5. Install dependencies.
6. Think.
7. Code.

## Challenge Rules

- Participation in the competition will be individual.
- It's mandatory that all devs participate except the jury.
- The jury will be made up of Antonio Gutiérrez, Carlos Escribano, Enrique Martínez and Manuel Dominguez.
- When the time available to code the application is over, the code will be uploaded to the Github repository that was created from this template. If the application is not finished, what has been done will be uploaded.
- Each participant will show the application to the member of the jury he's assigned to for evaluation.

## Project requisites

- Create a web application to play chess with another player in real time ([chess rules in Spanish](https://es.wikipedia.org/wiki/Leyes_del_ajedrez)).
- You must use Phoenix and Phoenix LiveView.
- There must be a graphical UI to perform chess movements.
- UI must be updated in real time.
- UI must display which player won the game, if any.
- Apart from the board, feel free to add user/game feedback and to decide how to display it.
- Any other enhancement will be taken into account for the final score.

### Scope

The idea is that two players should be able to play a single game. You can make reasonable simplifications, like:

- Create a game by accessing a random URL like `/game/:game_name`. Sharing that URL the other player would be able to join the game.
- The user that creates the game uses the white pieces.

### Chess Board

- There's a pre-defined chess board with styles you can use as a starting point. It looks like the one in the image below.
- Final HTML is provided, you are responsible of generating the HTML based on your project's data models.

![imagen](https://user-images.githubusercontent.com/482075/194532319-b5dc8969-2737-4546-9f39-d6dc2b3a92b7.png)
