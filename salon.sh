#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"
MAIN_MENU () {
  if [[ ! -z $1 ]]
  then
    echo -e "\n$1"
  else
    echo -e "\n~~~~~ MY SALON ~~~~~\n"
    echo Welcome to My Salon, how can I help you?
  fi
  echo -e "\n1) cut\n2) color\n3) perm\n4) style\n5) trim"
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    1) SERVICE_SCREEN "cut" ;;
    2) SERVICE_SCREEN "color" ;;
    3) SERVICE_SCREEN "perm" ;;
    4) SERVICE_SCREEN "style" ;;
    5) SERVICE_SCREEN "trim" ;;
    *) MAIN_MENU "I could not find that service. What would you like today?" ;;
  esac
}

SERVICE_SCREEN() {
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id='$CUSTOMER_ID' AND phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    INSERT_NAME_RESULT=$($PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi

  echo -e "\nWhat time would you like your $1, $CUSTOMER_NAME?"
  read SERVICE_TIME

  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

  echo -e "\nI have put you down for a $1 at $SERVICE_TIME, $CUSTOMER_NAME."
}

MAIN_MENU