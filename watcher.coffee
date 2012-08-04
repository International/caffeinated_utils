fs = require("fs")
spawn = require("child_process").spawn
# check if we received a file to watch
if process.argv.length > 2
  watched_file = process.argv[2]
  fs.exists watched_file, (exists) ->
    # exit if file does not exist
    if not exists
      console.log "#{watched_file} does not exist"
      process.exit(1)
    else
      console.log "watching #{watched_file}"
      fs.watchFile watched_file, (curr,prev) ->
        console.log "#{watched_file} changed ... recompiling"
        # execute the coffeescript process
        coffee_job = spawn "coffee",["-c",watched_file]
        coffee_job.on "exit",(code) ->
          # a return code of 0 symbolized success
          if code != 0
            console.log "recompiling #{watched_file} failed"
            process.exit(1)
          else
            console.log "recompiled succesfully"
else
  console.log "No file to watch"