module pulseaudio.bindings.pulse.ver;

extern (C):

/*-*-C-*-*/

/***
  This file is part of PulseAudio.

  Copyright 2004-2006 Lennart Poettering
  Copyright 2006 Pierre Ossman <ossman@cendio.se> for Cendio AB

  PulseAudio is free software; you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published
  by the Free Software Foundation; either version 2 of the License,
  or (at your option) any later version.

  PulseAudio is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with PulseAudio; if not, see <http://www.gnu.org/licenses/>.
***/

/* WARNING: Make sure to edit the real source file version.h.in! */

/** \file
 * Define header version */

/** Return the version of the header files. Keep in mind that this is
a macro and not a function, so it is impossible to get the pointer of
it. */

/** Return the version of the library the current application is
 * linked to. */
const(char)* pa_get_library_version ();

/** The current API version. Version 6 relates to Polypaudio
 * 0.6. Prior versions (i.e. Polypaudio 0.5.1 and older) have
 * PA_API_VERSION undefined. Please note that this is only ever
 * increased on incompatible API changes!  */

/** The current protocol version. Version 8 relates to Polypaudio
 * 0.8/PulseAudio 0.9. */

/** The major version of PA. \since 0.9.15 */

/** The minor version of PA. \since 0.9.15 */

/** The micro version of PA (will always be 0 from v1.0 onwards). \since 0.9.15 */

/** Evaluates to TRUE if the PulseAudio library version is equal or
 * newer than the specified. \since 0.9.16 */

