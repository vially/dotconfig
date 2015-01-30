Config { font = "xft:Source Code Pro:size=11"
       , bgColor = "#1d1f21"
       , fgColor = "#969896"
       , position = Top
       , lowerOnStart = True
       , commands = [ Run DynNetwork ["-L","0","-H","32","--normal","#f0c674","--high","#cc6666"] 10
                    , Run Cpu ["-L","3","-H","50","--normal","#f0c674","--high","#cc6666"] 10
                    , Run Memory ["-t","Mem: <usedratio>%","--normal","#f0c674","--high","#cc6666"] 10
                    , Run DiskIO [("/", "<total>"), ("/home", "<total>")] [] 10
                    , Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%cpu% <fc=#e0e0e0>|</fc> %memory% <fc=#e0e0e0>|</fc> I/O: %diskio% <fc=#e0e0e0>|</fc> %dynnetwork% } %StdinReader% { <fc=#f0c674>%date%</fc>"
       }
