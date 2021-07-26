module pulseaudio.client;

import std.string;
import pulseaudio.lib.mainloop;
import pulseaudio.lib.mainloopapi;
import pulseaudio.lib.context;

/// A client to communicate to a PulseAudio server.
class Client {
  private pa_mainloop* mainloop;
  private pa_mainloop_api* api;
  private pa_context* context;

  /// Creates a new client using the default PulseAudio server.
  this() {
    this(null);
  }

  /// Creates as new client using the specified address.
  this(string address) {
    mainloop = pa_mainloop_new();
    api = pa_mainloop_get_api(mainloop);
    context = pa_context_new(api, "volume-ctl");
    pa_context_connect(context, toStringz(address), pa_context_flags.PA_CONTEXT_NOFLAGS, null);

    // wait until connection is established
  }

  ~this() {
    pa_context_disconnect(context);
    pa_mainloop_free(mainloop);
  }
}