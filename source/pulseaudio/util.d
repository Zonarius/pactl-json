module pulseaudio.util;

import pulseaudio.bindings.pulse.proplist;
import std.string;
import std.conv;
import std.experimental.logger;

/// Converts a string to a c-style string. If `str` is null, null will be returned.
pure toCstr(string str) {
  if (str is null) {
    return null;
  } else {
    return toStringz(str);
  }
}

immutable(string[string]) toMap(const(pa_proplist*) p) {
  void* state = null;
  string[string] ret;
  for(;;) {
    auto key = pa_proplist_iterate(p, &state);
    if (key is null) {
      break;
    }
    auto strKey = key.to!string;
    ret[strKey] = pa_proplist_gets(p, key).to!string;
    tracef("%s = %s", strKey, ret[strKey]);
  }

  return cast(immutable)ret;
}