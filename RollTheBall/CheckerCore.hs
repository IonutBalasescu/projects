{-# OPTIONS_GHC -Wall #-}

module CheckerCore where

{-
	Fișier important folosit in checker
-}

angry :: String
angry =  "              `'+'`                        \n             '''''''     .+'''+            \n           :'''''''''# ;;'''''''#          \n          ,'''''''''''#'''''''''''         \n          ''''''''';@'''''''''''';         \n         '''';''''''';++''';'####'.        \n        `'''+''''''''''''';;;;'+++'        \n        @'''''''''';'++'''''''''''';+      \n        ''''''''''+''';'+'''''''';+';;     \n      +'''''''''#;'+;'''#;''''''''+;;;+    \n    .''+''''''+;+'+'++@+;;'';+'+'''#.  #   \n    ;'''''''''+;'#      ++;''';''@      `  \n   ,'''''''''''@          ;';'@      @+  . \n   '''''''''''+       @`   ,         :` '  \n  .''''''''''''#.     ., :'@+:,`  `.:#+;;  \n  +''+'''''''''''';@#'@;''@+''''''''''#    \n  ''@'+''''''''''@';'''''''';'''''''+      \n #'';+'''''''''''''';'';+'''';#++++;       \n ''';''''''''++'';'+##''#'''''''''';+      \n '''''''''';;;;;;;;#+;;+''''''''''#;;#     \n`''''''''#;;;;;;;;;;;;;''#####'';;;;;. ;   \n`'''''''+;;;@@##@@#';;;;;;;;;;;;;;;+   .   \n;'''''';;;;########@@@@#''''++++`          \n+''''''#;;@@####@#@@@##@@#@              :,\n'''''';;;#####@@###@#@@##@         +;;;;;  \n,'''+#+;;@@###@##@@;;;;;+,       ,;;;+;;;  \n`''';'+;;@###@####;;;;;;;;;#',;#;;'`   #:  \n '''''+;+###@###@;;+##@@#';;;;;;'.         \n '''''+;###@#@@#;;;@@@@#   ,++:   ;'       \n #''''+;+@@#@##@;;+@####                   \n  ;'''+;;###@@@@;;###@##                   \n  +'''';;;@#@+;;;;;#@###.                  \n  +''''+;;;;;;;;;;';;;'+#;''++++';`        \n@'';+;''#;;;;+#;;:#';;;;;;;;;;;;;'         \n''''''#;'';''''';#''+'#####+';;.           \n'''''''';'''''';;##;;'''''';+`        ; +@ \n'''''''''''''';;';'#'''+#';          '';'  \n'''''''''''''#'''''+'''''''''      +'''''. \n'''''''''''#;'''''''#'''''''';   @''''''''#\n'''''''''+;''''''#';'''''''''''+;''''';;   \n''''''''''''''''+''''''''''''''#''''''     \n"

okay :: String
okay = "``````````````#;;;;;;;;;;;'`````#';;;;;;# ```````````\n`````````````';;;;;;;;;;;;;'``#;;;;;;;;;;: ``````````\n````````````;;;;;;;;;;;;;;;;::;;;;;;;;;;;;;``````````\n`````````` ;;;;;;;;;;;;;;;;;;+;;;;;;;;;;;;;#`````````\n``````````+;;;;;;;;'##+##;;;;;;;;;;;;;;;;;;;`````````\n`````````+;;;;;;;#;;;;;;;;;#;;#;;;;;;;;;;;;;,````````\n`````````;;;;;;#;;;;;;;;;;;;;@;'##';;;;;'##;#````````\n````````@;;;;;;;;;;;;;;;;;;;;;;:;;;;;;;;;;;;;:@``````\n````````;;;;;;;;;;;;;;;;;;;;;;;;:;;;;;;;;;;;;;;;@````\n```````#;;;;;;;;;;;;;;+#;:;;;;;:'+;;;;;##';''+#+;@```\n```````;;;;;;;;;;;;;#;;;#+;;;'#+;;@'#:;;+#####+;;:@``\n`````#:;;;;;;;;;;;';;+;;'+.,;'':;'+;#+:;;'+'++;;:#;#`\n````;;';;;;;;;;+#;;;'',,@@@@    ,@;;;;;' @'@@@  .;;# \n```+;;#;;;;;;;;;;#';. .@:@@@@      #;:  @@'@;@@    @#\n``';;;#;;;;;;;;;;;+   @@@@ ;@.     .    @@#@ @@     @\n`.:;;;';;;;;;;####    @@@@@@@,     +    @@@@@@@     ,\n`#;;;;;;;;;;;;;;;;:   @@@@@@@           @@@@@@@     ,\n`;;;;;;;;;;;;;;;;;;'.  @@@@@,    ,';    :@@@@@   ++#.\n;;;;;;;;;;;;;;;;;;#;;;+ .:.   '#;;:;:;+@+:+'#+;;;;# .\n';;;;;;;;;;;;;;;;;;:#';;;:::;;;;;';;;;;;;;;;;;;;;'```\n;;;;;;;;;;;;;;;;;;;;;;;'+######;;;;;;;;;;;;;;;;;@````\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;+;;;;;';;;;;;;;;';`````\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;#;;;;;;;;;#''++#+'```````\n;;;;;;;;;;;;;;;;;;;;;;;;;#;;;;;;;;;;;;;;#;;;;;; `````\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'`````\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;@````\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:````\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,```\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;+```\n;;;;;;;;;;;;;;;;#;:;'##';;;;;;;;;;;;;;;;;;;;;;;;;+,``\n;;;;;;;;;;;;;;';;;;;;;;;;;'#+;;;;;;;;;;;;;;;;;#;;;+``\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'+##+''''+#';;;;;;'``\n;;;;;;;;;;;;;;;;;;;;;;'#+;;;;;;;;;;;;;;;;;;;;;;;;;```\n;;;;;;;;;;;;;;;;;;;;;;;;;;:;+#+';;;;;;;;;;;;'+#+ ````\n;;;;;;;;;;;';;'+++++';;;;;;;;;;;;;;;;;;;;;;;;;;;#````\n;;;;;;;;;;;;;;;;;;;;;;;;##;;;;;;;;;;;;;;;;;;;;;;.````\n+;;;;;;;;;;;;';;;;;;;;;;;;;;;+##++';;;;;;;;;;;+,`````\n`#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:# ````````\n++'';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#``````````\n;;+:;#:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;+````````````\n;;;;#:;'#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#.`````````````\n;;;;;;#;;;:;+#+';;;;;;;;;;;;;;;;;;;'; ```````````````\n;;;;;;;;'+;;;;;;;;;;'+##########';+'`````````````````\n;;;;;;;;;;;;'#+';:;;;;;;;;;;;;::+';;+````````````````\n;;;;;;;;;;;;;;;;;;;;;;''''''';;;;;;;;;#``````````````\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;+`````````````\n"

interested :: String
interested = "```````````````````````````````````````````````````````````````\n````````````````````````````````  `````````````````````````````\n``````````` +###:` ``````` +@'''+@# ```````````````````````````\n````````` @'+++++';#+ ``` @++++++++'@``````````````````````````\n`````````@++++++'++++++``@++++++++++'+`````````````````````````\n```````` '++++++++++++++;'++'+++++++++ ````````````````````````\n```````` ;++++++'++';##++#@@#@###@;+++ ````````````````````````\n```````` +++++++++##'++++'+'@+++++'#@' ````````````````````````\n````````'@+++++'@'++'''''''+''+++++@@@,````````````````````````\n`````` @'++++++#+++@;''''';@'#''++++++'@ ``````````````````````\n`````++'++++++++++@+'+##@@#''++++++'+@@@@ `````````````````````\n````''+++++++++++#''#'''''''#'+++'@';+++@@:````````````````````\n```@'++++++++++++++##@    `@''@+'+'@'''+++' ```````````````````\n` @'++++++''++++++@@@@      `#++++#'#@#'''@+ ``````````````````\n +++++++'+'@+'+++++@@.+       @+++@;@;     .,``````````````````\n'+++++++++@@'++++++'#`       `'+++@. #    +@.``````````````````\n++++++++#'''#++++++#''+++++++@+++++##@@@#'+'.``````````````````\n+++++++'+''+'+++++++'++++++++'+++++++++++++#```````````````````\n+++++++++'''@++++++++'''''''''++@;'@@+++;;@.`````` ````````````\n+++++++++''''##+++++++++++++@++++'++++++;'.`````@+;+.``````````\n++++++++++@''''@''++++++++'@'++++++'++++++# ``.+'+++',`````````\n++++++++++#'#'''@++++'''++'++++++++'+++++++'``##''''+'@:```````\n++++++++++'''''+'@'+++'#@'+++'+++''+++++++'#@@@@'.``+@'+@#`````\n++++++++++'+'#''''+#'++''@@+''''++++#####@++ +''@`` @++'+# ````\n+++++++++++@+''#''+'+#'++';@@@@@++'@@+'''++# @'++@;@''@+++'+```\n+++++++++++'+'+++''''''@'++++'''++++++++'#'+.` #+++'##''#+'' ``\n++++++++++++'#+'''@'''++'@+'++++++++++'@++'',```'+++'''+'+#+:``\n+++++++++++++'@''+'++'''+''+@@@@@@@@@#''+''#`````##;'++'''+'.``\n+++++++++++++++#'''+'##''''+'+++++''''''#'''``````` ;'++++'+@``\n++++++++++++++++'@++''+'##+++++@@@#####++++#`````````,;+'+++@``\n++++++++++++++++++''+@@'''''''''+'''''+'''@ ``````````@+@+++@``\n+++++++++++++++++++++++;;+#@'''''''''''#@'++`````````` '#+++'``\n++++++++++++++++++++++++++++''+++++++++'+++@`````````` '#+'+@``\n+++++++++++++++++++++++++++++++++++++++++++@`````````` '+++; ``\n+++++++++++++++++++++++++++++++++++++++++++@`````````` '++++ ``\n++++++++++++++++++++++++++++++++++++++++++';``````````@++++@```\n++++++++++++++++++++++++++++++++++++++++++' ``````````@+++'.```\n+++++++++++++++++++++++++++++++++++++++++'@```````````@+++@````\n++++++++++++++++++++++++++++++++++++++'+';````````````@++''````\n++++++++++++++++++++++++++++++++++++++++@ ````````````#'++ ````\n+++++++++++++++++++++++++++++++++++++++@````````````` '++@`````\n+++++++++++++++++++++++++++++++++++++'#``````````````,++++`````\n+++++++++++++++++++++++++@'+++++++++@;```````````````;'+'``````\n"

happy :: String
happy = "``````````````````````````````````````````\n``````````.#@@@@.```````````@@ ```````````\n```````` #''+'+''+'```` ;@'+++++``````````\n``````` '++++++++++@``#+'+++++++'#````````\n`````` '++'++++++++':@'+'+++++++++````````\n``````@''+@@##''+++++'+++''+##'''+'```````\n`````;##+++++'''+'+'''+'@''+''''@'+ ``````\n`````#+++++++++''@++++@''++++++'+'@@``````\n````@+++++++++'+'''+++++++'++'+++++'@`````\n````''++++''''''++++++++++'##''''+++' ````\n```.'+++'@#''''+@'++++++'#'''''@''+++;````\n```;++'@''#@@@#+''#++++'#'+@+##'++''+@````\n```;++@'@''++++'+#'++++@'@'+'+''#'@++@````\n```;+''@++++++''+'@+'++'#''+++++'@'@+@````\n```#'#'''###@@@@+#'''++''''''+'+''#+''.```\n```#@#@#   @ @@@`  ++'+'` +@@@@``` '''@```\n`` ''''+'@ #@@; +  #+++#  @ @#@   @''''```\n`` ''#++@''#@@@@#  #+++#  @@@ @  @'##+' ``\n``;++++++##''+@@   #'++'  @#@@++#'#''++'``\n``@+++++++'#@++'''''+++#+##+''''#++++++@``\n``++++++++++''''''#'+++'@##+''''#'++++++``\n``'+++'+++++++++'+'++++'+@'++++'+++++++'``\n` '+#'''+++++++'++++++++''''+++++++'+++'``\n``'''@+'++++++++'''+++++++++++++++++'++'.`\n``'+@#'#'++++''+++++++++++++++++'+'+#'+';`\n` '+'@''#''+++++++++++++++++++++''#''@++'`\n`.'++'''#'#+''++++++++++++++++++#'''#+++@`\n`.'++++#'#+''+@#'''''''''''+'+#''+''+++'+`\n`.''++++++'#+''''''''''++++++''##''@'++##`\n` '++++''@''''+++###+'''++###+''''@'++'+:`\n``+#++++++'+''''+''''''''''''''+'@++++'' `\n``+'++++++''@+''''''''''''''''''@+++++@' `\n``#+#'+++++++''#@@@#++++#@@##+''+'+++''' `\n``@+''+++++++++++++''''''+'+++++++++'''',`\n``@++#++++++++++''+'#+''#+++++++++++++++;`\n``@++''++++++++++#'#'++'++#''+'++++++#'';`\n``.++++'++++++++'#''++'#++@'#'++++++'''' `\n```+++++++++++++''+''@'@+''''@''+++'#++' `\n```@++++++++++++''##'+@'+++'''+'++++'++'``\n```#'++++++++++++##'@'++''++''++''+++++' `\n```+'++++++++++++'+'+'+'#'''+++'@'+++++' `\n```'+++++++++++++++#'@@++'@;+'++''+++++'``\n"

extatic :: String
extatic = "                                             \n                                             \n                                             \n                  ,@@@#     :#:              \n                 ,;'''''+ @'''''`            \n                 ;'''''''@''''''#            \n                @''''''''#''''''''           \n               .''''+@+''#@;''+@@#+          \n               ''';#''''''''@''''''+         \n             `+'''''''@@@@+'@'''''''+        \n            #;''''''#;'++#+@'''+@''+@        \n           ;'''''''#+' @@@#:;#@;@@;+#@       \n           ''''+#'@@  '@@@@ ;'@  #@@@        \n          @''@;'''+.@;##@#;@ @':@`@@@        \n          ''''''''';;#'''';+#'@''''';@''#'   \n         ;'@''''''''#'''''';''@'''''#''''''  \n         @'#'''''''';;@''+@#'';'@+'+''''''+  \n         ;'#''#@@+''''''';#''''''''''''''''` \n        .''@'''@#'@+'''@@''''''''@'''+''''', \n        +'''''''@@'''@''''''''''''''@#@';;;  \n        @''''''''@@'''''@#'''''''+@;'@#;''@  \n        #'''''''''@'#@#''''''++'''#@'+'''@   \n        +''''''''''#''''''+@@@@@@'''+;'';    \n        ,''''''''''''#@#'''''''''''@;''''    \n         ''''''''''''';'';;'+####''''''''    \n         ;'''''''''''''#;''''''''''''''''    \n         ''''''''''''''''@@#+#@+'''''''''    \n         @'''''''''''''''''''''''''''''''    \n      :@@#''''''''''''''''''''''''''''''#    \n     +''';+'''''''''''''''''''''''''''''@    \n    '''''';'''''''''''''''''''''''''''''     \n   @'''''''''''''''''''''''''''''''''';@     \n  `'''''''''''''''''''''''''''''''''';@'@    \n  @''''''''''''''''''''''''''''''''''''';    \n  @''''''''''''''''''''''''''++##'''''''',   \n  '''''''''''''''''''''''+'''''''''''''''.   \n  ''''''''@''''''''''''''''''''''''''''';    \n  ''''''''@''''''''''''''''''''''''#''''@    \n  ''''''''#''''''''''''''''''''''''@'''';    \n  #''''''''''''''''''''''''''''''''+''';     \n  @''''''';''''''''''''''''''''''''''''@     \n  .,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,      \n"
