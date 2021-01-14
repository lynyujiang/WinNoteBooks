# 学习笔记

## 工具

### sysprep

sysprep是windows系统重新封装的必备工具。如果要进行定制映像的抓取，则必须使用sysprep对windows 10进行重新封装。sysprep执行过程会重置操作系统的SID，让系统处于一个原厂状态，只有这样的状态，才能够进行重新部署而不会出现SIDe重复的情况。

### dism

dism内置在windows中对映像进行修改的专门工具。它能够对映像进行在线或离线修改，比如可又离线通过dism命令向wim镜像添加硬件驱动程序、操作系统补丁包、开启或关闭操作系统组件等等。

### sysinternals



## Windows安装映像文件



## WinSxS文件夹

### 查看WinSxS文件夹的真实大小

Dism.exe /Online /Cleanup-Image /AnalyzeComponentStore

### 减小WinSxS文件夹大小的方法

* Win+R -> cleanmgr /d C: -> 磁盘清理
* Win+R -> appwiz.cpl -> 关闭不常用的Windows功能



