module pulseaudio.util;

import std.string;

/// Converts a string to a c-style string. If `str` is null, null will be returned.
pure toCstr(string str) {
  if (str is null) {
    return null;
  } else {
    return toStringz(str);
  }
}
