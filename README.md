# ping-torrc
Depending on wether a PC is pingable, use different torrc files for your running tor relay

The idea is that when your main PC/Workstation is online, your tor relay should run with a limited bandwidth in order to not limit you during work/gaming/whatever. Therefore, 2 different torrc files are set up, which instruct your tor instance to use different bandwidths. In this example, the fast configuration provides 3072kBytes/s and the slow configuration 640kBytes/s.

While this is the primary usecase for this script it can of course be used to also switch between two totally independent tor configrations.

Use preferrably in a cronjob. Needs root privileges in order to write/replace torrc file.

example: 'sudo ./ping-torrc.sh 192.168.1.1 /path/to/slow/torrc /path/to/fast/torrc'