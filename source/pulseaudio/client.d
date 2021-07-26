module pulseaudio.client;

import std.experimental.logger;
import std.stdio;

import pulseaudio.chan;
import pulseaudio.lib.mainloop;
import pulseaudio.lib.mainloopapi;
import pulseaudio.lib.context;
import pulseaudio.lib.error;

/// A client to communicate to a PulseAudio server.
class Client {
  private pa_mainloop* mainloop;
  private pa_mainloop_api* api;
  private pa_context* context;
  private Channel stateChan;

  /// Creates a new client using the default PulseAudio server.
  this() {
    this(null);
  }

  /// Creates as new client using the specified address.
  this(string address) {
    infof("Establishing connecting to PulseAudio server with address %s", address);
    mainloop = pa_mainloop_new();
    api = pa_mainloop_get_api(mainloop);
    context = pa_context_new(api, "volume-ctl");

    stateChan = new Channel(mainloop, context);

    stateChan.connect();
    info("connected!");
  }

  ~this() {
    pa_context_disconnect(context);
    pa_mainloop_free(mainloop);
  }

  
}

