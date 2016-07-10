# EventPC-Setup
Sets streaming and gaming machines up for event deployment

## How to Use
1. Clone or download the repository from GitHub
2. Download what you need and keep it in the same directory as the script.  Make sure they are named correctly. It may be useful to get the full "offline" installer instead of the bootstrap installer.  Hint: [FileHippo](https://filehippo.com/) is your friend

    Application|Executable
    ---|---
    [OBS Studio](https://obsproject.com/)|`OBS-Studio-*-Installer.exe`
    [Steam](https://steampowered.com/)|`SteamSetup.exe`
    [Battle.net](https://battle.net/)|`Battle.net-Setup.exe`
    [Origin](https://origin.com/)|`OriginSetup.exe`
    [NVIDIA](https://nvidia.com/)|`*-desktop-*-international-whql.exe`

3. Copy stream settings into `obs-studio\` using the instructions under [Backing up and restoring stream settings](#backing-up-and-restoring-stream-settings)
4. Copy games into the appropriate folder using the instructions under [Backing up and restoring games](#backing-up-and-restoring-games)

     Type|Location
     ---|---
     Steam|`steamapps\`
     Battle.net|`battle.net\`
     Origin|`origin\`

5. Open a command prompt as a local administrator
6. Run `powershell -ExecutionPolicyBypass`
7. Run `.\EventPC-Setup.ps1 -Streamer` or `.\EventPC-Setup.ps1 -Gamer` depending on what the computer will be doing

## Backing up and restoring stream settings
1. Configure OBS Studio to your preference
2. Open `%APPDATA%\obs-studio` and copy `global.ini`, and the `basic` folder to the `obs-studio\` directory.  You can also copy the `plugin_config` folder if you have custom settings
3. After installing OBS Studio, your settings will be restored
4. Edit the record folder, logo, and loop videos for OBS Studio

## Backing up and restoring games
### Steam
1. Install Steam and the games you wish to restore to the event computer. I'll be using [Keep Talking and Nobody Explodes](http://www.keeptalkinggame.com/) as an example.
2. Navigate to your `steamapps\` folder, which is normally `C:\Program Files (x86)\Steam\steamapps\`
3. Copy the app manifest (`appmanifes_341800.acf` in this example) and paste it into the local `steamapps` folder
4. Copy the game folder inside of the `common\` directory (`Keep Talking and Noboby Explodes` in this example) and paste it into the local `steamapps\common\` folder
5. After installing Steam on the event PC, the game should be ready to play.

### Battle.net
http://us.battle.net/forums/en/bnet/topic/18300183782

[ ] Write full instructions

### Origin
http://help.ea.com/en/article/backing-up-and-restoring-your-origin-games/

[ ] Write full instructions
