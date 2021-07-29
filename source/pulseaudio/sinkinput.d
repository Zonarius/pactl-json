module pulseaudio.sinkinput;

import std.string;
import std.conv;
import pulseaudio.util;

import pulseaudio.bindings.pulse.introspect;

/// Stores information about sink inputs.
struct SinkInput {
  immutable int index; /**< Index of the sink input */
  immutable string name; /**< Name of the sink input */
  immutable int owner_module; /**< Index of the module this sink input belongs to, or PA_INVALID_INDEX when it does not belong to any module. */
  immutable int client; /**< Index of the client this sink input belongs to, or PA_INVALID_INDEX when it does not belong to any client. */
  immutable int sink; /**< Index of the connected sink */
  // immutable pa_sample_spec sample_spec; /**< The sample specification of the sink input. */
  // immutable pa_channel_map channel_map; /**< Channel map */
  // immutable pa_cvolume volume; /**< The volume of this sink input. */
  immutable int buffer_usec; /**< Latency due to buffering in sink input, see pa_timing_info for details. */
  immutable int sink_usec; /**< Latency of the sink device, see pa_timing_info for details. */
  immutable string resample_method; /**< The resampling method used by this sink input. */
  immutable string driver; /**< Driver name */
  immutable bool mute; /**< Stream muted \since 0.9.7 */
  immutable string[string] proplist; /**< Property list \since 0.9.11 */
  immutable bool corked; /**< Stream corked \since 1.0 */
  immutable bool has_volume; /**< Stream has volume. If not set, then the meaning of this struct's volume member is unspecified. \since 1.0 */
  immutable bool volume_writable; /**< The volume can be set. If not set, the volume can still change even though clients can't control the volume. \since 1.0 */
  // immutable pa_format_info* format; /**< Stream format information. \since 1.0 */

  /// Creates a [SinkInput] from a PulseAudio [pa_sink_input_info]
  this(const(pa_sink_input_info*) input) {
    assert(input !is null);
    
    index = input.index;
    name = input.name.to!string;
    owner_module = input.owner_module;
    client = input.client;
    sink = input.sink;
    buffer_usec = input.buffer_usec.to!int;
    sink_usec = input.sink_usec.to!int;
    resample_method = input.resample_method.to!string;
    driver = input.driver.to!string;
    mute = input.mute.to!bool;
    proplist = input.proplist.toMap;
    corked = input.corked.to!bool;
    has_volume = input.has_volume.to!bool;
    volume_writable = input.volume_writable.to!bool;
  }
}