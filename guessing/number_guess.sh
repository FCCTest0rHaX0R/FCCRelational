#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
USERNAME_PROMPT() {
  # check for arguments
  # if argument found
  if [[ ! -z $1 ]]
  then
    # print argument
    echo -e "\n$1"
  # else (
  else
    # ask for username
    echo Enter your username:
  fi
  # read username
  read USERNAME
  # if username too long
  if [[ ${#USERNAME} -gt 22 ]]
  then
    # recall username prompt with argument
    USERNAME_PROMPT "Username is too long, try again:"
  # else (
  else
    # query db for user
    USER=$($PSQL "SELECT * FROM users WHERE username='$USERNAME'")
    # if user not found
    if [[ -z $USER ]]
    then
      # print first time message
      echo Welcome, $USERNAME! It looks like this is your first time here.
      # insert user into database
      INSERT_USER_RESULT=$($PSQL "INSERT INTO users (username, games_played, best_game) VALUES ('$USERNAME', 0, 10000)")
      # (remark: games_played and best_game have a default value of 0, so they do not need to be added
      # to the query)
    # else
    else
      # query db for games played, best game
      GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username='$USERNAME'")
      BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME'")
      # print welcome back message
      echo Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses.
    fi
  # )
  fi
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
  return $USER_ID
  # ^^^ this changes the function's exit status to the user_id
# )
}

NUMBER_GUESSING() {
  # This function takes in an argument and runs the guessing program with user input.
  # arg1: the number to play guessing game with
  # arg2: the username
  # [arg3]: the guesses
  # [arg4]: a message to show

  # # initialize guesses to 0
  # GUESSES=0

  # check for third argument
  # if so
  if [[ ! -z $3 ]]
  then
    # set guesses to this
    GUESSES=$3
  # if not
  else
    # set guesses to 0
    GUESSES=0
  fi

  # check for fourth argument
  # if so
  if [[ ! -z $4 ]]
  then
    # print fourth argument
    echo -e "\n$4"
  # else
  else
    # print guess the number message
    echo Guess the secret number between 1 and 1000:
  fi

  # read user input
  read USER_GUESS
  # check if input is an integer
  # if so
  if [[ $USER_GUESS =~ ^[0-9]+$ ]]
  then
    # increment guesses
    (( GUESSES ++ ))
    # check if user input is equal to first arg
    # if so
    if [[ $USER_GUESS -eq $1 ]]
    then
      # print you guessed it message
      echo You guessed it in $GUESSES tries. The secret number was $1. Nice job!
      # query db for games_played
      GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username='$2'");
      # increment games_played
      UPDATE_GAMES_PLAYED_RESULT=$($PSQL "UPDATE users SET games_played=$(( $GAMES_PLAYED+1 )) WHERE USERNAME='$2'")
      # query db for best_game
      BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username='$2'")
      # if guesses < best_game
      if [[ $GUESSES -lt $BEST_GAME ]]
      then
        # update best_game to guesses
        UPDATE_BEST_GAME_RESULT=$($PSQL "UPDATE users SET best_game=$GUESSES WHERE username='$2'")
      fi
    # else
    else
      # recall function with fourth argument if lesser or greater
      if [[ $1 -gt $USER_GUESS ]]
      then
        NUMBER_GUESSING $1 $2 $GUESSES "It's higher than that, guess again:"
      else
        NUMBER_GUESSING $1 $2 $GUESSES "It's lower than that, guess again:"
      fi
    fi
  # if not an integer
  else
    # recall with this is not an integer
    NUMBER_GUESSING $1 $2 $GUESSES "That is not an integer, guess again:"
  fi
}

GAME() {
  # print title
  echo -e "\n~~~~ GUESSING GAME ~~~~\N"
  # read user_id from exit status
  USERNAME_PROMPT
  USER_ID=$?
  # ^^^ this value gives the exit status, which is manually set by the return command to the user_id
  USERNAME=$($PSQL "SELECT username FROM users WHERE user_id=$USER_ID")

  # generate random number
  SECRET_NO=$(( RANDOM % 1000 + 1 ))
  # play guessing game
  NUMBER_GUESSING $SECRET_NO $USERNAME
}

GAME
