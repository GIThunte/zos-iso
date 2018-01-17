#!/bin/bash
source ./rebuild.conf
function IF_ROOT() #you root ?
{
    if [[ $EUID -ne 0 ]]; then
        echo "$MSG_IF_ROOT"
        exit 1
    fi
}
function IF_FILE()
{
    for EXT_FILES in $@; do
        echo "$MSG_TEST_FILE: $EXT_FILES"
        test -e $EXT_FILES
        if [[ "$?" == "0" ]]; then
            echo "+"
        else
            echo "$MSG_ERR_FILE: $EXT_FILES"
            exit 1
        fi
        
    done
}
function IF_DIR()
{
    for EXT_DIRECTORY in $@; do
        echo "$MSG_TEST_FILE: $EXT_DIRECTORY"
        test -d $EXT_DIRECTORY
        if [[ "$?" == "0" ]]; then
            echo "+"
        else
            echo "$MSG_ERR_DIR: $EXT_DIRECTORY"
            exit 1
        fi
        
    done
}
function BASE_PKG()
{
    for INSTALL_BASE_PKG_1 in $@ ; do
        which $INSTALL_BASE_PKG_1 >/dev/null ||  apt-get install $INSTALL_BASE_PKG_1 -y --force-yes
    done
    apt-get clean
}
function CREATE_DIR() #func create dir
{
    if [[ -z "$@" ]]; then
        echo "$MSG_BAD_ARG: $@"
        exit 1
    else
        for FINDFOLDER in $@
        do if [ -d $FINDFOLDER ]; then
                echo $MSG_DIR_EXT
            else
                echo "$MSG_MKDIR $FINDFOLDER" ; sudo mkdir -p $FINDFOLDER
                IF_DIR $FINDFOLDER
            fi
        done
    fi
}

function GET_ISO()
{
    sudo wget $GET_ISO_URL -O $GET_ISO_FOLDER$ISO_NAME
    IF_FILE $GET_ISO_FOLDER$ISO_NAME
}
function MOUNT_ISO()
{
    IF_FILE $ISO_FILE
    sudo mount -v $ISO_FILE $DIR_MOUNT_ISO
    IF_FILE $PATH_FILE_SYSTEM_FILE
    sudo mount -v $PATH_FILE_SYSTEM_FILE $DIR_MOUNT_FILE_SYSTEM
}

function COPY_FILES()
{
    sudo cp -r -v -p -u $DIR_MOUNT_FILE_SYSTEM/* $DIR_CHROOT/
    sudo chmod +x $REBUILD_SCRIPT
    IF_FILE $REBUILD_SCRIPT
    sudo cp -v -p -u $REBUILD_SCRIPT $DIR_CHROOT$DEST_SCRIPT/$NAME_SCRIPT
    IF_FILE $SC_ADD_FILES
    sudo python $SC_ADD_FILES $SC_ADD_FILES_ARG
    sudo chroot $DIR_CHROOT $DEST_SCRIPT/$NAME_SCRIPT
}
function MKSQUASHFS()
{
    sudo mksquashfs $DIR_CHROOT $DIR_BOOT/$FS_SQU -e $1
    IF_FILE $DIR_BOOT/$FS_SQU
}
function UMOUNT_ISO()
{
    sudo umount -v -f -l $@
}
function DEL_FILES()
{
    echo $IF_MOUNT
    if [ -z "$IF_MOUNT" ]; then
        sudo rm -rf $@
    else
        UMOUNT_ISO $ISO_FILE/$ISO_NAME $PATH_FILE_SYSTEM_FILE
        sudo rm -rf $@
    fi
}
function CP_REST_FILES()
{
    IF_DIR $REST_ISO_FILES
    sudo rsync -v -r -h -a -u --progress $DIR_MOUNT_ISO/* $REST_ISO_FILES
}
function ADDFILES_IN_ISO()
{
    IF_FILE $SC_ADD_FILES
    sudo python $SC_ADD_FILES $SC_ADD_FILES_ARG
}
function CREATE_ISO()
{
    if [[ -z "$@" ]]; then
        echo "$MSG_BAD_ARG: $@"
        exit 1
    else
        genisoimage \
        -rational-rock \
        -volid "$GENISO_VOL" \
        -cache-inodes \
        -joliet \
        -hfs \
        -full-iso9660-filenames \
        -b isolinux/isolinux.bin \
        -c isolinux/boot.cat \
        -no-emul-boot \
        -boot-load-size 4 \
        -boot-info-table \
        -output $1 \
        $2
    fi
    IF_FILE $1
}
function COPY_ISO()
{
    IF_FILE $OUTPUT_ISO
    sudo chmod 755 $FINAL_ISO_VERSION
    sudo mv -v  $OUTPUT_ISO $FINAL_ISO_VERSION
    echo $FINAL_MSG
}



