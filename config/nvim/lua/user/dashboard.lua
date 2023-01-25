local status_ok, dashboard = pcall(require, 'dashboard')
if not status_ok then
  return
end

dashboard.setup({
  theme = "doom",
  config = {
    header = {
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
    },
    center = {
      { desc = "  Find File               ", action = "Telescope find_files", key = 'SPC f f', desc_hi = "DashboardCenter" },
      { desc = "  Recents                 ", action = "Telescope oldfiles", key = 'SPC f h' , desc_hi = "DashboardCenter"},
      { desc = "  Find Word               ", action = "Telescope live_grep" , key = 'SPC f g' , desc_hi = "DashboardCenter"},
      { desc = "  New Buffer              ", action = "DashboardNewFile" , key = 'SPC b n' , desc_hi = "DashboardCenter"},
      { desc = "  Update Plugins          ", action = "PackerUpdate" , key = 'SPC P u' , desc_hi = "DashboardCenter"},
      { desc = "  Settings                ", action = "edit $MYVIMRC" , key = 'SPC n e' , desc_hi = "DashboardCenter"},
      { desc = "  Exit                    ", action = "exit" , key = 'SPC q' , desc_hi = "DashboardCenter"}
    }
  },
})
