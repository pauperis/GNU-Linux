# GNU-Linux

**ramdisk.rsync** OpenRC init script to sync tmpfs directories to hard disk and viceversa on system shutdown and boot respectively. I used on my GNU/Funtoo OS but would also work for GNU/Gentoo users.    
This is the line i added to */etc/fstab* file:  
`varcache     /var/cache     tmpfs     size=2048M,noatime,nodiratime,nodev     0 0`  
Then run *sudo mount -a*.  
Once */var/cache* is mounted as tmpfs one can go on with the last step. By default, the scripts uses */home/sys/ramdisk-backup* directory to store */var/cache* contents when the system goes down so make sure a)the backup directory exists - *mkdir -p /home/sys/ramdisk-backup* - or b) edit the script and change *dst* var to your please and then create the desired backup directory.
Just *download or clone* or the file *into /etc/init.d*, then *chmod +x /etc/init.d/ramdisk.rsync* and sudo *rc-update add ramdisk.rsync boot*.  
Lastly, run *sudo /etc/init.d/ramdisk.rsync sync && sudo /etc/init.d/ramdisk.rsync start*.
