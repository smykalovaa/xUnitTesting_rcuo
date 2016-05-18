@echo off
rem 
rem ����஢���� ��४��祭�� ��⮪ �࠭���� xUnitFor1C
rem
rem �ॡ������: 
rem 	1. ��⠭������� Git. ���� � ���� ��室����� � ��⥬��� PATH.
rem		2. ����� � ᠩ�� GitHub - https://github.com/xDrivenDevelopment/xUnitFor1C
rem 
rem �ਬ�� �맮�� (��४��祭�� master <-> develop � ���⭮): 
rem 	git_xUnitFor1C_check.cmd
rem ��� (��४��祭�� master <-> develop <-> �����⪨ � ���⭮): 
rem 	git_xUnitFor1C_check.cmd �����⪨
rem

setlocal
if "%1"=="" ( set branch=develop 
) else ( 
	set branch=%1
)
	rem echo %branch%

set git_cmd=git
if EXIST "%LOCALAPPDATA%\Atlassian\SourceTree\git_local\cmd\git.exe" set git_cmd="%LOCALAPPDATA%\Atlassian\SourceTree\git_local\cmd\git.exe"

set remoteRepo=https://github.com/xDrivenDevelopment/xUnitFor1C.git
	rem set remoteRepo=C:\Projects\xUnitFor1C_t1\.git

set repo=%CD%\xUnitFor1C_temp831

	rem echo %repo%

rd /S /Q %repo%
if EXIST %repo% (
	tskill TGitCache
	rd /S /Q %repo%
	if EXIST %repo% (
		echo �� 㤠���� 㤠���� ��⠫�� %repo%
		exit 1
		pause
	)
)

md %repo%

%git_cmd% -c diff.mnemonicprefix=false -c core.quotepath=false clone --recursive %remoteRepo% %repo%

set old_branch=master
cd %repo%
%git_cmd% checkout -b develop origin/develop
if errorlevel 1 (
	echo .
	echo �� 㤠���� ��४������� �� ���� develop �� ��⪨ %old_branch%
	pause
	exit 2
)
%git_cmd% status
set old_branch=develop

if not %branch%==develop (
	%git_cmd% checkout -b %branch% origin/%branch%
	if errorlevel 1 (
		echo .
		echo �� 㤠���� ��४������� �� ���� %branch% �� ��⪨ %old_branch%
		pause
		exit 5
	)
	%git_cmd% status
	set old_branch=%branch%
)

%git_cmd% checkout master
if errorlevel 1 (
	echo .
	echo �� 㤠���� ��४������� �� ���� master �� ��⪨ %old_branch%
	pause
	exit 3
)
%git_cmd% status
set old_branch=master

%git_cmd% checkout  develop
if errorlevel 1 (
	echo .
	echo �� 㤠���� ����୮ ��४������� �� ���� develop �� ��⪨ %old_branch%
	pause
	exit 4 
)
%git_cmd% status
set old_branch=develop

if not %branch%==develop (
	%git_cmd% checkout %branch%
	if errorlevel 1 (
		echo .
		echo �� 㤠���� ����୮ ��४������� �� ���� %branch% �� ��⪨ %old_branch%
		pause
		exit 6
	)
	%git_cmd% status
	set old_branch=%branch%
)

%git_cmd% checkout master
if errorlevel 1 (
	echo .
	echo �� 㤠���� ����୮ ��४������� �� ���� master �� ��⪨ %old_branch%
	pause
	exit 7
)
%git_cmd% status
set old_branch=master

endlocal
echo �� ��४��祭�� �����訫��� �ᯥ譮
exit 0