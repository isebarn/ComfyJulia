# ComfyJulia

`ComfyJulia` is a module for Julia containing tools (functions) to ease the use of the REPL 

To install run 

    Pkg.clone("https://github.com/isebarn/ComfyJulia/")
    
and run

    using ComfyJulia
    
to use the module 

Exported functions are:
* living_repl()


## living_repl()

### Usage 

    living_repl(filename, time [, redef_filter = true])

This function is handy when editing a .jl file in a text editor such as Sublime Text

The function checks every `time` seconds if `filename` has beed modified

If `filename` has been modified, living_repl() calls `include(filename)` 

### Example 

Let us imagine that the file `/home/david/test.jl` exists and it contains 

    function test()
        println(123)
    end
  
 If `living_repl("/home/david/test.jl", 1)` is running in the REPL and we modify `/home/david/test.jl` a bit to read 

     function test()
        println(123)
     end
    
     test()
    
  the REPL will print 
  
      123
      
 
