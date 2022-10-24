local status_ok, dashboard = pcall(require, 'dashboard')
if not status_ok then
  return
end

dashboard.custom_center = {
    {desc = "  Find File                 SPC f f", action = "Telescope find_files"},
    {desc = "  Recents                   SPC f h", action = "Telescope oldfiles"},
    {desc = "  Find Word                 SPC f g", action = "Telescope live_grep"},
    {desc = "  New Buffer                SPC b n", action = "DashboardNewFile"},
    {desc = "  Update Plugins            SPC p u", action = "PackerUpdate"},
    {desc = "  Settings                  SPC n e", action = "edit $MYVIMRC"},
    {desc = "  Exit                      SPC q  ", action = "exit"}
}

dashboard.custom_header = {
       "                                                                    ",
       "                                                                    ",
       "                                                                    ",
       "                                                                    ",
       "            :h-                                  Nhy`               ",
       "           -mh.                           h.    `Ndho               ",
       "           hmh+                          oNm.   oNdhh               ",
       "          `Nmhd`                        /NNmd  /NNhhd               ",
       "          -NNhhy                      `hMNmmm`+NNdhhh               ",
       "          .NNmhhs              ```....`..-:/./mNdhhh+               ",
       "           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ",
       "           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ",
       "      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ",
       " .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ",
       " h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ",
       " hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ",
       " /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ",
       "  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ",
       "   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ",
       "     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ",
       "       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ",
       "       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ",
       "       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ",
       "       //+++//++++++////+++///::--                 .::::-------::   ",
       "       :/++++///////////++++//////.                -:/:----::../-   ",
       "       -/++++//++///+//////////////               .::::---:::-.+`   ",
       "       `////////////////////////////:.            --::-----...-/    ",
       "        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ",
       "         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ",
       "           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ",
       "            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``",
       "           s-`::--:::------:////----:---.-:::...-.....`./:          ",
       "          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ",
       "         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ",
       "        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ",
       "                        .-:mNdhh:.......--::::-`                    ",
       "                           yNh/..------..`                          ",
       "                                                                    ",
       "                              N E O V I M                           ",
       "                                                                    ",
       "                                                                    ",
       }
