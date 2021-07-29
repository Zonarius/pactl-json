module pulseaudio.client;

import std.experimental.logger;
import std.stdio;
import std.string;

import pulseaudio.bindings.pulse.def;
import pulseaudio.bindings.pulse.mainloop;
import pulseaudio.bindings.pulse.mainloopapi;
import pulseaudio.bindings.pulse.context;
import pulseaudio.bindings.pulse.introspect;
import pulseaudio.lib.context;
import pulseaudio.bindings.pulse.error;

import pulseaudio.util;
import pulseaudio.sinkinput;
import pulseaudio.bindings.pulse.operation;

/// A client to communicate to a PulseAudio server.
class Client {
  private pa_mainloop* mainloop;
  private pa_mainloop_api* api;
  private pa_context* ctx;
  private SinkInput[] sinks;
  private auto cbDone = false;

  /// Creates a new client using the default PulseAudio server.
  this() {
    this(null);
  }

  /// Creates as new client using the specified address.
  this(string address) {
    setup();
    if (address is null) {
      trace("Establishing connection to default PulseAudio server");
    } else {
      tracef("Establishing connection to PulseAudio server with address %s", address);
    }
    connect(address);
    trace("Connected!");
  }

  SinkInput[] getSinkInputs() {
    auto op = pa_context_get_sink_input_info_list(ctx, &sinkInputCallBack, cast(void*) this);
    scope(exit) pa_operation_unref(op);
    cbDone = false;
    sinks = [];
    while (!cbDone) {
      pa_mainloop_iterate(mainloop, 1, null);
    }
    return sinks;
  }

  private static extern(C) void sinkInputCallBack(pa_context* ctx, const pa_sink_input_info *i, int eol, void* userdata) {
    auto clnt = cast(Client)userdata;
    if (!eol) {
      auto si = new SinkInput(i);
      clnt.sinks ~= [si];
      trace(si.name);
    } else {
      clnt.cbDone = true;
      trace("Done getting Sink Inputs");
    }
  }

  private void setup() {
    mainloop = pa_mainloop_new();
    api = pa_mainloop_get_api(mainloop);
    ctx = pa_context_new(api, "pactl-json");
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

