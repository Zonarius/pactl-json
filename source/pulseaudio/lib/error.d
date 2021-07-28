module pulseaudio.lib.error;

import std.string;
import std.conv;
import std.traits;

/// An error that originated from PulseAudio.
class PulseAudioException : Exception {
  /// The error number
  immutable int errno;

  /// Create a new PulseAudioException
  this(int errno) {
    this.errno = errno;
    const msg = to!string(pa_strerror(errno));
    super(msg);
  }
}

/// Wraps a function that returns an error-code. The new function will throw an exception on error.
template wrapErrFunc(alias fun)
  if (is(ReturnType!(fun) == int)) {
  void wrapErrFunc(Args...)(Args args) {
    const res = fun(args);
    if (res < 0) {
      throw new PulseAudioException(res);
    }
  }
}

extern (C):

/** Return a human readable error message for the specified numeric error code */
char* pa_strerror(int error);