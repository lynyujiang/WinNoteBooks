# 学习笔记

## Windows安装映像文件



## WinSxS文件夹

### 查看WinSxS文件夹的真实大小

Dism.exe /Online /Cleanup-Image /AnalyzeComponentStore

### 减小WinSxS文件夹大小的方法

#### 方法一：使用「磁盘清理」工具

* 使用 Windows + R 快捷键打开「运行」—— 执行 cleanmgr.exe /d c: 打开「磁盘清理」工具

* 在下拉列表中选择系统盘——点击「确定」——在打开的工具界面中点击「清理系统文件」按钮

#### 方法二：移除一些不用的Windows功能

* 使用 Windows + R 快捷键打开「运行」—— 执行 appwiz.cpl 打开添加删除程序

* 点击左侧的「启用或关闭 Windows 功能」

#### 方法三：使用DISM自动进行组件清理

* Win+R -> taskschd.msc -> 打开任务计划程序 -> Servicing -> 打开操作系统中内置了一个自动执行 WinSxS 组件存储清理的任务计划

或者

* schtasks.exe /Run /TN "\Microsoft\Windows\Servicing\StartComponentCleanup"


#### 方法四：使用DISM自动进行组件清理

* 使用 Windows + R 快捷键打开「运行」—— 以管理员身份打开「cmd.exe」工具

* 手动执行以下命令：

DISM.exe /online /Cleanup-Image /StartComponentCleanup

## 如何在 Windows 10 中查看计算机系统型号

### 方法一：通过「系统信息」查看计算机系统型号

* 使用 Windows + R 快捷键打开「运行」——执行 msinfo32 命令打开「系统信息」

* 点击左侧「系统摘要」——在右侧可以看到当前「系统型号」

### 方法二：使用「命令提示符」查看系统型号

* 在「开始」菜单中搜索 cmd ——打到并打开「命令提示符」

* 执行以下命令即可查看到计算机型号：

wmic csproduct get name

* 也可以使用以下命令获取计算机系统型号和序列号：

wmic csproduct get name, identifyingnumber

### 方法三：使用 PowerShell 查看系统型号

* 使用 Windows + X 快捷键打开快捷菜单——选择打开 Windows PowerShell

* 执行以下命令以检查计算机型号以及设备的序列号：

Get-CimInstance -ClassName Win32_ComputerSystem

* 或者可选使用以下命令：

Get-CimInstance -ClassName Win32_bios

## 设置Windows 10系统时区

### 方法1：使用「Windows 设置」自动设置时区

* 使用 Windows + I 快捷键打开「Windows 设置」

* 打开「时间和语言」——「日期和时间」

* 启用「自动设置时区」开关

### 方法2：使用「Windows 设置」手动调整时区

* 使用 Windows + I 快捷键打开「Windows 设置」

* 打开「时间和语言」——「日期和时间」

* 在「时区」下拉列表中选择一个合适的 UTC 时区即可

### 方法3：使用「命令提示符」调整时区

* 在「开始」菜单中搜索 cmd——右击「命令提示符」——选择「以管理员身份运行」

* 可以执行以下命令以查看当前时区设置：

tzutil /g

* 如果要调整时区设置，可使用以下命令：

tzutil /s "China Standard Time"

### 方法4：使用Powershell调整时区

* 使用 Windows + X 快捷键打开快捷菜单——选择 Windows PowerShell（管理员）

* 执行以下命令查看当前时区设置：

Get-TimeZone

* 执行以下命令列出可用时区列表：

Get-TimeZone -ListAvailable

* 使用以下命令调整时区设置：

Set-TimeZone -Name "China Standard Time"

## 使用PowerShell强制删除Windows 10语言包

* 使用 Windows + X 快捷键弹出「快捷菜单」——选择打开「Windows PowerShell（管理员）」

* 键入以下命令以列出 Windows 10 PC 当前已安装的语言，然后按「回车」键：

Get-WinUserLanguageList

* 记下要删除语言包的 LanguageTag 标签。

* 执行以下命令（一次一行）以删除不需要的语言：

    $LangList = Get-WinUserLanguageList
    $MarkedLang = $LangList | where LanguageTag -eq "LANGUAGETAG"
    $LangList.Remove($MarkedLang)
    Set-WinUserLanguageList $LangList -Force

