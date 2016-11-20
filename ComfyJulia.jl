module ComfyJulia


    # Usage 
    # living_repl(filename, time, redef_filter)
    # reads the file at "filename" and checks it for changes 
    # if it hasnt changed, sleep for "time" and check again, forever 
    # redef_filter filters out the "WARNING: Method definition..." error 
    function living_repl(filename, time, redef_filter = true)
        if is_windows()
            # read the file as a string to compare with future reads for file modification
            basefile = String(read(filename))
        elseif is_unix()
            # Unix timestamp of when the file was last modified
            # (dont know if this works with windows)
            basefile = stat(filename).mtime
        else 
            warn("what filesystem are you on?")
        end 
            
        while true 
            sleep(time)
            #file = String(read(filename))
            file = stat(filename).mtime

            if basefile != file 
                err_rd, err_wt = redirect_stderr()
                try
                    include(filename)
                catch error  
                    println(error)
                finally 
                    basefile = file
                end 
                redirect_stderr(STDOUT)

                outerr = String(readavailable(err_rd))
                outerr = split(outerr, "\n")

                for i in outerr
                    if contains(i, "WARNING: Method definition") & redef_filter
                        continue
                    end  
                    println(i)
                end 
            end 
        end 
    end 

    export living_replC
end 