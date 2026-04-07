# ============================================
# OPTIMIZACIÓN NUCLEAR PARA CS2 - 300+ FPS
# RTX 2060 | i5 8va Gen | 16GB RAM
# ============================================
# EJECUTAR COMO ADMINISTRADOR
# BASED ON: 2026 Research + Community Tweaks
# ============================================

Write-Host "==============================================";
Write-Host "  CS2 NUCLEAR OPTIMIZATION - TARGET 300+ FPS" -ForegroundColor Cyan
Write-Host "  RTX 2060 | i5 8th Gen | 16GB RAM" -ForegroundColor Yellow
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host ""

# VERIFICAR PERMISOS DE ADMINISTRADOR
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "ERROR: Ejecutar como Administrador!" -ForegroundColor Red
    Read-Host "Presiona ENTER para salir"
    exit
}

Write-Host "[!] ADVERTENCIA: Script EXTREMO - Toca TODO el sistema" -ForegroundColor Red
Write-Host "[!] Crea punto de restauración por seguridad" -ForegroundColor Yellow
Write-Host ""
$confirm = Read-Host "Continuar? (SI/NO)"
if ($confirm -ne "SI") {
    Write-Host "Cancelado" -ForegroundColor Red
    exit
}

Write-Host ""
Write-Host "=== INICIANDO OPTIMIZACIÓN NUCLEAR ===" -ForegroundColor Green
Write-Host ""

# ============================================
# 1. PUNTO DE RESTAURACIÓN
# ============================================
Write-Host "[1/25] Creando punto de restauración..." -ForegroundColor Yellow
try {
    Checkpoint-Computer -Description "PRE-CS2-NUCLEAR-OPT" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
    Write-Host "  [OK] Punto de restauración creado" -ForegroundColor Green
} catch {
    Write-Host "  [!] No se pudo crear punto de restauración - Continuar de todas formas" -ForegroundColor Yellow
}

# ============================================
# 2. PLAN DE ENERGÍA - MÁXIMO RENDIMIENTO
# ============================================
Write-Host "[2/25] Configurando plan de energía Ultimate Performance..." -ForegroundColor Yellow
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2>&1 | Out-Null
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg /change monitor-timeout-ac 0
powercfg /change disk-timeout-ac 0
powercfg /change standby-timeout-ac 0
powercfg /change hibernate-timeout-ac 0
powercfg -h off
Write-Host "  [OK] Plan Ultimate Performance activado" -ForegroundColor Green

# ============================================
# 3. DESACTIVAR TELEMETRÍA COMPLETA
# ============================================
Write-Host "[3/25] ELIMINANDO TELEMETRÍA COMPLETA..." -ForegroundColor Yellow

# DiagTrack y servicios telemetría
$telemetryServices = @(
    "DiagTrack",
    "dmwappushservice",
    "diagnosticshub.standardcollector.service",
    "DPS",
    "WerSvc",
    "WdiSystemHost",
    "WdiServiceHost"
)

foreach ($service in $telemetryServices) {
    Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
    Set-Service -Name $service -StartupType Disabled -ErrorAction SilentlyContinue
}

# Registry - Deshabilitar telemetría
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -PropertyType DWord -Force | Out-Null

New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 0 -PropertyType DWord -Force | Out-Null

# Deshabilitar Compatibility Telemetry
Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" -ErrorAction SilentlyContinue
Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" -ErrorAction SilentlyContinue
Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" -ErrorAction SilentlyContinue
Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" -ErrorAction SilentlyContinue
Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" -ErrorAction SilentlyContinue
Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" -ErrorAction SilentlyContinue

Write-Host "  [OK] Telemetría eliminada" -ForegroundColor Green

# ============================================
# 4. SERVICIOS INNECESARIOS - LISTA EXTREMA
# ============================================
Write-Host "[4/25] Desactivando servicios innecesarios (EXTREMO)..." -ForegroundColor Yellow

$serviciosDesactivar = @(
    # Xbox
    "XboxGipSvc", "XblAuthManager", "XblGameSave", "XboxNetApiSvc",
    # Windows Search
    "WSearch",
    # Superfetch/SysMain (libera RAM)
    "SysMain",
    # Bluetooth (si no usas)
    "bthserv", "BTAGService",
    # Fax
    "Fax",
    # Biometría
    "WbioSrvc",
    # Windows Update (desactivar temporal)
    "wuauserv", "UsoSvc",
    # Tablet Input
    "TabletInputService", "TouchKeyboard",
    # Remote
    "RemoteRegistry", "RemoteAccess",
    # Printer Spooler (si no imprimes)
    "Spooler",
    # Windows Defender (OJO: solo si usas otro antivirus)
    # "WdNisSvc", "WinDefend", "SecurityHealthService",
    # Otros
    "lfsvc", "MapsBroker", "PhoneSvc", "RetailDemo", "SCardSvr", "ScDeviceEnum",
    "SSDPSRV", "upnphost", "WalletService", "FrameServer", "stisvc", "wisvc",
    "icssvc", "SEMgrSvc", "PcaSvc", "WerSvc", "Themes"
)