在二行命令中，确保使用要删除语言包的代码更改 LANGUAGETAG。例如要强制删除繁体中文，则替换为 zh-Hant-TW。

## 禁用Windows 10的休眠模式

在 Windows 10 上，休眠功能可以将数据保存到硬盘中，以便在不丢失工作的情况下完全关闭设备。 当您的设备重新启动时，您重新加到之前「离开的地方」。

虽然休眠是一个很好的功能，但根据系统内存大小，可能需要非常大的磁盘空间才能将加载到内存中的数据存储到 hiberfil.sys 文件中。

如果您的存储空间不足，可以使用以下步骤禁用休眠模式以便腾出更多磁盘空间：

1 在「开始」菜单中搜索 cmd——右击「命令提示符」——选择「以管理员身份运行」

2 执行如下命令：

powercfg hibernate off

3 命令执行后立即生效，系统盘中的 hiberfil.sys 休眠文件会被删除，并且直接禁用 Windows 10 的休眠功能。

注意：如果您想恢复 Windows 10 休眠功能，可以使用 powercfg /hibernate on 命令。

## 压缩Windows 10系统磁盘

compact /compactos:always

## 如何使用Robocopy多线程功能加速Windows 10中的文件复制

robocopy C:\source\folder\path\ D:\destination\folder\path\ /S /ZB /R:5 /W:5 /V /MT:32

## 使用WinSAT系统评估工具进行基准测试

WinSAT 是 Windows 系统评估工具（Windows System Assessment Tool）的缩写，是从 Windows Vista 开始便内置于系统之中的命令行工具，可对 Windows PC 的各个组件进行基准测试。

### WinSAT语法

winsat <评估名称> <评估参数>

    winsat dwm – 评估系统 Aero 桌面效果的能力。
    winsat d3d – 评估系统运行 Direct 3D 应用程序的能力。
    winsat mem – 评估系统内存带宽。
    winsat disk – 评估磁盘驱动器的性能。
    winsat cpu – 评估 CPU 的性能。
    winsat media – 使用 Direct Show 框架来评估视频编码和解码的性能。
    winsat mfmedia – 评估使用 Media Foundation 框架进行视频解码的性能。
    winsat features – 列举相关的系统信息。

如果想要活的帮助，可以使用 winsat -help。

### WinSAT使用示例

#### 运行完整评估

winsat formal

以上命令运行后会执行一个预定义评估，并将数据保存到 %systemroot%\performance\WinSAT\datastore 文件夹的 XML 文件当中。

如果你需要重新执行评估，可以执行 winsat formal -restart。

### 评估磁盘性能

对 C: 盘执行顺序读取 IO 性能评估：

winsat disk -seq -read -drive c

对 C: 盘执行随机写入 IO 性能评估：

winsat disk -ran -write -drive c

用默认配置运行一个完整的磁盘性能评估：

winsat disk

### 评估内存性能

使用默认配置运行完整的 RAM 评估：

winsat mem

winsat 命令行的用法可以很自由灵活，比如想用 32MB buffer 来执行 4 – 12 秒的评估并将结果写入到 memtest.xml 文件中，就可以使用如下命令：

winsat mem -mint 4.0 -maxt 12.0 -buffersize 32MB -xml memtest.xml

### 评估处理器性能

执行 256-bit AES 加密评估：

winsat cpu -encryption

使用 Lempel-Zev 压缩来运行评估：

winsat cpu -compression

### 使用PowerShell装载和弹出ISO映像

* 装载 ISO 映像：

    Mount-DiskImage -ImagePath "E:\windows_10_1607.iso"


* 弹出已挂载的 ISO：

    Dismount-DiskImage -ImagePath "E:\windows_10_1607.iso"

## 如何使用DISM修复Windows 10映像

使用 DISM 命令行工具对 Windows 10 映像进行修复，主要有 CheckHealth、ScanHealth 和 RestoreHealh 三个阶段，你必需按顺序执行整个修复过程。

### DISM CheckHealth选项

DISM 命令行的 /CheckHealth 开关顾名思义是用于对所有损坏文件进行检测，它只执行健康检查，并不执行任何修复：

* 点击 Windows + X 快捷键 – 选择「命令提示符（管理员）」

* 在命令行中执行如下命令进行检测：

DISM /Online /Cleanup-Image /CheckHealth

