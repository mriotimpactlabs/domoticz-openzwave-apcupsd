FROM ohdarling/domoticz
MAINTAINER Michael.C Ryan: Lead Systems Engineer, Company: IoT Impact LABS, Email: mr@iotimpactlabs.com

#Update, then install vim, apcups deamon and cron.
RUN apt-get update && apt-get -y install vim apcupsd cron

#Add crontab file in the cron directory
ADD cronjobs /etc/cron.d/cronjobs
ADD read-apc-ups.sh /home/read-apc-ups.sh
ADD apcupsd.conf /etc/apcupsd/apcupsd.conf
ADD apcupsd /etc/default/apcupsd


#Give execution rights on the cron job
RUN chmod a+x /etc/init.d/apcupsd && chmod 755 /etc/init.d/apcupsd
RUN chmod a+x /opt/domoticz/domoticz && chmod 755 /opt/domoticz/domoticz
RUN chmod a+x /etc/cron.d/cronjobs && chmod 755 /etc/cron.d/cronjobs
RUN chmod a+x /home/read-apc-ups.sh && chmod 755 /home/read-apc-ups.sh

#Create the log file to be able to run tail
RUN touch /var/log/cron.log


CMD cron && tail -f /var/log/cron.log

#Build Command.
#docker build -t <ImageID> .

#Run command. This opens the ports and maps devices.
#docker run -it -p 8080:8080 --device=/dev/ttyACM0:/dev/ttyACM0 --device=/dev/usb:/dev/usb <ImageID>
