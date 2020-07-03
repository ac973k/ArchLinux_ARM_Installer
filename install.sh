#!/system/bin/sh
 
busybox echo "Настраиваем DNS"
 
busybox mount -o remount,rw /system
busybox echo "dns 8.8.8.8" >> /system/etc/resolv.conf

 
echo "Качаем необходимые компоненты"
busybox mkdir -p /data/sdext2/arch
cd /data/sdext2/arch
busybox wget http://github.com/ac973k/ArchLinux_ARM_Installer/raw/master/archie.zip
 
 
echo "Установка"
 
cd /data/sdext2/arch
 
busybox unzip archie.zip
 

busybox tar xvJpf acl-2.2.53-3-armv7h.pkg.tar.xz
busybox tar xvJpf attr-2.4.48-3-armv7h.pkg.tar.xz
busybox tar xvJpf bash-5.0.017-1-armv7h.pkg.tar.xz
busybox tar xvJpf bzip2-1.0.8-3-armv7h.pkg.tar.xz
busybox tar xvJpf cryptsetup-2.3.3-1-armv7h.pkg.tar.xz
busybox tar xvJpf curl-7.70.0-1-armv7h.pkg.tar.xz
busybox tar xvJpf e2fsprogs-1.45.6-2-armv7h.pkg.tar.xz
busybox tar xvJpf expat-2.2.9-3-armv7h.pkg.tar.xz
busybox tar xvJpf filesystem-2020.05.20-1-armv7h.pkg.tar.xz
busybox tar xvJpf gcc-9.3.0-1-armv7h.pkg.tar.xz
busybox tar xvJpf gcc-libs-9.3.0-1-armv7h.pkg.tar.xz
busybox tar xvJpf glibc-2.31-2-armv7h.pkg.tar.xz
busybox tar xvJpf gpgme-1.13.1-7-armv7h.pkg.tar.xz
busybox tar xvJpf keyutils-1.6.1-4-armv7h.pkg.tar.xz
busybox tar xvJpf krb5-1.18.2-1-armv7h.pkg.tar.xz
busybox tar xvJpf libarchive-3.4.3-1-armv7h.pkg.tar.xz
busybox tar xvJpf libassuan-2.5.3-2-armv7h.pkg.tar.xz
busybox tar xvJpf libgpg-error-1.38-1-armv7h.pkg.tar.xz
busybox tar xvJpf libidn2-2.3.0-1-armv7h.pkg.tar.xz
busybox tar xvJpf libssh2-1.9.0-2-armv7h.pkg.tar.xz
busybox tar xvJpf links-2.20.2-4-armv7h.pkg.tar.xz
busybox tar xvJpf lzo-2.10-3-armv7h.pkg.tar.xz
busybox tar xvJpf ncurses-6.2-1-armv7h.pkg.tar.xz
busybox tar xvJpf openssl-1.1.1.g-2-armv7h.pkg.tar.xz
busybox tar xvJpf pacman-5.2.1-6-armv7h.pkg.tar.xz
busybox tar xvJpf pacman-mirrorlist-20200430-1-any.pkg.tar.xz
busybox tar xvJpf readline-8.0.004-1-armv7h.pkg.tar.xz
busybox tar xvJpf util-linux-2.35.2-1-armv7h.pkg.tar.xz
busybox tar xvJpf wpa_supplicant-2_2.9-7-armv7h.pkg.tar.xz
busybox tar xvJpf xz-5.2.5-1-armv7h.pkg.tar.xz
busybox tar xvJpf zlib-1_1.2.11-4-armv7h.pkg.tar.xz

 
echo "Делаем скрипт инициализации"
 
echo "#!/system/bin/sh" >> /system/bin/arch
echo "busybox mount -t proc none ./proc" >> /system/bin/arch
echo "busybox mount -o rbind /dev ./dev" >> /system/bin/arch
echo "busybox mount -t sysfs none ./sys" >> /system/bin/arch
echo "busybox mount -t tmpfs none ./tmp" >> /system/bin/arch
echo "cd /data/sdext2/arch" >> /system/bin/arch
echo "chroot . /bin/bash" >> /system/bin/arch
 
echo "Чистим"
 
rm *.tar.xz
rm *.zip

busybox cp -L /system/etc/resolv.conf /data/sdext2/arch/etc/resolv.conf
 
echo "Тестируем)"
 
cd /data/sdext2/arch

busybox chmod 755 postinstall.sh
 
busybox mount -t proc none ./proc
busybox mount -o rbind /dev ./dev
busybox mount -o rbind /sys ./sys
busybox mount -t tmpfs none ./tmp
 
chroot . /bin/bash