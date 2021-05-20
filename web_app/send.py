
import socket

buoy = 'buoy_test'
connected = False


def connectCentral():
    global conCentral
    conCentral = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    addrC = ('147.100.179.215', 8090)
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
            connectCentral()
            connected = True
            while 1:
                d = conRtk.recv(2048).decode()
                if d:
                    data = d.split()
                    data.append(buoy)
                    print(data)
                    s = " "
                    data = s.join(data)
                    conCentral.sendall(data.encode('utf-8'))
                    print('data send')
                if d == '':
                    connected = False
                    break
        except:
            pass


