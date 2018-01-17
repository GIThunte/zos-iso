#-*- coding: utf-8 -*-
import os.path
import sys
import shlex
import shutil

msgNoCopy = "There is no list of where to copy files from"
msgExc = "Script execution error"
msgRedFile = "Reading from "
msgNoDir = "Missing destination path"
fileCopy = "copy.txt"


sysArg = len(sys.argv)
if sysArg < 2:
    pass
else:
    fileCopy = str(sys.argv[1])


class copyFiles():
    def scriptMsg(self, msg):
        print(msg)

    def isFile(self, fileCp):

        try:
            ifFile = os.path.isfile(fileCp)
            copyInit.scriptMsg(msgRedFile + fileCopy)
            if ifFile == True:
                pass
            else:
                copyInit.scriptMsg(msgNoCopy)
                exit(1)
        except:
            copyInit.scriptMsg(msgExc)

    def ExtFolder(self, path):
        try:
            ExtDir = os.path.isdir(path)
            if ExtDir == True:
                pass
            else:
                copyInit.scriptMsg(msgNoDir)
                exit(1)
        except:
            copyInit.scriptMsg(msgExc)

    def copy(self, inpFs, outpFs):
        try:
            copyInit.ExtFolder(outpFs)
            print("Copy file " + inpFs + " in " + outpFs)
            shutil.copy(inpFs, outpFs)
        except:
            copyInit.scriptMsg(msgExc)
            exit(1)

    def readCopyDb(self):
        try:
            for cp in open(fileCopy):
                copyFiles = shlex.split(cp)
                inputFile = copyFiles[0]
                outputFiles = copyFiles[1]
                copyInit.copy(inputFile, outputFiles)
        except:
            copyInit.scriptMsg(msgExc)
            exit(1)

copyInit = copyFiles()
copyInit.isFile(fileCopy)
copyInit.readCopyDb()
