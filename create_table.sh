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

sqlplus "$CONNECTION_STRING" <<EOF

# logic

exit;
EOF