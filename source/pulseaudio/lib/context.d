module pulseaudio.lib.context;

import pulseaudio.lib.error;
import pulseaudio.bindings.pulse.context;

alias pa_context_connect_err = wrapErrFunc!(pa_context_connect);