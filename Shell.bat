::�ر�������ʾ
@echo off

::�������ԱȨ��
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

::�������ű�����ANSI���룬936Ϊ���ҳ����
chcp 936

::--------------------------------------------------------------------------------------------------------------------------

::�����
:choice
echo -----------------------------------------------------------------------
choice /c 123456 /m "1:�˳�  2:����AVD  3:����scrcpy  4:�޸�HOST�ļ�  5:��CMD  6:С����"
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
choice /c 12345 /m "1:�˳�  2:�������˵�  3:�����豸�б�  4:��������  5:��������"
if errorlevel 5 goto wireless
if errorlevel 4 goto cable
if errorlevel 3 goto deviceslist
if errorlevel 2 goto choice
if errorlevel 1 goto exit

:deviceslist
adb devices
goto scrcpy

:cable
echo ��scrcpy
scrcpy
goto scrcpy

:wireless
echo �������߶˿�Ϊ5555
adb tcpip 5555
echo �����ֻ�IP��ַ��
set /p IP=IP:
adb connect %IP%:5555
scrcpy
goto scrcpy

::--------------------------------------------------------------------------------------------------------------------------

:editHOST
echo -----------------------------------------------------------------------
choice /c 123456 /m "1:�˳�  2:�������˵�  3:��HOST�ļ�  4:����DNS  5:��DNS��ѯ��ҳ  6:��HOST�����ļ�"
if errorlevel 6 goto openHOSTbak
if errorlevel 5 goto openWebtool
if errorlevel 4 goto updateDNS
if errorlevel 3 goto openHOST
if errorlevel 2 goto choice
if errorlevel 1 goto exit

:openHOST
echo �����ļ�������...
copy C:\Windows\System32\drivers\etc\hosts C:\Windows\System32\drivers\etc\hosts.bak
echo �����ļ����ɳɹ����ļ�Ŀ¼��C:\Windows\System32\drivers\etc\hosts.bak
echo ��HOST�ļ���...
start notepad.exe C:\Windows\System32\drivers\etc\hosts
goto editHOST

:updateDNS
ipconfig /flushdns
goto editHOST

:openWebtool
echo ����ҳ��ѯ������...
start http://tool.chinaz.com/dns/
start https://www.ipaddress.com/
goto editHOST

:openHOSTbak
echo �����ļ�����...
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
choice /c 1234567 /m "1:�˳�  2:�������˵�  3:������  4:����׿Խ����ģʽ  5:ͼ�껺�����  6:���������  7:MBR�޸�"
if errorlevel 7 goto mbrfix
if errorlevel 6 goto speedyfox
if errorlevel 5 goto cleaniconcache
if errorlevel 4 goto bloodmodle
if errorlevel 3 goto sleepon
if errorlevel 2 goto choice
if errorlevel 1 goto exit

:sleepon
powercfg -h on
echo �����Ѵ�
goto tools

:bloodmodle
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
echo ׿Խ����ģʽ�ѿ����������е���׿Խ����ģʽ
goto tools

:cleaniconcache
taskkill /f /im explorer.exe
CD /d %userprofile%\AppData\Local
DEL IconCache.db /a
start explorer.exe
echo ִ�����
goto tools

:speedyfox
D:\DoraASN\Documents\SHELL\SpeedyFox.exe "/Firefox:default" "/Cent Browser:Default" "/Microsoft Edge:Default" 
echo ִ�����
goto tools

:mbrfix
D:
cd D:\DoraASN\Documents\SHELL
echo ��ȷ���Ѿ���MbrFix64.exe����Ϊ�Թ���Ա��ʽ�򿪣����������ã�
pause
MbrFix64 /drive 0 fixmbr
echo ִ�����
goto tools