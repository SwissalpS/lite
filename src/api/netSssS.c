#include <SDL2/SDL.h>
#include <SDL2/SDL_net.h>
#include <ctype.h>
#include "api.h"

static int f_test(lua_State *L) {
  char *res = "hahaha";
  lua_pushstring(L, res);
  //free(res);
  return 1;
}

static const luaL_Reg lib[] = {
  { "test",          f_test          },
  { NULL, NULL }
};


int luaopen_netSssS(lua_State *L) {
  luaL_newlib(L, lib);
  return 1;
}
