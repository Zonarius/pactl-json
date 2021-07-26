module pulseaudio.lib.context;

import pulseaudio.lib.mainloopapi;

extern (C):

/** An opaque connection context to a daemon */
struct pa_context;
struct pa_spawn_api;

/** Some special flags for contexts. */
enum pa_context_flags {
    PA_CONTEXT_NOFLAGS = 0x0000U,
    /**< Flag to pass when no specific options are needed (used to avoid casting)  \since 0.9.19 */
    PA_CONTEXT_NOAUTOSPAWN = 0x0001U,
    /**< Disabled autospawning of the PulseAudio daemon if required */
    PA_CONTEXT_NOFAIL = 0x0002U
    /**< Don't fail if the daemon is not available when pa_context_connect() is
     * called, instead enter PA_CONTEXT_CONNECTING state and wait for the daemon
     * to appear.  \since 0.9.15 */
}

/** Instantiate a new connection context with an abstract mainloop API
 * and an application name. It is recommended to use pa_context_new_with_proplist()
 * instead and specify some initial properties.*/
pa_context *pa_context_new(pa_mainloop_api *mainloop, const char *name);

/** Connect the context to the specified server. If server is NULL,
 * connect to the default server. This routine may but will not always
 * return synchronously on error. Use pa_context_set_state_callback() to
 * be notified when the connection is established. If flags doesn't have
 * PA_CONTEXT_NOAUTOSPAWN set and no specific server is specified or
 * accessible a new daemon is spawned. If api is non-NULL, the functions
 * specified in the structure are used when forking a new child
 * process. Returns negative on certain errors such as invalid state
 * or parameters. */
int pa_context_connect(pa_context *c, const char* server, pa_context_flags flags, const pa_spawn_api *api);

/** Terminate the context connection immediately */
void pa_context_disconnect(pa_context *c);

/** Set a callback function that is called whenever the context status changes */
void pa_context_set_state_callback(pa_context *c, pa_context_notify_cb_t cb, void *userdata);
