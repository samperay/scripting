# System Administration

- The first is an example of an init script to start an application automatically when the system boots up. This shows the use of case, and uses the /var/run filesystem to store a PID file.

- The second recipe shows how configuration files can be used to provide default values and show them to the end user as well as remembering previous values selected by the user.

Finally, the fourth recipe implements a locking mechanism to ensure that multiple concurrent processes can share a critical resource without interfering with each other’s use of it.
