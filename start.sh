source ./rebuild.sh
source ./rebuild.conf
IF_ROOT 
BASE_PKG $BASE_PKG
DEL_FILES  $OUTPUT_ISO $WORK_DIR
CREATE_DIR $WORK_DIR $MNT_DIR $DIR_MOUNT_ISO $DIR_MOUNT_FILE_SYSTEM $DIR_CHROOT $TEST_FOLDER
CREATE_DIR $OUT_ISO_PATH $REST_ISO_FILES $DIR_BOOT $SOURCE_FILES $GET_ISO_FOLDER $FINAL_ISO_VERSION
GET_ISO
MOUNT_ISO $ISO_FILE $DIR_MOUNT_ISO $PATH_FILE_SYSTEM_FILE $DIR_MOUNT_FILE_SYSTEM
COPY_FILES
MKSQUASHFS $IGNORE_DIR_MKSQU
CP_REST_FILES

CREATE_ISO $OUTPUT_ISO $REST_ISO_FILES/
UMOUNT_ISO $PATH_FILE_SYSTEM_FILE $ISO_FILE
COPY_ISO
IF_FILE $FINAL_ISO_VERSION/$ISO_NAME