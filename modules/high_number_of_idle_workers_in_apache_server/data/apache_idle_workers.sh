

#!/bin/bash



# Set the maximum number of idle workers allowed

${MAX_IDLE_WORKERS}



# Edit the Apache server configuration file to update the maximum number of idle workers

sudo sed -i "s/MaxRequestWorkers [0-9]*/MaxRequestWorkers $MAX_IDLE_WORKERS/g" /etc/apache2/apache2.conf



# Restart the Apache server to apply the changes

sudo service apache2 restart