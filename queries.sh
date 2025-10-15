#!/bin/bash

# Load environment variables from .env file if it exists
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Check if required environment variables are set
if [ -z "$DB_USERNAME" ] || [ -z "$DB_PASSWORD" ]; then
    echo "Error: DB_USERNAME and DB_PASSWORD must be set"
    echo "Please create a .env file with your credentials or export them as environment variables"
    exit 1
fi

# Optional: Set defaults for host, port, and SID if not provided
DB_HOST="${DB_HOST:-oracle.scs.ryerson.ca}"
DB_PORT="${DB_PORT:-1521}"
DB_SID="${DB_SID:-orcl}"

# Construct connection string
CONNECTION_STRING="${DB_USERNAME}/${DB_PASSWORD}@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=${DB_HOST})(Port=${DB_PORT}))(CONNECT_DATA=(SID=${DB_SID})))"

QueryMenu()
{
    while [ "$CHOICE" != "START" ]
    do
        clear
        echo
        "================================================================="
        echo "| Query The Database |"
        echo "| <CTRL-Z Anytime to Enter Interactive CMD Prompt> |"
        echo "| <-- Go Back To Main Menu By Typing 'back' or 'b' -- |"
        echo "-----------------------------------------------------------------"
        echo " $IS_SELECTEDM b) Go Back to Main Menu"
        echo " "
        echo " $IS_SELECTED1 1) Get a complete inventory of supplies and medicines that can be ordered from the pharmacy"
        echo " $IS_SELECTED2 2) Based of the pending hospital supply order list, select the name of all the supplies that are less than 10000 in quantity"
        echo " $IS_SELECTED3 3) Get all medicines from the Pharmacy that are not in the Hospital’s medicine inventory"
        echo " $IS_SELECTED4 4) Find the count of hospital personnel in a unique role having the role of 'Doctor' or 'Nurse'"
        echo " $IS_SELECTED4 5) Count all the Hospital’s medicine orders having more than 10 orders"
        echo " $IS_SELECTED4 6) All orders of the hospital’s medicine order with the associated names of the personnel"
        echo " "
        echo " $IS_SELECTEDX X) Force/Stop/Kill Oracle DB"
        echo " "
        echo " $IS_SELECTEDE E) End/Exit"
        echo "Choose: "
        read CHOICE
        if [ "$CHOICE" == "0" ]
        then
            echo "Nothing Here"
        elif [ "$CHOICE" == "1" ]
        then
            bash ./1.sh
            Pause
        elif [ "$CHOICE" == "2" ]
        then
            bash ./2.sh
            Pause
        elif [ "$CHOICE" == "3" ]
        then
            bash ./3.sh
            Pause
        elif [ "$CHOICE" == "4" ]
        then
            bash ./4.sh
            Pause
        elif [ "$CHOICE" == "5" ]
        then
            bash ./5.sh
            Pause
        elif [ "$CHOICE" == "6" ]
        then
            bash ./6.sh
            Pause
        elif [ "$CHOICE" == "b" ] || [ "$CHOICE" == "back" ]
        then
            exit
        elif [ "$CHOICE" == "E" ]
        then
            exit
        else 
            echo "Invalid choice, please try again."
            Pause
        fi
    done
}

ProgramStart()
{
    StartMessage
    while [ 1 ]
    do
        QueryMenu
    done
}
ProgramStart



sqlplus "$CONNECTION_STRING" <<EOF

# logic

exit;
EOF