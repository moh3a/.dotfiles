-- replace `~` by .config file path
load(io.popen('oh-my-posh init cmd --config "~\.config\oh-my-posh.omp.json"'):read("*a"))()
