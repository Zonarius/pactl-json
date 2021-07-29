import std.stdio;
import std.getopt;
import std.experimental.logger;
import std.string;
import core.time;
import core.thread.osthread;

import hunt.serialization;

import pulseaudio.client;
import pulseaudio.sinkinput;

void main(string[] args)
{
	bool verbose = false;
	string server = null;

	auto optInfo = getopt(
		args,
		"server|s", "The name of the server to connect to", &server,
		"verbose|v", "Enables verbose logging.", &verbose
	);

	void printHelp() {
		defaultGetoptPrinter(
			"
			USAGE: pactl-json list [TYPE]
			
			Provides information about a PulseAudio server as JSON.
			".outdent()
			, optInfo.options);
	}

	if (optInfo.helpWanted) {
		printHelp();
		return;
	}

	if (!verbose) {
		globalLogLevel = LogLevel.warning;
	}

	if (args.length < 2 || args[1] != "list") {
		printHelp();
		return;
	}

	if (args.length <= 2) {
		auto client = new Client();
		auto info = AllInfo(
			client.getSinkInputs()
		);
		writeln(info.toJson());
	} else if (args[2] == "sink-inputs") {
		auto client = new Client();
		auto inputs = client.getSinkInputs();
		writeln(inputs.toJson());
	} else {
		printHelp();
	}
}

package struct AllInfo {
	SinkInput[] sinkInputs;
}