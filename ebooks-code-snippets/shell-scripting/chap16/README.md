# System Administration

This chapter provides four recipes for common system administration tasks. The first is an example of an init script to start an application automatically when the system boots up. This shows the use of case, and uses the /var/run filesystem to store a PID file.

The second recipe provides two related CGI scripts, processing GET and POST requests. This will show how to handle these two methods of passing data from the browser to the server. The security implications of handling user-submitted data are also addressed.

The third recipe shows how configuration files can be used to provide default values and show them to the end user as well as remembering previous values selected by the user.

Finally, the fourth recipe implements a locking mechanism to ensure that multiple concurrent processes can share a critical resource without interfering with each other’s use of it.