### DISM ScanHealth选项

DISM 命令行的 /ScanHealth 开关与 /CheckHealth 不同，它主要用于扫描 Windows 映像文件中损坏的部分。与你的 PC 性能和环境相关，其最长可能要执行 10 多分钟才能完成。

* 点击 Windows + X 快捷键 – 选择「命令提示符（管理员）」

* 在命令行中执行如下命令进行检测：

DISM /Online /Cleanup-Image /ScanHealth

### DISM RestoreHearlh选项

DISM 命令行的 /RestoreHearlh 开关在扫描到 Windows 映像文件中的错误之后会自动尝试进行修复，与前两个命令不同，/RestoreHearlh 选项由于还要执行修复过程，所以执行时间更长，长的需要 20 执行分钟左右。

* 点击 Windows + X 快捷键 – 选择「命令提示符（管理员）」

* 在命令行中执行如下命令进行检测和修复：

DISM /Online /Cleanup-Image /RestoreHealth

### 指定DISM修复源

DISM 命令行支持在使用 /RestoreHealth 参数的同时使用 /Source 来指定原生的系统映像作为修复源，在使用此功能时，建议大家下载官方原生 Windwos 10 ISO，并提取出其中的 install.wim 文件作为修复源。ISO 下载和提取过程非常简单，这里就不介绍了。

* 点击 Windows + X 快捷键 – 选择「命令提示符（管理员）」

* 在命令行中执行如下命令即可进行检测和修复：

DISM /Online /Cleanup-Image /RestoreHealth /Source:文件路径\install.wim

* 你也可以在指定修复源时通过如下命令取限制使用 Windows Update：

DISM /Online /Cleanup-Image /RestoreHealth /Source:文件路径\install.wim /LimitAccess

## 开/关U盘写保护

* 将 U 盘插入计算机 — 以管理员方式打开命令提示符 — 执行 diskpart 命令。

* 在 diskpart 的交互界面中执行 list disk 命令，查看 U 盘的编号。

list disk

* 执行 select disk 3 选中要执行操作的 U 盘，大家注意把编号改成你自己环境看到的实际号码。

* 执行 attributes disk 命令即可看到当前磁盘，即选中 U 盘的所有属性。

attributes disk

* 大家可以看到，默认情况下 Windows 10 中使用的常用 U 盘都是非只读的。要开启写保护只需执行 attributes disk set readonly 即可。

attributes disk set readonly

此时，当用户再尝试编辑 U 盘中的文件或写入、覆盖数据时，将会收到报错提示。

* 如果要取消 U 盘只读功能，只需按上述部署以同样的方式选中 U 盘之后，使用 attributes disk clear readonly 命令将只读属性清除即可。

## 使用命令行让Windows 10进入睡眠

rundll32.exe powrprof.dll,SetSuspendState 0,1,0

## 使用PowerShell压缩和解压ZIP文件

### 创建 ZIP 压缩文件

Compress-Archive -Path D:\Tools -DestinationPath E:\Tools_bakcup.zip

### 解压 ZIP 包

Expand-Archive -Path E:\Tools_bakcup.zip -DestinationPath F:\Tools

## 在Windows 10中使用命令行管理WIFI无线网络

微软从 Windows 2000 开始便内置了一个 Netsh（Network Shell）命令行工具，以帮助用户执行本地或远程计算机上不同网卡的信息查看、配置及排错工作。

### 查看WIFI无线网络配置文件

当我们在 Windwos 10 中连接过不同的 WIFI 之后，操作系统都会自动生成一个单独的「无线网络配置文件」并存储在计算机中，使用如下命令我们便可以看到当前系统中所有连接过的 WIFI 配置文件：

Netsh WLAN show profiles

以上命令会显示出所有无线网卡连接过的 WIFI 配置文件，如果你有多块无线网卡，还可以使用 interface 参数跟上网卡名称进行单独列出：

Netsh WLAN show profiles interface="无线网上名称"

### 查看无线网卡驱动信息

要查看当前 Windows 10 的无线网卡驱动信息可以使用如下命令：

Netsh WLAN show drivers

「Show drivers」将详细显示无线网卡的驱动程序、供应商、版本号、支持的无线类型及其它更多相关信息。

你也可以随时使用如下命令来查看当前无线网卡所支持及兼容的（系统及硬件）功能：

