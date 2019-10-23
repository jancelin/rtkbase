
## Param GNSS receiver

- Connect your gnss receiver F9P to PC with usb.
- Set your gnss receiver to output raw data with [U-center](https://www.u-blox.com/en/product/u-center)
- crtl F9
	- RATE: 200ms
	- PRT: USB protocol out UBX
	- MSG: RXM-RAWX > USB & RXM-SFRBX > USB & disable all NMEA
	- CFG: send

## install Docker

```
  sudo apt-get update
  sudo apt-get install curl 
  curl -fsSL https://get.docker.com/ | sh
  sudo systemctl enable docker
  sudo service docker start
  sudo groupadd docker
  sudo usermod -aG docker $USER
```

## install docker-compose

```
sudo apt-get install python-pip
sudo pip install docker-compose
```

## git clone basertk

```
sudo apt-get install git
git clone https://github.com/jancelin/rtkbase.git
```

## run

```
cd ./rtkbase/docker/root/basertk
docker-compose up
```
go to http://localhost:8000

```
F2
4 - Start RTCM3 & Logs
```
## modify param

- Right click on rtk.env
- edit
- Change base name: MNT_NAME=BASE > MNT_NAME=YOURBASE
- Change USB mount (/dev/tty?)  if necessary: COM_PORT=ttyACM0
- save

## connect to caster

- connect another GNSS receiver to http://caster.centipede.fr:2101 YOURBASE RTCM3 

## ubx data

ubx data are in ./rtkbase/docker/root/basertk/ubx
