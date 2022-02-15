sudo launchctl remove com.sentinelone.sentineld-helper
sudo launchctl remove com.sentinelone.sentineld-shell
sudo launchctl remove com.sentinelone.sentineld-updater
sudo launchctl remove com.sentinelone.sentineld
sudo launchctl remove com.sentinelone.sentineld-guard

# list Agents: 
launchctl list | grep senti
sudo launchctl list | grep senti

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
# sudo pkgutil --forget com.sentinelone.pkg.sentinel-agent



killall SentinelAgent
#pkgutil --forget com.sentinelone.pkg.sentinel-agent

sudo launchctl remove com.googlecode.munki.logouthelper
sudo launchctl remove com.googlecode.munki.managedsoftwareupdate-check
sudo launchctl remove com.googlecode.munki.managedsoftwareupdate-manualcheck
sudo launchctl remove com.googlecode.munki.authrestartd
sudo launchctl remove com.googlecode.munki.appusaged
sudo launchctl remove com.googlecode.munki.managedsoftwareupdate-install
launchctl remove com.googlecode.munki.munki-notifier
launchctl remove com.googlecode.munki.app_usage_monitor
launchctl remove com.googlecode.munki.ManagedSoftwareCenter

rm -rf /Volumes/osx/usr/local/munki

launchctl list | grep munki
sudo launchctl list | grep munki