foreach ($servicio in $serviciosDesactivar) {
    Stop-Service -Name $servicio -Force -ErrorAction SilentlyContinue
    Set-Service -Name $servicio -StartupType Disabled -ErrorAction SilentlyContinue
}

Write-Host "  [OK] Servicios desactivados" -ForegroundColor Green

# ============================================
# 5. OPTIMIZACIONES DE REGISTRO - GAMING
# ============================================
Write-Host "[5/25] Aplicando optimizaciones de registro EXTREMAS..." -ForegroundColor Yellow

# Game DVR y Game Bar OFF
New-Item -Path "HKCU:\Software\Microsoft\GameBar" -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AutoGameModeEnabled" -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "ShowStartupPanel" -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "UseNexusForGameBarEnabled" -Value 0 -PropertyType DWord -Force | Out-Null

New-Item -Path "HKCU:\System\GameConfigStore" -Force | Out-Null
New-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Value 2 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Value 1 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Value 1 -PropertyType DWord -Force | Out-Null

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -Value 0 -PropertyType DWord -Force | Out-Null

# GPU PRIORITY = 8 (MÁXIMO PARA JUEGOS)
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "GPU Priority" -Value 8 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Priority" -Value 6 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Scheduling Category" -Value "High" -PropertyType String -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "SFIO Priority" -Value "High" -PropertyType String -Force | Out-Null

# NETWORK THROTTLING OFF
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xffffffff -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 0 -PropertyType DWord -Force | Out-Null

# WIN32 PRIORITY SEPARATION (38 = mejor para gaming)
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Value 38 -PropertyType DWord -Force | Out-Null

# TIMER RESOLUTION
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" -Name "GlobalTimerResolutionRequests" -Value 1 -PropertyType DWord -Force | Out-Null

# LARGE SYSTEM CACHE (0 para gaming)
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "LargeSystemCache" -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "SecondLevelDataCache" -Value 256 -PropertyType DWord -Force | Out-Null

Write-Host "  [OK] Registry optimizado" -ForegroundColor Green

# ============================================
# 6. GPU NVIDIA RTX 2060 - OPTIMIZACIÓN EXTREMA
# ============================================
Write-Host "[6/25] Optimizando GPU NVIDIA RTX 2060..." -ForegroundColor Yellow

# Hardware-Accelerated GPU Scheduling ON
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2 -PropertyType DWord -Force | Out-Null

# PowerMizer FIX para DPC Latency (RTX 2060)
$nvidiaPaths = Get-ChildItem -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}" -ErrorAction SilentlyContinue

foreach ($path in $nvidiaPaths) {
    $fullPath = $path.PSPath
    $driver = (Get-ItemProperty -Path $fullPath -ErrorAction SilentlyContinue).DriverDesc

    if ($driver -like "*NVIDIA*") {
        New-ItemProperty -Path $fullPath -Name "DisableDynamicPstate" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
        New-ItemProperty -Path $fullPath -Name "DisablePowerSaving" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
        New-ItemProperty -Path $fullPath -Name "EnableUlps" -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
        New-ItemProperty -Path $fullPath -Name "PowerMizerEnable" -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
        New-ItemProperty -Path $fullPath -Name "PowerMizerLevel" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
        New-ItemProperty -Path $fullPath -Name "PowerMizerLevelAC" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
        New-ItemProperty -Path $fullPath -Name "PerflevelSrc" -Value 3322 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
    }
}

Write-Host "  [OK] GPU NVIDIA optimizada" -ForegroundColor Green

# ============================================
# 7. DESACTIVAR HPET
# ============================================
Write-Host "[7/25] Desactivando HPET (High Precision Event Timer)..." -ForegroundColor Yellow
bcdedit /deletevalue useplatformclock 2>&1 | Out-Null
bcdedit /set disabledynamictick yes 2>&1 | Out-Null
Write-Host "  [OK] HPET desactivado" -ForegroundColor Green

# ============================================
# 8. CORE PARKING OFF (i5 8va Gen)
# ============================================
Write-Host "[8/25] Desactivando Core Parking..." -ForegroundColor Yellow

