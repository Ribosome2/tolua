-- premake5.lua
--根据文档"INSTALL" 下载的源码要大概分为3个部分，Library,Interpreter,Compiler 
--根据代码猜测，
--Interpreter应该就是控制台交互程序，启动时候可以传参数或者要执行的lua文件
--Compiler： luac is the Lua compiler. It translates programs written in the Lua programming language into binary files that can be loaded and executed with lua_dofile in C or with dofile in Lua.
workspace "toluaC"
   configurations { "Debug", "Release" }

--库工程
project "library"
    kind "StaticLib"

    files { 
        'lua-5.2.0/src/**.c',
        
    }
    includedirs "lua-5.2.0/src"

--lua 解析器工程
project "interpreter"
    kind "ConsoleApp"
    files{
        "lua-5.2.0/src/lua.c",
        "lua-5.2.0/src/**.h"
    }
    links {  "library"}
    includedirs "lua-5.2.0/src"

    
project "toluaLib"
    kind "StaticLib"
    files{
        "src/lib/**.c",
        "lua-5.2.0/src/**.h",
        "include/**.h"
    }
    links {  "library"}
    includedirs "lua-5.2.0/src"
    includedirs "src/lib"
    includedirs "include"

project "tolua"
    kind "ConsoleApp"
    files{
        "include/**.h",
        "src/bin/tolua.c",
        "src/bin/toluabind.c",
        "lua-5.2.0/src/**.h"

    }
    links{"library","toluaLib"}
    includedirs "include"
    includedirs "lua-5.2.0/src"

project "testConsoleApp"
    kind "ConsoleApp"
    files{
        "testConsoleApp/main.cpp",
        "testConsoleApp/mylib.cpp",
        "testConsoleApp/mylib.h",
        "testConsoleApp/mylib.pkg",
        "testConsoleApp/tolua.cpp",
        "lua-5.2.0/src/**.h",
        "include/**.h",
        "luaScripts/**.lua"
        
    }
    includedirs "lua-5.2.0/src"
    includedirs "include"
    links{ "library","toluaLib"}

