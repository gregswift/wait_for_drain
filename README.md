wait_for_drain
===============

Copyright © 2014 Greg Swift

Written by: Greg Swift <greg.swift@nytefyre.net>

License: General Public License (GPL) v3

Description
===============

When running servers behind a load balancer it can be important to insure 
that all active connections to a host are closed before continuing beyond
a certain point.

wait_for_drain is a simple cli implementation that watches an specific
IP:PORT combination to determine if the active conections have closed.

This is a stand-alone implementation of a functionality that has been
submitted to Ansible as enhancement to the wait_for module. I strongly
recommend using Ansible in the long run, over this function.

Usage
===============

* Check if all active connections on IPv4 port 80 are closed
```
# wait_for_drain 0.0.0.0:80
```

* Check if all active connections on 24.24.24.24:443 are closed
```
# wait_for_drain 24.24.24.24:443 
```

* Check the last one, but give a timeout of 60s (default is 30s)
```
# wait_for_drain 24.24.24.24:443 60
```

Known Issues
===============
* While the code supports IPv6, the cli needs some changes to support it.

How to report bugs
===============
Visit https://github.com/gregswift/wait_for_drain/issues