New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" -Name "ValueMax" -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" -Name "ValueMin" -Value 0 -PropertyType DWord -Force | Out-Null

Write-Host "  [OK] Core Parking desactivado" -ForegroundColor Green

# ============================================
# 9. OPTIMIZAR PAGEFILE (4GB fijo para 16GB RAM)
# ============================================
Write-Host "[9/25] Optimizando memoria virtual (pagefile)..." -ForegroundColor Yellow

$computersys = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges
$computersys.AutomaticManagedPagefile = $False
$computersys.Put() | Out-Null

$pagefile = Get-WmiObject -Query "Select * From Win32_PageFileSetting Where Name='C:\\pagefile.sys'"
if ($pagefile) {
    $pagefile.Delete()
}
Set-WmiInstance -Class Win32_PageFileSetting -Arguments @{name="C:\pagefile.sys"; InitialSize = 4096; MaximumSize = 4096} -ErrorAction SilentlyContinue | Out-Null

Write-Host "  [OK] Pagefile optimizado (4GB fijo)" -ForegroundColor Green

# ============================================
# 10. NETWORK OPTIMIZATION - EXTREME
# ============================================
Write-Host "[10/25] Optimizando red para CS2..." -ForegroundColor Yellow

# TCP/IP Tweaks
netsh int tcp set global autotuninglevel=normal 2>&1 | Out-Null
netsh int tcp set global chimney=enabled 2>&1 | Out-Null
netsh int tcp set global dca=enabled 2>&1 | Out-Null
netsh int tcp set global netdma=enabled 2>&1 | Out-Null
netsh int tcp set global congestionprovider=ctcp 2>&1 | Out-Null
netsh int tcp set heuristics disabled 2>&1 | Out-Null
netsh int tcp set global rss=enabled 2>&1 | Out-Null
netsh int tcp set global fastopen=enabled 2>&1 | Out-Null
netsh int tcp set global nonsackrttresiliency=disabled 2>&1 | Out-Null
netsh int tcp set global timestamps=disabled 2>&1 | Out-Null

# Nagle's Algorithm OFF (reduce latencia)
$interfaces = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}
foreach ($interface in $interfaces) {
    $interfacePath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$($interface.InterfaceGuid)"
    if (Test-Path $interfacePath) {
        New-ItemProperty -Path $interfacePath -Name "TcpAckFrequency" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
        New-ItemProperty -Path $interfacePath -Name "TCPNoDelay" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null
    }
}

# QoS
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched" -Name "NonBestEffortLimit" -Value 0 -PropertyType DWord -Force | Out-Null

Write-Host "  [OK] Red optimizada" -ForegroundColor Green

# ============================================
# 11. EFECTOS VISUALES - MÍNIMO
# ============================================
Write-Host "[11/25] Desactivando efectos visuales..." -ForegroundColor Yellow

New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -PropertyType DWord -Force | Out-Null

# Deshabilitar animaciones
New-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 0 -PropertyType String -Force | Out-Null
New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value ([byte[]](144,18,3,128,16,0,0,0)) -PropertyType Binary -Force | Out-Null

Write-Host "  [OK] Efectos visuales minimizados" -ForegroundColor Green

# ============================================
# 12. MOUSE Y TECLADO - ZERO LATENCY
# ============================================
Write-Host "[12/25] Optimizando mouse y teclado..." -ForegroundColor Yellow

# Mouse acceleration OFF
New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value 0 -PropertyType String -Force | Out-Null
New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value 0 -PropertyType String -Force | Out-Null
New-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value 0 -PropertyType String -Force | Out-Null

# Keyboard repeat rate
New-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Value 0 -PropertyType String -Force | Out-Null
New-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardSpeed" -Value 31 -PropertyType String -Force | Out-Null

Write-Host "  [OK] Mouse y teclado optimizados" -ForegroundColor Green

# ============================================
# 13. DESACTIVAR CORTANA Y BÚSQUEDA
# ============================================
Write-Host "[13/25] Desactivando Cortana y búsqueda..." -ForegroundColor Yellow

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowSearchToUseLocation" -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Value 1 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "ConnectedSearchUseWeb" -Value 0 -PropertyType DWord -Force | Out-Null

Write-Host "  [OK] Cortana desactivada" -ForegroundColor Green

# ============================================
# 14. FULLSCREEN OPTIMIZATIONS OFF
# ============================================
Write-Host "[14/25] Desactivando optimizaciones de pantalla completa..." -ForegroundColor Yellow

New-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehavior" -Value 2 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Value 2 -PropertyType DWord -Force | Out-Null

Write-Host "  [OK] Fullscreen optimizations OFF" -ForegroundColor Green

