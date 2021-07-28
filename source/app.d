import std.stdio;
import pulseaudio.client;

import core.time;
import core.thread.osthread;

import hunt.serialization;

void main()
{
	auto client = new Client();
	auto inputs = client.getSinkInputs();
	writeln(inputs.toJson());
}
