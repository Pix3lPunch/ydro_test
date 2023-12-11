#
# Regular cron jobs for the deemix package
#
0 4	* * *	root	[ -x /usr/bin/deemix_maintenance ] && /usr/bin/deemix_maintenance
