#include <iostream>

extern "C"
{
#include "lualib.h"
#include "lauxlib.h"
}

using namespace  std;
int main()
{
	lua_State* state = luaL_newstate();
	luaL_openlibs(state);
	if(luaL_dostring(state,"print('hello lua')")!=0){
		cout << "execute lua fail" << endl;
	}
	lua_close(state);
}