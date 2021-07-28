module pulseaudio.bindings.pulse.gccmacro;

extern (C):

/***
  This file is part of PulseAudio.

  Copyright 2004-2006 Lennart Poettering

  PulseAudio is free software; you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published
  by the Free Software Foundation; either version 2.1 of the License,
  or (at your option) any later version.

  PulseAudio is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with PulseAudio; if not, see <http://www.gnu.org/licenses/>.
***/

/** \file
 * GCC attribute macros */

/* libintl overrides printf with a #define. As this breaks this attribute,
 * it has a workaround. However the workaround isn't enabled for MINGW
 * builds (only cygwin) */

/** If we're in GNU C, use some magic for detecting invalid format strings */

/** Macro for usage of GCC's sentinel compilation warnings */

/** Macro for no-return functions */

/** Macro for not used function, variable or parameter */

/** Call this function when process terminates */

/** This function's return value depends only the arguments list and global state **/

/** This function's return value depends only the arguments list (stricter version of PA_GCC_PURE) **/

/** This function is deprecated **/

/** Structure shall be packed in memory **/

/** Macro for usage of GCC's alloc_size attribute */
/** Macro for usage of GCC's alloc_size attribute */

/** Macro for usage of GCC's malloc attribute */

/** Macro for usage of GCC's weakref attribute */

/* We don't define a PA_CLAMP_LIKELY here, because it doesn't really
 * make sense: we cannot know if it is more likely that the value is
 * lower or greater than the boundaries. */

