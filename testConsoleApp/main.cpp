#include <iostream>

extern "C"
{
#include "lualib.h"
#include "lauxlib.h"
}
#include "mylib.h"
using namespace  std;
void error(lua_State* L, const char* fmt, ...) {
	va_list argp;
	va_start(argp, fmt);
	vfprintf(stderr, fmt, argp);
	va_end(argp);
	lua_close(L);
	exit(EXIT_FAILURE);
}
int main()
{
	int tolua_mylib_open(lua_State*);
	lua_State* state = luaL_newstate();
	luaL_openlibs(state);
	tolua_mylib_open(state);
	if(luaL_dofile(state,"luaScripts/Test.lua")!=0){
		cout << "execute lua fail" << endl;
		error(state, "cannot run test file: %s \n",
			lua_tostring(state, -1));
	}
	lua_close(state);
}