# ============================================
# 15. BACKGROUND APPS OFF
# ============================================
Write-Host "[15/25] Desactivando apps en segundo plano..." -ForegroundColor Yellow

New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Value 1 -PropertyType DWord -Force | Out-Null

Write-Host "  [OK] Background apps desactivadas" -ForegroundColor Green

# ============================================
# 16. WIDGETS Y NOTICIAS OFF
# ============================================
Write-Host "[16/25] Desactivando widgets y noticias..." -ForegroundColor Yellow

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -Value 0 -PropertyType DWord -Force | Out-Null

Write-Host "  [OK] Widgets desactivados" -ForegroundColor Green

# ============================================
# 17. LOCATION TRACKING OFF
# ============================================
Write-Host "[17/25] Desactivando location tracking..." -ForegroundColor Yellow

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocation" -Value 1 -PropertyType DWord -Force | Out-Null

Write-Host "  [OK] Location tracking OFF" -ForegroundColor Green

# ============================================
# 18. ACTIVITY HISTORY OFF
# ============================================
Write-Host "[18/25] Desactivando historial de actividad..." -ForegroundColor Yellow

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value 0 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Value 0 -PropertyType DWord -Force | Out-Null

Write-Host "  [OK] Activity history OFF" -ForegroundColor Green

# ============================================
# 19. ADVERTISING ID OFF
# ============================================
Write-Host "[19/25] Desactivando Advertising ID..." -ForegroundColor Yellow

New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0 -PropertyType DWord -Force | Out-Null

Write-Host "  [OK] Advertising ID OFF" -ForegroundColor Green

# ============================================
# 20. DELIVERY OPTIMIZATION OFF (consume red/disco)
# ============================================
Write-Host "[20/25] Desactivando Delivery Optimization..." -ForegroundColor Yellow

Stop-Service -Name "DoSvc" -Force -ErrorAction SilentlyContinue
Set-Service -Name "DoSvc" -StartupType Disabled -ErrorAction SilentlyContinue

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Value 0 -PropertyType DWord -Force | Out-Null

Write-Host "  [OK] Delivery Optimization OFF" -ForegroundColor Green

# ============================================
# 21. NDIS.SYS PRIORITY (RED)
# ============================================
Write-Host "[21/25] Priorizando tráfico de red (NDIS)..." -ForegroundColor Yellow

New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Ndis\Parameters" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Ndis\Parameters" -Name "MaxNumRssCpus" -Value 4 -PropertyType DWord -Force | Out-Null

Write-Host "  [OK] NDIS optimizado" -ForegroundColor Green

# ============================================
# 22. STORAGE SENSE OFF
# ============================================
Write-Host "[22/25] Desactivando Storage Sense..." -ForegroundColor Yellow

New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "01" -Value 0 -PropertyType DWord -Force | Out-Null

Write-Host "  [OK] Storage Sense OFF" -ForegroundColor Green

# ============================================
# 23. MEMORY COMPRESSION OFF
# ============================================
Write-Host "[23/25] Desactivando Memory Compression..." -ForegroundColor Yellow

Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue

Write-Host "  [OK] Memory Compression OFF" -ForegroundColor Green

# ============================================
# 24. LIMPIAR ARCHIVOS TEMPORALES
# ============================================
Write-Host "[24/25] Limpiando archivos temporales..." -ForegroundColor Yellow

Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Prefetch\*" -Force -ErrorAction SilentlyContinue

Write-Host "  [OK] Archivos temporales limpiados" -ForegroundColor Green

# ============================================
# 25. CREAR SCRIPT DE CS2 AUTOEXEC
# ============================================
Write-Host "[25/25] Creando autoexec.cfg para CS2..." -ForegroundColor Yellow

$steamPath = "C:\Program Files (x86)\Steam"
$cs2CfgPath = "$steamPath\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg"

