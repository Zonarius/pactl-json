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

/** Run a single iteration of the main loop. This is a convenience function
for pa_mainloop_prepare(), pa_mainloop_poll() and pa_mainloop_dispatch().
Returns a negative value on error or exit request. If block is nonzero,
block for events if none are queued. Optionally return the return value as
specified with the main loop's quit() routine in the integer variable retval points
to. On success returns the number of sources dispatched in this iteration. */
int pa_mainloop_iterate(pa_mainloop *m, int block, int *retval);

/** Run unlimited iterations of the main loop object until the main loop's
quit() routine is called. Returns a negative value on error. Optionally return
the return value as specified with the main loop's quit() routine in the integer
variable retval points to. */
int pa_mainloop_run(pa_mainloop *m, int *retval);