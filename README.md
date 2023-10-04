
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# High Number of Idle Workers in Apache Server
---

This incident occurs when there is a high number of idle workers in the Apache server. Idle workers are connections that have been established by clients but are not currently processing any requests. When the number of idle workers becomes too high, it can lead to performance issues and potentially impact the server's ability to handle incoming requests. This can lead to slow response times or even server crashes.

### Parameters
```shell
export APACHE_CONFIG_FILE_PATH="PLACEHOLDER"

export MAX_IDLE_WORKERS="PLACEHOLDER"
```

## Debug

### Check the Apache configuration file for the timeout value for idle workers
```shell
sudo grep -i "timeout" ${APACHE_CONFIG_FILE_PATH}
```

### Check the Apache configuration file for the maximum number of idle workers allowed
```shell
sudo grep -i "maxclients" ${APACHE_CONFIG_FILE_PATH}
```

### Check Apache status to see if there are any idle workers
```shell
sudo systemctl status apache2
```

### If the Apache service is running, check the number of idle workers
```shell
sudo apache2ctl fullstatus | grep -i "idle workers"
```

### Check the Apache error log for any errors related to idle workers
```shell
sudo tail -n 100 /var/log/apache2/error.log | grep -i "idle workers"
```

### Check the server's resource usage to see if there are any issues with CPU, memory, or disk I/O
```shell
sudo top
```

### Check the network connections to see if there are any issues with incoming requests
```shell
sudo netstat -an | grep -i "80"
```

### Check if there are any other processes consuming high resources causing Apache to become unresponsive
```shell
sudo top -c
```

## Repair

### Adjust the Apache server configuration to reduce the maximum number of idle workers allowed. This will prevent the server from becoming overloaded with idle connections and help to free up resources for incoming requests.
```shell


#!/bin/bash



# Set the maximum number of idle workers allowed

${MAX_IDLE_WORKERS}



# Edit the Apache server configuration file to update the maximum number of idle workers

sudo sed -i "s/MaxRequestWorkers [0-9]*/MaxRequestWorkers $MAX_IDLE_WORKERS/g" /etc/apache2/apache2.conf



# Restart the Apache server to apply the changes

sudo service apache2 restart


```