module pulseaudio.client;

import std.experimental.logger;
import std.stdio;

import pulseaudio.lib.mainloop;
import pulseaudio.lib.mainloopapi;
import pulseaudio.lib.context;
import pulseaudio.lib.error;

import pulseaudio.util;

/// A client to communicate to a PulseAudio server.
class Client {
  private pa_mainloop* mainloop;
  private pa_mainloop_api* api;
  private pa_context* ctx;

  /// Creates a new client using the default PulseAudio server.
  this() {
    this(null);
  }

  /// Creates as new client using the specified address.
  this(string address) {
    setup();
    if (address is null) {
      info("Establishing connection to default PulseAudio server");
    } else {
      infof("Establishing connection to PulseAudio server with address %s", address);
    }
    connect(address);
    info("Connected!");
  }

  private void setup() {
    mainloop = pa_mainloop_new();
    api = pa_mainloop_get_api(mainloop);
    ctx = pa_context_new(api, "volume-ctl");
  }

  /// Blocks until a connection is established
  private void connect(string address) {
    pa_context_connect_err(ctx, toCstr(address), pa_context_flags.PA_CONTEXT_NOFLAGS, null);
    while (ctx.pa_context_get_state() != pa_context_state.PA_CONTEXT_READY) { 
      pa_mainloop_iterate(mainloop, 1, null);
    }
  }

  ~this() {
    pa_context_disconnect(ctx);
    pa_mainloop_free(mainloop);
  }

  
}

