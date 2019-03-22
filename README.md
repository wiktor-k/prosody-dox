# DNS-over-XMPP Prosody module

This project presents a small Prosody server that allows anonymous logins
and serves DNS-over-XMPP service.

## Running

    docker run --rm -it -p 5222:5222 -v $PWD/config:/etc/prosody -v $PWD/certs:/certs -v $PWD/modules:/custom-modules prosody/prosody

## Production use

Note that this project as it is **is not ready for production**. Most notably
TLS certificates are self-signed and Prosody configuration allows running as
root.
