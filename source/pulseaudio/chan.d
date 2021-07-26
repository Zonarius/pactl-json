module pulseaudio.chan;

import std.experimental.logger;
import std.stdio;
import std.string;

import pulseaudio.lib.context;
import pulseaudio.lib.mainloop;

class Channel {
  private pa_mainloop* mainloop;
  private pa_context* context;

  this(pa_mainloop* mainloop, pa_context* context) {
    this.mainloop = mainloop;
    this.context = context;
    pa_context_set_state_callback(context, &callback, cast(void*)this);
  }

  private static extern (C) void callback(pa_context* context, void* userdata) {
    // trace("Callback!");
    // Channel c = cast(Channel)userdata;
  }

  /// Blocks until a connection 
  void connect() {
    pa_context_connect(context, null, pa_context_flags.PA_CONTEXT_NOFLAGS, null);
    while (context.pa_context_get_state() != pa_context_state.PA_CONTEXT_READY) {
      pa_mainloop_iterate(mainloop, 1, null);
    }
  }
}

private pure cstr(string str) {
  if (str is null) {
    return null;
  } else {
    return toStringz(str);
  }
}