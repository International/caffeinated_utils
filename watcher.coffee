fs = require("fs")
change_exec = require("./change_exec")
spawn = require("child_process").spawn
# check if we received a file to watch
if process.argv.length > 2
  watched_file = process.argv[2]
  change_exec watched_file,"coffee",["-c",watched_file], (e) ->
    console.log "error #{e}"
