# EventPC-Setup
Sets streaming and gaming machines up for event deployment

## How to Use
1. Clone or download the repository from GitHub
2. Download what you need and keep it in the same directory as the script.  Make sure they are namedIt may be useful to get the full "offline" installer instead of the bootstrap installer.  Hint: [FileHippo](https://filehippo.com/) is your friend
  - [OBS Studio](https://obsproject.com/) `OBS-Studio-*-Installer.exe`
  - [Steam](https://steampowered.com/) `SteamSetup.exe`
  - [Battle.net](https://battle.net/) `Battle.net-Setup.exe`
  - [Origin](https://origin.com/) `OriginSetup.exe`
  - [Nvidia](https://nvidia.com/) `*-desktop-*-international-whql.exe`
3. Open a command prompt as a local administrator
4. Run `powershell -ExecutionPolicyBypass`
5. Run `.\EventPC-Setup.ps1 -Streamer` or `.\EventPC-Setup.ps1 -Gamer` depending on what the computer will be doing

## Backing up and restoring stream settings
1. Configure OBS Studio to your preference
2. Open `%APPDATA%\obs-studio` and copy `global.ini`, and the `basic` folder to the same directory as the script.  You can also copy the `plugin_config` folder if you have custom settings)
3. After installing OBS Studio, your settings will be restored
4. Edit the record folder for OBS Studio
5. Point the loop and logo videos to the correct folder

## Backing up and restoring games
### Steam
https://support.steampowered.com/kb_article.php?ref=8794-yphv-2033
[ ] Write full instructions

### Battle.net
http://us.battle.net/forums/en/bnet/topic/18300183782
[ ] Write full instructions

### Origin
http://help.ea.com/en/article/backing-up-and-restoring-your-origin-games/
[ ] Write full instructions
