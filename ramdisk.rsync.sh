#!/bin/sh

# Pau Peris
# https://www.pauperis.com
# pau@pauperis.com

echo='/bin/echo'
mkdir='/bin/mkdir'
ls='/bin/ls'

cmd='/usr/bin/rsync'
opts='-avhXHxPL --numeric-ids --delete --recursive --force'

declare -A src=( [cache]='/var/cache' ) 

dst='/home/sys/ramdisk-backup'
logfile='ramdisk.rsync-'


function createdir() { 
    if [ ! -d "${dst}" ]
    then
        $mkdir "$1";
    fi
}

case "$1" in
    start)
	declare -a dirs=( "`ls ${dst}`");
	for i in "${dirs[@]}"
	do
	    echo "$cmd $opts" "$dst/$i" ${src[$i]} 1>> /var/log/"$logfile"restore.log 2>>/var/log/"$logfile"restore.err.log;
	done
        ;;

    sync | stop)
	createdir $dst;

        for i in "${src[@]}"
        do
            $echo "Synching $i from tmpfs to $dst";
            $echo [`date +"%Y-%m-%d %H:%M"`] "Synching $i from tmpfs to $dst" 1>> /var/log/"$logfile".log 2>>/var/log/"$logfile".err.log;
            eval "$cmd $opts" $i $dst 1>> /var/log/"$logfile"backup.log 2>>/var/log/"$logfile"backup.err.log;
        done
        ;;

    *)
        echo "Usage: $0 {start|stop|sync}"
        exit 1
esac

exit 0
