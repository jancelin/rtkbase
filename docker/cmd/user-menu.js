'use strict';

module.exports = {
    '1 - Base rtkrcv Status': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml run --rm rcv rtkrcv -s',
            // close window when done
            autoClose: false,
        });

        await CloudCmd.refresh();
    },
    '2 - Make RINEX files': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml up conv',
            // close window when done
            autoClose: false,
        });

        await CloudCmd.refresh();
    },
    '3 - List services': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml ps',
            // close window when done
            autoClose: false,
        });

        await CloudCmd.refresh();
    },
    '4 - Start RTCM3': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml up rtcm3',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    '5 - Stop  RTCM3': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml stop rtcm3',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    '6 - Start   Logs': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml up log',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    '7 - Stop    Logs': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml stop log',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    '8 - kill ALL': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml kill',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    '9 - Remove ALL': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml rm',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    'A - Update system': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml pull',
            // close window when done
            closeMessage: 'Press any button to close Terminal & F2 & 4 - Start RTCM3 & Logs',
        });

        await CloudCmd.refresh();
    },
    'B - Update reveiver': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml run --rm receiver',
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
