'use strict';

module.exports = {
    'L - List services': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml ps',
            // close window when done
            autoClose: false,
        });

        await CloudCmd.refresh();
    },
    'A - Up Base & Log': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml up base log',
            // close window when done
            autoClose: false,
        });

        await CloudCmd.refresh();
    },
    'B - Up Base RTK': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml up base',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    'L - Up Log': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml up log',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    'S - Stop log': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml stop log',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    'K - kill': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml kill',
            // close window when done
            autoClose: true,
        });

        await CloudCmd.refresh();
    },
    'R - Remove': async ({CloudCmd}) => {
        await CloudCmd.TerminalRun.show({
            command: ' docker-compose -f /mnt/fs/basertk/docker-compose.yml rm',
            // close window when done
            autoClose: true,
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
