module pulseaudio.lib.mainloop;

import pulseaudio.lib.mainloopapi;

extern (C):

/** An opaque main loop object */
struct pa_mainloop;

/** Allocate a new main loop object. Free with pa_mainloop_free. */
pa_mainloop *pa_mainloop_new();

/** Free a main loop object */
void pa_mainloop_free(pa_mainloop* m);

/** Return the abstract main loop abstraction layer vtable for this
    main loop. No need to free the API as it is owned by the loop
    and is destroyed when the loop is freed. */
pa_mainloop_api* pa_mainloop_get_api(pa_mainloop*m);