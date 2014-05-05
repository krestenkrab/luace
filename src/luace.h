/*
 *  $Id: luace.h 4 2009-03-13 09:47:42Z petr $
 *
 * Copyright (c) 2009 Petr Stetiar <ynezz@true.cz>, Gaben Ltd.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation 
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom 
 * the Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 */

#ifndef _LUACE_H_
#define _LUACE_H_

#ifdef UNDER_CE

#if defined(LUA_CORE) || defined(LUA_LIB) || defined(lua_c)
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <locale.h>
#include <winbase.h>
#endif

#ifndef BUFSIZ
#define BUFSIZ 1024
#endif

#ifndef MAX_PATH
#define MAX_PATH 2048
#endif

#ifndef L_tmpnam
#define L_tmpnam MAX_PATH
#endif

#if defined(LUA_CORE) || defined(LUA_LIB) || defined(lua_c)

#ifndef _pclose
#define _pclose(x) -1
#endif

#ifndef _popen
#define _popen(x, y) NULL
#endif

#define signal(x,y)
#define SIG_DFL 0
#define SIGINT 0
#define _isatty(x) 1
#endif

#endif /* UNDER_CE */

#endif /* _LUACE_H_ */
