
# About

*PLS REMBER...*

![alt text](https://github.com/KnowledgeEnjoyer/rember/blob/master/plsrember.png?raw=true)

This is a project in which goal is to be a flashcard application in CLI, having very similar 
functionalities to Anki but in command line.
The main use case of this application is to serve as a way for studying my notes about various 
subjects that I take from courses, books, articles, documentations etc, avoiding the boring task of 
having to review the notes from time to time to keep that knowledge.
Moreover, having to open up an graphical interface just to study is not that conventional, like is 
done using Anki. Is preferable just write some command in terminal and start studying.

# Features 

## Create deck

User has two options for creating a new deck: using CLI or writing directly to some yaml file.
When deciding for CLI option, the user can create one with a single command input, specifying the 
data related to that deck, such as "Subject" of the deck.

When deciding for creating a new deck by writing, the user can just write a new yaml file inside 
~/.config/rember where the rember will use to store and query data from decks and their 
cards. Will have an option in CLI that user can use to create a template of a yaml file, with all 
necessary key-value pairs for a card deck.

The deck yaml file will have the fallowing structure:
```yaml
subject: Computer Network
cards:
  - question: |
      When it comes to computer networks, what is a Network Gateway?
      Why is it important?
    answer: |
      A Network Gateway is a network device used to communicate two or more different networks.
      It act as an translator between networks that have, mainly, different protocols. 
    repeat: true
```

Note: repeat can hold ``true``, ``false`` or a ``number`` representing days in which a card cannot 
appear again when studying the deck that contains such card.

Tasks for the first option:
- [Done] Implement the command ``rember deck new --subject=<subject>``
- [Done] When user enter the above command, create a new yaml file in ~/.config/rember containing 
``subject`` and ``cards`` keys. ``cards`` will be filled up later when adding new cards into a deck.
The yaml filename for a deck must be appended by a uuid.
- [Done] Check if user has .config folder in his home. If not, create one and create another folder inside
called rember.
- [Done] Do not allow running ``rember deck new`` without --subject option and its string value.
- Max filename size in Linux is 255. Be aware of it when using decks subjects as filename, considering 
that user has no limits for subject description. Do not allow yaml files for decks to have more than 
255 characteres.
- [Done] Add numeric IDs to each deck yaml file.

Tasks for the second option:

## List decks

A command will list all existing decks that user created. The yaml file that holds the data 
structure of those decks are in ~/.config/rember.

## Delete one deck

A command will delete one existing deck and all its cards. This also can be done deleting the yaml 
file for that deck in ~/.config/rember.

## Create card

A command will list all cards associated to one deck, along with their data such as "question".

## List cards

A command will list all cards associated to one deck.

## Delete one card

A command will delete one existing card. This also can be done deleting the card in yaml file for 
deck which contains that card.

## Study a deck

When user input a command specifying which deck he wants to study, a session will open and will 
guide the user through the cards for that deck. Some options will be displayed so user can choose, 
like "Show answer", "No repeat", "Next card" etc.

## Manually set space repetition for cards

Different from Anki, where the app itself decides how much time you will not see that card again, 
I think it is better that user can choose. Then, after visualizing the answer for one card, the 
user will decide if he wants to see that card again and specify how much time until that card
can appears again when studying a deck.

## Colors

Decks and their cards should have colorized text to be more visually pleasent.
