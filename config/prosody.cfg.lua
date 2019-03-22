plugin_paths = { "/usr/lib/prosody/modules", "/custom-modules" }

use_libevent = true;

-- DO NOT DO THIS IN PRODUCTION
run_as_root = true;

modules_enabled = {
	-- Generally required
		"roster"; -- Allow users to have a roster. Recommended ;)
		"saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
		"tls"; -- Add support for secure TLS on c2s/s2s connections
		"dialback"; -- s2s dialback support
		"disco"; -- Service discovery

	-- Not essential, but recommended
		"private"; -- Private XML storage (for room bookmarks, etc.)
		"vcard"; -- Allow users to set vCards

	-- Nice to have
		"time"; -- Let others know the time here on this server
		"ping"; -- Replies to XMPP pings with pongs
		"pep"; -- Enables users to publish their mood, activity, playing music and more
		"websocket";
};

ssl = {
	key = "/certs/localhost.key";
	certificate = "/certs/localhost.crt";
}

daemonize = false

log = {
	info = "*console"; -- Change 'info' to 'debug' for verbose logging
	error = "*console";
}

VirtualHost "localhost"
	modules_enabled = { "dox" }
	authentication = "anonymous"
