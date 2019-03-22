local http = require "net.http";
local st = require "util.stanza";
local base64 = require "util.encodings".base64;

local url = "https://dns.google.com/dns-query"

local xmlns_push = "urn:xmpp:dox:0"

function handle_stanza(event)
	local stanza = event.stanza;
	local dns_query = stanza.tags[1]:get_text()
	module:log("info", "DoX Query: %s", dns_query);

	http.request(url, {
		body = base64.decode(dns_query),
		method = "POST",
		headers = {
			Accept = "application/dns-message",
			["Content-Type"] = "application/dns-message"
		}
	}, function (response_text, code, response)
		module:log("info", "DoX response code: %s", tostring(code));
		if stanza.attr.type == "error" then return; end -- Avoid error loops, don't reply to error stanzas
		if code == 200 and response_text then
			local reply_stanza = st.stanza("iq", {
				to = stanza.attr.from, from = stanza.attr.to;
				type = "iq"
			});
			reply_stanza:tag("dns", { xmlns = xmlns_push }):text(tostring(base64.encode(response_text))):up();
			module:log("debug", "Sending %s", tostring(reply_stanza));
			module:send(reply_stanza);
		elseif code >= 200 and code <= 299 then
			return;
		else
			module:send(st.error_reply(stanza, "wait", "internal-server-error"));
		end
		return true;
	end);
	return true;
end

module:hook("iq-get/host/" .. xmlns_push .. ":dns", handle_stanza);

module:add_feature(xmlns_push);
