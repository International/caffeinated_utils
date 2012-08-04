fs = require("fs")
spawn = require("child_process").spawn

module.exports = change_exec = (watched_file, bin_to_exec, bin_args, error) ->
 fs.exists watched_file, (exists) ->
  # exit if file does not exist
  if not exists
    error "#{watched_file} does not exist"
  else
    fs.watchFile watched_file, (curr,prev) ->
      exec_job = spawn bin_to_exec, bin_args
      exec_job.on "exit",(code) ->
        # a return code of 0 symbolized success
        if code != 0
          error "recompiling #{watched_file} failed"
