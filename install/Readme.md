## Experimental

# Installation and use

* Download [baseRTK-rpi-V0.2.5.img.zip](https://github.com/jancelin/rtkbase/releases/download/baseRTK-rpi-V0.2.5/baseRTK-rpi-V0.2.5.img.zip)

* flash this image with [etcher](https://www.google.com/search?client=firefox-b-1-d&q=etcher)  (windows,mac, linux) on a micro sd card 16 Go mini

* plug in micro sd on Raspberry pi

* connect ethernet (with internet alive)

* connect USB GNSS F9P 

> option: connect raspberry pi on a screen for view install logs.

* powers the raspberry pi and wait env 2 min (see logs)

* go to http://centipede.local:8000

* go to /rtkbase

* Edit settings.conf: right click > Edit 

* click on F2 &
    - 1 - base [rtkrcv](https://manpages.debian.org/unstable/rtklib/rtkrcv.1.en.html) status: print solution/status (signal, satellites, ...) of GNSS antenna to the caster. ex: ```status``` ```satellite``` ```observ``` ```stream``` ```help```
    - 2 - make Rinex Files: Make Rinex files from Log (.ubx) for calculate xyz [base position](http://rgp.ign.fr/SERVICES/calcul_online.php). All data are in /data
    - 3 - List services: display health of tcp, file and ntrip service.
    - 4 - Start RTCM3: start ntrip service to send rtcm3 data to the caster. 
    - 5 - Stop RTCM3: stop ntrip service
    - 6 - Start Log: start log service for save .ubx data
    - 7 - Stop Log: stop log
    - A - update system: checkin and update file system (git pull)
    - B - update receveir: go to /receiver_cfg before. Updating GNSS antenna [F9P](https://github.com/jancelin/rtkbase/blob/master/receiver_cfg/U-Blox_ZED-F9P_config_info.txt) parameters to get a RTK base station 


# Inside baseRTK-rpi-V0.2.5

* Debian 10 Buster 

* [RTKLIB 2.4.3](https://github.com/tomojitakasu/RTKLIB.git)

* [Cloud CMD](https://github.com/coderaiser/cloudcmd)

* [RTKbase](https://github.com/Stefal/rtkbase.git)

# Image

* [Image builder](https://github.com/jancelin/image-builder-rpi/blob/baseRTK-rpi-V0.2.5)




