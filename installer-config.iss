#define MyAppId       "A44C3C34-52ED-4625-8BBC-912B911SDA43"  
#define MyAppName     "Flutter Codes"
#define MyAppVersion "1.0.0.1"
#define MyWebsite "https://www.facebook.com"
#define MyAppPublisher "Mohammad Amini"
#define MyAppURL "https://www.facebook.com"
#define MyAppExeName "flutter_codes.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId=A44C3C34-52ED-4625-8BBC-912B911SDA43     
PrivilegesRequired=admin
ArchitecturesInstallIn64BitMode=x64
; Note: We don't set ProcessorsAllowed because we want this
; installation to run on all architectures (including Itanium,
; since it's capable of running 32-bit code too).

AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName="{#MyAppName} {#MyAppVersion}"                                 
AppPublisher="Intec Billing/CSG International"                                         
AppPublisherURL={#MyWebsite}
AppSupportURL={#MyWebsite}
AppUpdatesURL={#MyWebsite}
Compression=lzma
DefaultDirName="Directory Name"
DisableDirPage=yes
DisableProgramGroupPage=yes
; LicenseFile="{#SourceFileDir}\installer\iCABS4 Setup License Agreement.txt"    
; OutputDir={#SourceFileDir}\installer                                                            
OutputBaseFilename="{#MyAppName}-v{#MyAppVersion}_Full_Setup"
SetupIconFile=D:\Flutter apps\flutter_codes\windows\runner\resources\app_icon.ico
SetupLogging=yes
SolidCompression=yes
VersionInfoVersion={#MyAppVersion}


; If this SETUP parameter is set, its value will be used for the name displayed in
; the Control Panel's "Programs and Features" applet instead of the value of APPNAME.
; -----------------------------------------------------------------------------------
;UninstallDisplayName="iCABS4_5 v4.0.5.0168 Uninstall"                                  

; This sets the icon displayed in the Programs and Features" applet of the Control panel
; UninstallDisplayIcon={#SourceFileDir}\installer\{#MyAppIcon}                           


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
            

[Icons]
; Name: "{group}\{#MyAppName}";               Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; IconFilename: "{#MyAppIconName}"
; Name: "{group}\CSGI\{#MyAppName}";          Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; IconFilename: "{#MyAppIconName}"

; Name: "{commonprograms}\CSGI\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; IconFilename: "{#MyAppIconName}"
; Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{#MyAppIconName}"; Tasks: quicklaunchicon;

; Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "http://www.csgi.com/"
; Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "uninstall_{#MyAppExeName}"; IconFilename: "Uninstaller_icon_256x256.ico"

; Create the desktop shortcut to the app
; Name: "{userdesktop}\{#MyAppName}"; Filename: "{#MyAppExeName}"; WorkingDir: "{win}"; IconFilename: "{#MyAppIconName}"; Tasks: desktopicon
; Name: "{commondesktop}\{#MyAppName}";       Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; IconFilename: "{#MyAppIconName}"


[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

; Create the "Start ICABS4_5" checkbox on the last page of the installer.
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1


[Files]
Source: "D:\Flutter apps\flutter_codes\build\windows\x64\runner\Release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Flutter apps\flutter_codes\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files


[Code]
// ----------------  BEGIN Determine Platform bitness  --------------------------
// Inno Pascal functions for determining the processor type.
// you can use these to use (in an inno "check" parameter)
//   Source: "driver\ia64\libusb0.dll"; DestDir: {sys}; Flags: uninsneveruninstall replacesameversion restartreplace promptifolder; Check: IsI64;
//

function IsX64: Boolean;
begin
  Result := Is64BitInstallMode and (ProcessorArchitecture = paX64);
end;

function IsI64: Boolean;
begin
  Result := False; // IA64 (Itanium) is no longer supported
end;

function IsX86: Boolean;
begin
  Result := not IsX64 and not IsI64;
end;

function Is64: Boolean;
begin
  Result := IsX64 or IsI64;
end;
// ----------------  END  Determine Platform bitness  --------------------------

// ----------------  BEGIN Return the correct Registry Subkey  --------------------------
function GetRegAppKey(Param: String): String;
begin
  Result := 'SOFTWARE\FlutterCodes';
end;

function GetRegSubKey(Param: String): String;
begin
  Result := 'SOFTWARE\FlutterCodes\Settings';
end;
// ----------------  END  Return the correct Registry Subkey  --------------------------


// ----------------  BEGIN Return the correct Registry Subkey  --------------------------

// ----------------  END  Return the correct Registry Subkey  --------------------------


// ----------------  BEGIN Determine Java Version installed  --------------------------
function InitializeSetup(): Boolean;
var
  ErrorCode: Integer;
  JavaInstalled : Boolean;
  Result1 : Boolean;
  Versions: TArrayOfString;
  I: Integer;
  count: Integer;
  JavaMsg: String;
  sLineBreak: String;

begin

   // Get the set of installed Java runtimes
   // --------------------------------------
   JavaInstalled := FALSE;
   sLineBreak    := #13#10;
   
  if RegGetSubkeyNames(HKLM, 'SOFTWARE\JavaSoft\Java Runtime Environment', Versions) then
  begin
    // Java is installed on a 32 bit platform
    JavaInstalled := TRUE;
  end else
  begin

    if RegGetSubkeyNames(HKLM, 'SOFTWARE\Wow6432Node\JavaSoft\Java Runtime Environment', Versions) then
    begin
      // Java is installed on a 64 bit platform
      JavaInstalled := TRUE;
    end;

  end;

  if (JavaInstalled) then
  begin

    JavaInstalled := FALSE;

    // Get the set of installed Java runtimes
    // --------------------------------------
    count := GetArrayLength(Versions)-1;     // Remember that arrays in Pascal are zero-based, not 1-based.
    for I := 0 to count do

      if JavaInstalled = true then
      begin
        //do nothing
      end else
      begin
        if ( Versions[I][2]='.' ) and ( ( StrToInt(Versions[I][1]) > 1 ) or ( ( StrToInt(Versions[I][1]) = 1 ) and ( StrToInt(Versions[I][3]) >= 6 ) ) ) then
          begin
            JavaInstalled := true;
          end else
          begin
            JavaInstalled := false;
          end;
      end;

  end;


   
   if JavaInstalled then
   begin
      Result := true;
   end else
      begin
        JavaMsg :=  'A 32 bit version of Java v1.6u45 or higher must be installed. Do you wish to install Java at this time?' +
                    sLineBreak +
                    sLineBreak +
                    'Note that choosing to install Java will cause this installer to exit and your browser to display '  +  
                    'the Java Download site. Once you have installed the 32-bit version of Java version 1.6 or higher, ' +
                    'please re-run this installer.'
        Result1 := MsgBox(JavaMsg, mbConfirmation, MB_YESNO) = idYes;
        if Result1 = false then
        begin
          // User said NO to installing Java at this time; proceed with the CABS4_5 install
          Result:=TRUE;
        end else
        begin
          // Exit the installer
          Result:=false;

          // Open up the browser to the Java Download site
          ShellExec('open', 'http://www.java.com/getjava/',  '','',SW_SHOWNORMAL,ewNoWait,ErrorCode);
        end;

     end;
  end;

end.
// ----------------  End of Determine Java Version installed  --------------------------


[Registry]
; Tell Windows that a new EXE has been installed
; Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\\{#MyAppExeName}"; ValueType: string; ValueName: "Path"; ValueData: "{#MyAppPath}\{#MyAppExeName}"; Flags: createvalueifdoesntexist uninsdeletekey

; Create the top level Registry entry and all required subkeys
Root: HKLM; Subkey: {code:GetRegAppKey}; Flags: createvalueifdoesntexist  
Root: HKLM; Subkey: {code:GetRegAppKey}; ValueType: string; ValueName: "Company"; ValueData: "CSG International"; Flags: createvalueifdoesntexist
Root: HKLM; Subkey: {code:GetRegAppKey}; ValueType: string; ValueName: "HelpPath"; ValueData: "..\Help\"; Flags: createvalueifdoesntexist

Root: HKLM; Subkey: "{code:GetRegAppKey}\Applications"; Flags: createvalueifdoesntexist  
; Root: HKLM; Subkey: "{code:GetRegAppKey}\Applications"; ValueType: string; ValueName: {#MyAppExeName}; ValueData: "{#MyAppPath}\{#MyAppExeName}"; Flags: uninsdeletevalue  

Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "";                      ValueData: "";      Flags: createvalueifdoesntexist uninsdeletekey
Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "AutoCompanySelect";     ValueData: "N";     Flags: createvalueifdoesntexist
Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "AutoUpdateOn";          ValueData: "N";     Flags: createvalueifdoesntexist
Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "DEBUG_U_NV_SW_ORDER_USAGE_TOTALLING"; ValueData: "N"; Flags: createvalueifdoesntexist
Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "DebugLogFileLocation";  ValueData: "C:\";   Flags: createvalueifdoesntexist
Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "enableDBMessages";      ValueData: "FALSE"; Flags: createvalueifdoesntexist
Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "EnablePBDebugMessages"; ValueData: "FALSE"; Flags: createvalueifdoesntexist

Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "JavaExeFile"; ValueData: "C:\Program Files (x86)\Java\jre6\bin\java.exe"; Flags: createvalueifdoesntexist
; Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "JavaJarFile"; ValueData: "{#MyAppPath}\cabs4.jar;{#MyAppPath}\ojdbc6.jar"; Flags: createvalueifdoesntexist

Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "PlatformBitness"; ValueData: "32"; Flags: createvalueifdoesntexist; Check: IsX86
Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "PlatformBitness"; ValueData: "64"; Flags: createvalueifdoesntexist; Check: Is64  

Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "ProprietaryDuration"; ValueData: "1"; Flags: createvalueifdoesntexist
Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "ProprietaryFile";     ValueData: ""; Flags: createvalueifdoesntexist
; Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "ProprietaryPath";     ValueData: "{#MyAppPath}"; Flags: createvalueifdoesntexist

Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "SaveDataWhenAmountBilledIsZero"; ValueData: "N"; Flags: createvalueifdoesntexist
Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "SetSQLSpy";                      ValueData: "N"; Flags: createvalueifdoesntexist
Root: HKLM; Subkey: {code:GetRegSubKey}; ValueType: string; ValueName: "StaticBind";                     ValueData: "1"; Flags: createvalueifdoesntexist


[Run]
; There is no way to rename the uninstaller generated by Inno Setup within Inno. The best we can do is to rename it after it has been placed.
;Filename: {cmd}; Parameters: "RENAME "" {app}""\unins000.exe"" ""uninstall_iCABS4_5.exe"""; StatusMsg: Installing uninstaller for ICABS4_5...; Flags: RunHidden WaitUntilTerminated

; Give the user the option to run iCABS4_5 after the installation has completed.
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#MyAppName}}"; Flags: nowait postinstall skipifsilent



[UninstallDelete]
; The last step of the Uninstaller will be to delete the new ICABS4_5 folder
; Type: filesandordirs; Name: {#MyAppPath}
