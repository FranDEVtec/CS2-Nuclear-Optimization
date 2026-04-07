# ⚡ CS2 - COMANDOS RÁPIDOS Y ATAJOS

## 🚀 EJECUCIÓN ULTRA RÁPIDA (3 PASOS)

```powershell
# 1. PowerShell como Admin
Set-ExecutionPolicy Bypass -Scope Process -Force; C:\CS2_OPTIMIZACION_NUCLEAR.ps1

# 2. Escribir "SI" y esperar → REINICIAR

# 3. Steam Launch Options:
-novid -high -nojoy +fps_max 0 +cl_forcepreload 1 -freq 144 -threads 6
```

---

## 🎮 LAUNCH OPTIONS (Copiar/Pegar)

### Estándar (RECOMENDADO):
```bash
-novid -high -nojoy +fps_max 0 +cl_forcepreload 1 -freq 144 -threads 6
```

### Si tienes microstutters:
```bash
-novid -high -nojoy +fps_max 300 +cl_forcepreload 1 -freq 144 -threads 6
```

### Competitivo 128 tick:
```bash
-novid -high -nojoy +fps_max 0 +cl_forcepreload 1 -freq 144 -threads 6 +rate 786432 +cl_interp 0
```

### Laptop (ahorro energía):
```bash
-novid -high -nojoy +fps_max 300 +cl_forcepreload 1 -freq 60 -threads 4 -nod3d9ex
```

**CAMBIAR:**
- `-freq 144` → Tu Hz de monitor (60/75/144/165/240)
- `-threads 6` → Núcleos de tu CPU (i5 8va = 6)

---

## 📍 UBICACIÓN AUTOEXEC.CFG

```
C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg\autoexec.cfg
```

**Ejecutar en consola CS2:**
```
exec autoexec
```

---

## 🎯 NVIDIA PANEL - SETTINGS CRÍTICOS

**Panel de Control NVIDIA → Manage 3D Settings → Counter-Strike 2:**

```
Power Management Mode          = Prefer Maximum Performance
Low Latency Mode               = Ultra
Vertical Sync                  = Off
Texture Filtering - Quality    = Performance
```

**Global Settings:**
```
Threaded Optimization          = On
```

---

## 🎮 CS2 VIDEO SETTINGS (Crítico)

```
NVIDIA DLSS                    = Quality Mode  ← CRÍTICO RTX 2060
NVIDIA Reflex Low Latency      = Enabled
Multicore Rendering            = Enabled
MSAA                           = None
Global Shadow Quality          = Low
Model/Texture Detail           = Medium
Shader Detail                  = Low
Wait for Vertical Sync         = Disabled
```

---

## 📊 VERIFICAR OPTIMIZACIÓN

### En CS2 (Consola):

```
net_graph 1           # Ver FPS, ping, loss
cl_showfps 2          # FPS detallado
fps_max 0             # Sin límite FPS
mat_info              # Info GPU
r_speeds 1            # Render stats
```

### PowerShell (Como Admin):

```powershell
# Ver plan de energía activo
powercfg /list

# Ver servicios desactivados
Get-Service | Where-Object {$_.Status -eq "Stopped"} | Select Name

# Ver GPU en uso
Get-WmiObject Win32_VideoController | Select Name, DriverVersion

# Verificar pagefile
Get-WmiObject Win32_PageFileSetting | Select Name, InitialSize, MaximumSize
```

---

## 🔥 COMANDOS ÚTILES CS2

### FPS y Performance:
```
fps_max 0                     # Sin límite
fps_max 300                   # Limitar a 300
cl_showfps 1                  # Mostrar FPS simple
cl_showfps 2                  # Mostrar FPS avanzado
net_graph 1                   # Info red + FPS
mat_queue_mode 2              # Multi-threaded
r_dynamic 0                   # Luces dinámicas OFF
```

### Network:
```
rate 786432                   # Max bandwidth
cl_updaterate 128             # Updates/segundo
cl_cmdrate 128                # Comandos/segundo
cl_interp 0                   # Interpolación min
cl_interp_ratio 1             # Ratio óptimo
mm_dedicated_search_maxping 50  # Max ping MM
```

