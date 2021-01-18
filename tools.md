# [Windows 工具集](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/windows-commands)

### sysprep

sysprep是windows系统重新封装的必备工具。如果要进行定制映像的抓取，则必须使用sysprep对windows 10进行重新封装。sysprep执行过程会重置操作系统的SID，让系统处于一个原厂状态，只有这样的状态，才能够进行重新部署而不会出现SIDe重复的情况。

### dism

dism内置在windows中对映像进行修改的专门工具。它能够对映像进行在线或离线修改，比如可又离线通过dism命令向wim镜像添加硬件驱动程序、操作系统补丁包、开启或关闭操作系统组件等等。

### sysinternals



## cleanmgr.exe

Description: Disk Space Cleanup Manager for Windows
