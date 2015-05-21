if [[ -n $MYSQL_DATABASE_NAME ]]; then
  echo "=> Creating database $MYSQL_DATABASE_NAME"
  mysql -uroot -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE_NAME"

  if [[ -n $MYSQL_DATABASE_USER ]]; then
    echo "=> Creating database user $MYSQL_DATABASE_USER"
    mysql -uroot -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE_NAME}.* TO $MYSQL_DATABASE_USER IDENTIFIED BY '$MYSQL_DATABASE_PASSWORD'"
  fi
fi
