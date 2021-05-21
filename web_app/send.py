from RTKBaseConfigManager import RTKBaseConfigManager
import socket
import os

#Get settings from settings.conf.default and settings.conf
rtkbaseconfig = RTKBaseConfigManager(os.path.join(os.path.dirname(__file__), "../settings.conf.default"), os.path.join(os.path.dirname(__file__), "../settings.conf"))

buoy = rtkbaseconfig.get("send", "send_id").strip("'")
connected = False
connectedC = False

def connectCentral():
    global conCentral
    conCentral = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    ipC = rtkbaseconfig.get("send", "send_ip").strip("'")
    portC = int(rtkbaseconfig.get("send", "send_port").strip("'"))
    addrC = (ipC, portC)
    conCentral.connect(addrC)

def connectRtk():
    global conRtk
    conRtk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    addr = ('127.0.0.1', 5099)
    conRtk.connect(addr)

while True:
    if(not connected):
        try:
            connectRtk()
            #print('connected to Rtkrcv')
            connected = True
            while 1:
                d = conRtk.recv(2048).decode()
                if d:
                    data = d.split()
                    data.append(buoy)
                    #print(data)
                    if(not connectedC):
                        try:
                            connectCentral()
                            connectedC = True
                            s = " "
                            data = s.join(data)
                            connectedC = False
                            conCentral.sendall(data.encode('utf-8'))
                            #print('data send')
                            connected = False
                            conCentral.close()
                            break
                        except:
                            pass
                if d == '':
                    connected = False
                    break
        except:
            pass


