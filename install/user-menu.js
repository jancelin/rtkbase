'use strict';

module.exports = {
    '1 - RTK Receiver ON': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: 'sudo rtkrcv -s -o rtkrcv.conf',
            // close window when done
            autoClose: false,
        });

        await CloudCmd.refresh();
    },
    '2 - RTK Receiver OFF': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: 'sudo killall rtkrcv',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    '3 - Make RINEX files': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' sudo /rtkbase/convbin.sh',
            // close window when done
            autoClose: false,
        });

        await CloudCmd.refresh();
    },
    '4 - List services': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: 'sudo /rtkbase/status.sh',
            // close window when done
            autoClose: false,
        });

        await CloudCmd.refresh();
    },
    '5 - Start RTCM3': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: 'sudo systemctl start str2str_ntrip.service',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    '6 - Stop RTCM3': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: 'sudo systemctl stop str2str_ntrip.service',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    '7 - Start Log': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: 'sudo systemctl start str2str_file.service',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    '8 - Stop Log': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: 'sudo systemctl stop str2str_file.service',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    'A - Start BT': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: 'sudo /rtkbase/BT/BT_ON.sh',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    'B - Stop BT': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: 'sudo /rtkbase/BT/BT_OFF.sh',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    'C - Update system': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: 'sudo /rtkbase/upd/upd.sh',
            // close window when done
            closeMessage: 'Press any button to close Terminal',
        });

        await CloudCmd.refresh();
    },
    'D - Update reveiver': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: 'sudo /rtkbase/ubxconfig.sh /dev/ttyACM0 /rtkbase/receiver_cfg/U-Blox_ZED-F9P_rtkbase.txt --force',
            // close window when done
            autoClose: false,
        });

        await CloudCmd.refresh();
    },
    'E - Reboot': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: 'sudo reboot',
            // close window when done
            autoClose: false,
        });

        await CloudCmd.refresh();
    },
};

async function createDefaultMenu({path, data, DOM, CloudCmd}) {
    const {IO} = DOM;
    
    await IO.write(path, data);
    await CloudCmd.refresh();
    
    DOM.setCurrentByName('.cloudcmd.menu.js');
    
    await CloudCmd.EditFile.show();
}

async function readDefaultMenu({prefix}) {
    const res = await fetch(`${prefix}/api/v1/user-menu/default`);
    const data = await res.text();
    
    return data;
}

module.exports._selectNames = selectNames;
function selectNames(names, panel, {selectFile, getCurrentByName}) {
    for (const name of names) {
        const file = getCurrentByName(name, panel);
        selectFile(file);
    }
}

module.exports._compare = compare;
function compare(a, b) {
    const result = [];
    
    for (const el of a) {
        if (b.includes(el))
            continue;
        
        result.push(el);
    }
    
    return result;
}
