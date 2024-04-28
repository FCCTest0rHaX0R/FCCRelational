PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
    ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
    ATOMIC_NUMBER=$1
  else
    ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1' OR name='$1'")
    ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1' OR name='$1'")
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1'")
  fi
  if [[ -z $ELEMENT_NAME ]]
  then
    echo I could not find that element in the database.
  else
    PROPERTIES=$($PSQL "SELECT * FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    echo $PROPERTIES | while IFS='|' read ATOM_NO MASS MELTING BOILING TYPE_ID
    do
      TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
      echo The element with atomic number $ATOM_NO is $ELEMENT_NAME \($ELEMENT_SYMBOL\). It\'s a $TYPE, with a mass of $MASS amu. $ELEMENT_NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius.
    done
  fi

fi