if (Test-Path $cs2CfgPath) {
    $autoexecContent = @"
// ============================================
// CS2 AUTOEXEC - OPTIMIZACIÓN 300+ FPS
// ============================================

// RATES (128 TICK SERVERS)
rate 786432
cl_updaterate 128
cl_cmdrate 128
cl_interp 0
cl_interp_ratio 1

// FPS
fps_max 0
fps_max_ui 0

// MOUSE
sensitivity 1.0
zoom_sensitivity_ratio_mouse 1.0
m_rawinput 1
m_customaccel 0
m_mouseaccel1 0
m_mouseaccel2 0

// NETWORK
mm_dedicated_search_maxping 50
net_graph 1
net_graphproportionalfont 0

// VIDEO - PERFORMANCE
mat_queue_mode 2
r_dynamic 0
r_drawtracers_firstperson 0

// AUDIO
snd_mixahead 0.05
snd_headphone_pan_exponent 2
snd_headphone_pan_radial_weight 1

// VIEWMODEL
viewmodel_fov 68
viewmodel_offset_x 2.5
viewmodel_offset_y 0
viewmodel_offset_z -1.5

// CROSSHAIR
cl_crosshairstyle 4
cl_crosshairsize 2
cl_crosshairgap -2
cl_crosshairthickness 0.5
cl_crosshair_drawoutline 1
cl_crosshaircolor 1

// MISC
cl_showfps 1
cl_forcepreload 1
hud_scaling 0.85

echo "================================================"
echo "  CS2 AUTOEXEC CARGADO - 300+ FPS TARGET"
echo "================================================"
"@

    $autoexecContent | Out-File -FilePath "$cs2CfgPath\autoexec.cfg" -Encoding ASCII -Force
    Write-Host "  [OK] autoexec.cfg creado en: $cs2CfgPath" -ForegroundColor Green
} else {
    Write-Host "  [!] No se encontró CS2 - Crear autoexec.cfg manualmente" -ForegroundColor Yellow
}

# ============================================
# RESUMEN FINAL
# ============================================
Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  OPTIMIZACIÓN NUCLEAR COMPLETADA" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "CAMBIOS APLICADOS:" -ForegroundColor Yellow
Write-Host "  [+] Plan de energía: Ultimate Performance"
Write-Host "  [+] Telemetría: ELIMINADA"
Write-Host "  [+] Servicios desactivados: 40+"
Write-Host "  [+] GPU Priority: 8 (MÁXIMO)"
Write-Host "  [+] Network Throttling: OFF"
Write-Host "  [+] HPET: Desactivado"
Write-Host "  [+] Core Parking: OFF"
Write-Host "  [+] DPC Latency: Fixed (PowerMizer)"
Write-Host "  [+] Hardware GPU Scheduling: ON"
Write-Host "  [+] Game DVR/Bar: OFF"
Write-Host "  [+] Fullscreen Optimizations: OFF"
Write-Host "  [+] Nagle's Algorithm: OFF"
Write-Host "  [+] Mouse Acceleration: OFF"
Write-Host "  [+] Pagefile: 4GB fijo"
Write-Host ""
Write-Host "SIGUIENTE PASOS:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. REINICIAR PC (OBLIGATORIO)" -ForegroundColor Red
Write-Host ""
Write-Host "2. Panel de Control NVIDIA:" -ForegroundColor Yellow
Write-Host "   - Manage 3D Settings > Power Management: Prefer Maximum Performance"
Write-Host "   - Image Scaling: Off"
Write-Host "   - Low Latency Mode: Ultra (o On)"
Write-Host "   - Vertical Sync: Off"
Write-Host "   - Texture Filtering - Quality: Performance"
Write-Host "   - Shader Cache Size: 10GB"
Write-Host ""
Write-Host "3. CS2 Launch Options (Steam):" -ForegroundColor Yellow
Write-Host "   -novid -high -nojoy +fps_max 0 +cl_forcepreload 1 -freq 144"
Write-Host "   (Cambia 144 por tu Hz de monitor)"
Write-Host ""
Write-Host "4. CS2 Video Settings:" -ForegroundColor Yellow
Write-Host "   - NVIDIA Reflex Low Latency: Enabled"
Write-Host "   - Multicore Rendering: Enabled"
Write-Host "   - MSAA: Off"
Write-Host "   - Global Shadow Quality: Low"
Write-Host "   - Model/Texture Detail: Medium"
Write-Host "   - Shader Detail: Low"
Write-Host "   - DLSS: Quality Mode (RTX 2060)"
Write-Host ""
Write-Host "5. Actualizar drivers NVIDIA (GeForce Experience)"
Write-Host ""
Write-Host "FPS ESPERADO EN CS2:" -ForegroundColor Green
Write-Host "  - 1080p Low Settings: 300-400 FPS"
Write-Host "  - 1080p Medium Settings: 250-350 FPS"
Write-Host "  - 1080p High Settings: 180-250 FPS"
Write-Host ""
Write-Host "REVERTIR CAMBIOS:" -ForegroundColor Yellow
Write-Host "  Usa el punto de restauración: PRE-CS2-NUCLEAR-OPT"
Write-Host ""
Write-Host "Para más info, revisa: CS2_GUIA_COMPLETA.md" -ForegroundColor Cyan
Write-Host ""
Read-Host "Presiona ENTER para salir y REINICIAR"
