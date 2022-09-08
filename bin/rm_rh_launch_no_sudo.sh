launchctl remove com.sentinelone.sentineld-helper
launchctl remove com.sentinelone.sentineld-shell
launchctl remove com.sentinelone.sentineld-updater
launchctl remove com.sentinelone.sentineld
launchctl remove com.sentinelone.sentineld-guard

# list Agents: launchctl list | grep senti

# stopping sentinelone
launchctl stop com.sentinelone.sentineld
launchctl stop com.sentinelone.sentineld-helper
launchctl stop com.sentinelone.sentineld-updater
launchctl stop com.sentinelone.sentineld
launchctl stop com.sentinelone.sentineld-guard

# removing sentinelone
launchctl remove com.sentinelone.sentineld
launchctl remove com.sentinelone.sentineld-helper
launchctl remove com.sentinelone.sentineld-updater
launchctl remove com.sentinelone.sentineld
launchctl remove com.sentinelone.sentineld-guard

# removing package
pkgutil --forget com.sentinelone.pkg.sentinel-agent



#killall SentinelAgent
pkgutil --forget com.sentinelone.pkg.sentinel-agent

launchctl remove com.googlecode.munki.logouthelper
launchctl remove com.googlecode.munki.managedsoftwareupdate-check
launchctl remove com.googlecode.munki.managedsoftwareupdate-manualcheck
launchctl remove com.googlecode.munki.authrestartd
launchctl remove com.googlecode.munki.appusaged
launchctl remove com.googlecode.munki.managedsoftwareupdate-install
launchctl remove com.googlecode.munki.munki-notifier
launchctl remove com.googlecode.munki.app_usage_monitor
launchctl remove com.googlecode.munki.ManagedSoftwareCenter

#rm -rf /Volumes/osx/usr/local/munki