### Practice:
```
sv_cheats 1                   # Activar cheats
sv_infinite_ammo 1            # Munición infinita
sv_grenade_trajectory 1       # Ver trayectoria nades
sv_showimpacts 1              # Ver impactos balas
mp_warmup_end                 # Terminar warmup
mp_restartgame 1              # Reiniciar partida
noclip                        # Volar (práctica)
bot_kick                      # Expulsar bots
```

---

## 🛠️ TROUBLESHOOTING RÁPIDO

### FPS BAJO:

```powershell
# 1. Verificar GPU en uso
Get-WmiObject Win32_VideoController

# 2. Forzar plan de energía
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61

# 3. Limpiar cache shader
# Ir a: C:\Users\[USER]\AppData\Local\NVIDIA\GLCache
# Borrar todo
```

### LATENCIA ALTA:

```powershell
# 1. Reset network stack
netsh int ip reset
netsh winsock reset
ipconfig /flushdns

# 2. Test ping
ping 8.8.8.8 -t

# 3. Verificar Nagle OFF (debe dar error = está desactivado)
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\*" -Name TcpAckFrequency
```

### MICROSTUTTERS:

1. Cerrar Discord overlay
2. Cerrar software RGB (iCUE, Aura)
3. En autoexec: cambiar `fps_max 0` → `fps_max 300`
4. Limpiar shader cache NVIDIA
5. Verificar temperaturas (<80°C GPU)

---

## 🔙 REVERTIR TODO

### Punto de Restauración:
```
Windows + R → rstrui.exe
Seleccionar: "PRE-CS2-NUCLEAR-OPT"
```

### Reactivar Windows Update:
```powershell
Set-Service wuauserv -StartupType Automatic
Start-Service wuauserv
```

### Reactivar Windows Search:
```powershell
Set-Service WSearch -StartupType Automatic
Start-Service WSearch
```

---

## 📈 BENCHMARKS

### Test FPS:
1. **Workshop Map:** "FPS Benchmark"
2. **Deathmatch:** 10 minutos en Dust2
3. **Competitive:** Anota FPS promedio

### Herramientas:
- **LatencyMon:** Medir DPC latency
- **MSI Afterburner:** Monitorear GPU
- **HWiNFO64:** Temperaturas completas
- **net_graph 1:** En CS2 para ping/FPS

---

## 🎯 TARGETS (RTX 2060 + i5 8va)

```
1080p Low:     350-450 FPS
1080p Medium:  280-350 FPS
1080p High:    200-280 FPS

Input Lag:     12-18ms
DPC Latency:   <100μs
Network Ping:  +0-2ms overhead
```

---

## 📞 SOPORTE RÁPIDO

**Reddit:**
- r/GlobalOffensive
- r/CounterStrikeBinds
- r/nvidia

**Discord:**
- LinusTechTips
- Hardware Unboxed

**Foros:**
- Tom's Hardware
- Overclock.net

---

## ✅ CHECKLIST EXPRESS

Pre-Gaming:
- [ ] Cerrar Chrome/Discord/RGB software
- [ ] GPU <40°C idle, <80°C gaming
- [ ] `net_graph 1` para monitorear
- [ ] Cable conectado a GPU (no motherboard)
- [ ] Drivers NVIDIA actualizados
- [ ] DLSS en Quality Mode

Post-Gaming:
- [ ] Reactivar Windows Update (mensualmente)
- [ ] Cerrar CS2 completamente
- [ ] Verificar temperaturas máximas (<85°C)

---

## 🔥 OVERCLOCKING SEGURO (MSI Afterburner)

**RTX 2060 Safe:**
```
Core Clock:    +100 MHz
Memory Clock:  +500 MHz
Power Limit:   110%
Temp Limit:    83°C
Fan Curve:     70% @ 70°C
```

**Test Stability:**
1. FurMark 15 min
2. 3DMark Time Spy
3. CS2 2 horas

**Si crashea:** Reduce -25 MHz cada vez

---

## 💾 BACKUP & SEGURIDAD

```powershell
# Crear punto de restauración manual
Checkpoint-Computer -Description "Mi Backup" -RestorePointType "MODIFY_SETTINGS"

# Ver puntos disponibles
Get-ComputerRestorePoint

# Restaurar (GUI)
rstrui.exe
```

---

**Target: 300+ FPS | Input Lag <15ms | Zero Stutters**

*Good luck! 🎯*
