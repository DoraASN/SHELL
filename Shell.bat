::关闭命令显示
@echo off

::申请管理员权限
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

::声明本脚本采用ANSI编码，936为其活页代码
chcp 936

::--------------------------------------------------------------------------------------------------------------------------

::总入口
:choice
::转到脚本所在目录
D:
cd D:\DoraASN\Documents\SHELL\
echo -----------------------------------------------------------------------
choice /c 123456 /n /m "1:退出  2:启动AVD  3:启动scrcpy  4:修改HOST文件  5:打开CMD  6:小工具"
if errorlevel 6 goto tools
if errorlevel 5 goto openCMD
if errorlevel 4 goto editHOST
if errorlevel 3 goto scrcpy
if errorlevel 2 goto runavd
if errorlevel 1 goto exit

::--------------------------------------------------------------------------------------------------------------------------

:exit
exit

::--------------------------------------------------------------------------------------------------------------------------

:runavd
echo -----------------------------------------------------------------------
D:
cd \SoftWares\Android\Sdk\tools
emulator -avd MI_6_API_28
goto choice

::--------------------------------------------------------------------------------------------------------------------------

:scrcpy
echo -----------------------------------------------------------------------
choice /c 12345 /n /m "1:退出  2:返回主菜单  3:连接设备列表  4:有线连接  5:无线连接"
if errorlevel 5 goto wireless
if errorlevel 4 goto cable
if errorlevel 3 goto deviceslist
if errorlevel 2 goto choice
if errorlevel 1 goto exit

:deviceslist
adb devices
goto scrcpy

:cable
echo 打开scrcpy
scrcpy
goto scrcpy

:wireless
echo 设置无线端口为5555
adb tcpip 5555
echo 输入手机IP地址：
set /p IP=IP:
adb connect %IP%:5555
scrcpy
goto scrcpy

::--------------------------------------------------------------------------------------------------------------------------

:editHOST
echo -----------------------------------------------------------------------
choice /c 123456 /n /m "1:退出  2:返回主菜单  3:打开HOST文件  4:更新DNS  5:打开DNS查询网页  6:打开HOST备份文件"
if errorlevel 6 goto openHOSTbak
if errorlevel 5 goto openWebtool
if errorlevel 4 goto updateDNS
if errorlevel 3 goto openHOST
if errorlevel 2 goto choice
if errorlevel 1 goto exit

:openHOST
echo 备份文件生成中...
copy C:\Windows\System32\drivers\etc\hosts C:\Windows\System32\drivers\etc\hosts.bak
echo 备份文件生成成功，文件目录：C:\Windows\System32\drivers\etc\hosts.bak
echo 打开HOST文件中...
start notepad.exe C:\Windows\System32\drivers\etc\hosts
goto editHOST

:updateDNS
ipconfig /flushdns
goto editHOST

:openWebtool
echo 打开网页查询工具中...
start http://tool.chinaz.com/dns/
start https://www.ipaddress.com/
goto editHOST

:openHOSTbak
echo 备份文件打开中...
start notepad.exe C:\Windows\System32\drivers\etc\hosts.bak
goto editHOST

::--------------------------------------------------------------------------------------------------------------------------

:openCMD
echo -----------------------------------------------------------------------
CMD
goto choice

::--------------------------------------------------------------------------------------------------------------------------

:tools
echo -----------------------------------------------------------------------
choice /c 12345678 /n /m "1:退出  2:返回主菜单  3:打开休眠  4:开启卓越性能模式  5:图标缓存清空  6:浏览器加速  7:MBR修复  8:网络测速（网页工具）"
if errorlevel 8 goto speedroad
if errorlevel 7 goto mbrfix
if errorlevel 6 goto speedyfox
if errorlevel 5 goto cleaniconcache
if errorlevel 4 goto bloodmodle
if errorlevel 3 goto sleepon
if errorlevel 2 goto choice
if errorlevel 1 goto exit

:sleepon
powercfg -h on
echo 休眠已打开
goto tools

:bloodmodle
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
echo 卓越性能模式已开启，请自行调制卓越性能模式
goto tools

:cleaniconcache
taskkill /f /im explorer.exe
CD /d %userprofile%\AppData\Local
DEL IconCache.db /a
start explorer.exe
echo 执行完成
goto tools

:speedyfox
SpeedyFox.exe "/Firefox:default" "/Cent Browser:Default" "/Microsoft Edge:Default" 
echo 执行完成
goto tools

:mbrfix
echo 请确认已经将MbrFix64.exe设置为以管理员方式打开（属性中设置）
pause
MbrFix64 /drive 0 fixmbr
echo 执行完成
goto tools

:speedroad
start https://plugin.speedtest.cn/speedroad#/
echo 请在网页中进行操作
goto tools