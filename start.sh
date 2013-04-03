#!/bin/bash
echo 'Start application ...'
coffee --nodejs --debug server.coffee
coffee --nodejs --debug peer.coffee