Netsh WLAN show wirelesscapabilities

### 查看无线网卡配置

当你需要查看无线网卡的：无线电类型、信道、传输速率等信息时，可以使用如下命令：

Netsh WLAN show interfaces

「Show interfaces」将详细显示所有无线网卡的信息，你也可以使用如下命令来指定网卡：

Netsh WLAN show interface name="网卡名称"

### 查看WIFI密码

如果时间久了，你忘了某个已连接过的 WIFI 密码，可以使用如下命令进行查看：

Netsh WLAN show profile name="无线名称" key=clear

请记住，在「控制面板」的网卡属性中可以查看当前无线网络的密码，使用上诉命令可以查看所有连接过的 WIFI 密钥。
停止自动连接到某个WIFI无线网络

通常我们都会配置 Windows 10 自动连接到 WIFI，但在有多个无线网络的情况下，系统自动选择连接的那个 WIFI 可能信号较差，此时我们可以使用如下命令以阻止系统自动连接到某个 WIFI 无线网络：

Netsh WLAN set profileparameter name="无线名称" connectionmode=manual

如果你想恢复自动连接，只需将最后的参数改为 auto 即可。

### 删除WIFI配置文件

当你不需要再连接某个无线网络、更改了 SSID 或需要重置配置文件时，可以使用如下命令来删除指定的 WIFI 配置文件：

Netsh WLAN delete profile name="无线名称"

### 导入和导出WIFI无线网络配置文件

在 Windows 7 中，用户可以直接在「控制面板」中导入和导出无线网络配置文件，但从 Windows 8/10 开始，微软从界面中移除了该功能。不过，我们还是可以使用命令行来完成操作。

下列命令可以导出 WIFI 无线网络配置的 xml 文件：

Netsh WLAN export profile key=clear folder="存放路径"

默认情况下会为每个 WIFI 连接都导出一个单独的配置文件，如果你只想导出单个配置文件，可以使用如下命令：

Netsh WLAN export profile name="无线名称" key=clear folder="存放路径"

导出配置文件也非常简单，使用如下命令即可：

Netsh WLAN add profile filename="存放路径"

### 生成无线网卡报告

你可以使用如下命令来创建和生成详细的无线网卡报告：

Netsh WLAN show WLANreport

大家可以在如下路径中去查看这个诊断报告：

C:\ProgramData\Microsoft\Windows\WlanReport\wlan-report-latest.html

该报告是非常详细和专业的无线网卡诊断报告，无线网络的连接和断开时间都有记录。

## 如何跳过等待更新，让Windows直接关机

shutdown -s -f -t 00

以上参数中的-s代表关机，-f表示强制关闭所有应用程序，-t 00代表不用等待立即执行（时间以秒计算，把时间改长就变成了定时关机！）。

## 配置Windows 10自动登录的两种方式

### 使用高级用户账户控制面板

* 在运行中执行 netplwiz 命令

* 此时将自动打开「高级用户账户控制面板」，在此你可以选中需要自动登录的账户名称 — 取消勾选「要使用本计算机，用户必需输入用户名和密码」选项 — 点击「应用」

* 在点击「应用」后会自动弹出「自动登录」窗口，在这里输入账户的密码以便在 Windows 10 自动登录时使用。

### 使用注册表

* 在运行中执行 regedit 打开注册表

* 浏览到如下路径：

HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon

* 在右侧窗口中找到名为 AutoAdminLogon 的字符串值，并将其设置为 1

AutoAdminLogon

* 在右侧窗口中找到名为 DefaultUserName 的字符串值，在里面填入要自动登录的默认账户

* 在右侧窗口中找到名为 DefaultPassword 的字符串值（如果没有就新建一个），将其值设置为所选账号的默认密码。

## 如何判断当前PC使用的是传统BIOS还是UEFI

* 按下 Windows + R — 在运行中执行 msinfo32

* 在打开的系统信息工具右侧的BIOS模式中即可查看到。

## 查看Windows 10版本号的3种方法

### 使用WinVer命令

* 按下 Windows + R

* 在运行中执行 winver 命令

### 使用命令行进行查看

systeminfo | findstr Build

### 使用注册表进行查看

1 按下 Windows + R — 执行 regedit 命令打开注册表

2 浏览到如下路径：

    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion




