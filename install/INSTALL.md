## Experimental

> From https://github.com/Stefal/rtkbase

> Build with https://github.com/jancelin/image-builder-rpi/tree/BaseRTK_v0.3.1

# Material

* Raspberry Pi 3 or 4

* Micro SD 16Go

* [F9P](https://store.drotek.com/rtk-zed-f9p-gnss)

* [D910](https://store.drotek.com/da-910-multiband-gnss-antenna)

# Installation and use

* [Install U-center](https://www.u-blox.com/en/product/u-center)

* [Update F9P firmware](https://drotek.gitbook.io/rtk-f9p-positioning-solutions/tutorials/updating-zed-f9p-firmware)

* Download [baseRTK-rpi-V0.3.1.img.zip](https://github.com/jancelin/rtkbase/releases/download/baseRTK-rpi-V0.3.1/baseRTK-rpi-V0.3.1.img.zip)

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

# THEN...

* 1. do to /receiver_cfg directory and click on F2 > "update receiver"

* 2. right click on ```settings.conf``` file > Edit > 
        - change ```position='45.999381 -1.213787 50'``` by an approximate position of the antenna ('lat long height'), the precise calculation of the position will be done later.
	- change ```mnt_name``` ex: ```mnt_name=FOO```
        - ctrl s (save)
* 3. click on F2 > Stop RTCM3 & Stop Log

* 4. click on F2 > Start RTCM3 & Start Log

* 5. Go to the /data directory to check that the news logs are writing (refresh)

* 6. Wait 24h

* 7. Go to the /data directory & download the last 0000-00-00-0000-RINEX_BASE_Xs_Yh.zip (right click)

* 8. unzip 0000-00-00-0000-RINEX_BASE_Xs_Yh.zip

* 9. [Use this procedure to calculate the position](https://jancelin.github.io/centipede/4_positionnement.html)

* 10. Change ```position='45.999381 -1.213787 50'```  by the calculated precise position ```position='47.164793708 -1.948418882 63.0592'```

* 11. Click on F2 > Stop RTCM3 & Start RTCM3

* 12. Verify connection : 
	- > right click on ```rtkrcv.conf``` file 
        - > Edit > modify ligne 106: ```:@caster.centipede.fr:2101/BASE:``` by yours ex: ```@caster.centipede.fr:2101/FOO:``` 
        - > ctrl s (save)

* 13. click on F2 > ```Base rtkrcv Status```

* 14. Wait 30s and write ```status``` enter & Check that you have values ex:
        - ...
	- ```# of rtcm messages rover    : 1004(24),1012(24),1019(11),1020(12),1045(3),1046(2),1077(25),1087(25),1097(25),1127(25)```
        - ...
        - ```pos xyz single (m) rover    : 4195923.155,159534.157,4784995.569```
        - ```pos llh single (deg,m) rover: 48.92293482,2.17740715,84.661```
        - ...

* 15. If OK then GNSS RTK base is working with Centipede Caster

* 12. send an email to contact@centipede.fr to activate the base on the [Centipede map](https://centipede.fr)
	- name
	- email
	- mount Point Name
	- material

# SSH

ssh centipede@centipede.local

password: centipede

```
sudo -s 
cd /rtkbase
```

# Inside baseRTK-rpi-V0.3.1

* Debian 10 Buster 

* [RTKbase](https://github.com/Stefal/rtkbase.git)

* [RTKLIB 2.4.3](https://github.com/tomojitakasu/RTKLIB.git)

* [Cloud CMD](https://github.com/coderaiser/cloudcmd)


# Image

* [Image builder](https://github.com/jancelin/image-builder-rpi/blob/baseRTK-rpi-V0.3.1)




