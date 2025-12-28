# win-mediakey-lolbin

Una utilidad nativa de Windows ultra-ligera (~4KB) para controlar la reproducción multimedia (Play/Pause, Next, Prev) desde la línea de comandos.

---

## Contexto: LOLBin y MITRE ATT&CK

Este proyecto es también una prueba de concepto educativa sobre **LOLBins** (Living Off the Land Binaries).

Está documentado en MITRE ATT&CK como [T1027.004 "Compile After Delivery"](https://attack.mitre.org/techniques/T1027/004/), una técnica de evasión donde el código se entrega como texto plano y se compila in-situ con `csc.exe` (compilador del .NET Framework preinstalado en Windows).

En este caso, el uso es completamente legítimo: una utilidad de 4KB para controlar el reproductor de música.

---

## Qué hace

Compila un único ejecutable: `MediaKey.exe`

Soporta estos comandos:

- `MediaKey.exe playpause` → Play/Pause
- `MediaKey.exe next` → Siguiente pista
- `MediaKey.exe prev` → Pista anterior

Funciona en reproductores que respetan media keys (Spotify, YouTube en navegador, VLC, etc.).

---

## Requisitos

- Windows 10/11
- .NET Framework 4.x (para disponer de `csc.exe`)
  - Ruta típica (x64):
    - `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe`
  - Ruta típica (x86):
    - `C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe`

---

## Compilar

1) Clonar/descargar el repo.
2) Ejecutar:

```bat
.\compile.bat
````

El script:

* detecta `csc.exe` (Framework64 → Framework → PATH),
* crea `.\bin\`,
* compila como **winexe** (sin ventana de consola),
* y muestra el tamaño y el uso.

Ejemplo de salida:

```text
Compilando bin\MediaKey.exe...

OK: Compilacion exitosa.
Generado: "C:\Tools\win-mediakey-lolbin\bin\MediaKey.exe" (4096 bytes)

Uso:
   ...\bin\MediaKey.exe playpause
   ...\bin\MediaKey.exe next
   ...\bin\MediaKey.exe prev
```

---

## Uso

```bat
.\bin\MediaKey.exe playpause
.\bin\MediaKey.exe next
.\bin\MediaKey.exe prev
```

Ejemplo para Logitech Options+/G Hub (Ring Actions):

* Action 1: `C:\...\bin\MediaKey.exe playpause`
* Action 2: `C:\...\bin\MediaKey.exe next`
* Action 3: `C:\...\bin\MediaKey.exe prev`

---

## Cómo funciona

El programa llama a `user32.dll` y simula el evento de teclas multimedia con `keybd_event` usando los VK:

* `0xB3` → VK_MEDIA_PLAY_PAUSE
* `0xB0` → VK_MEDIA_NEXT_TRACK
* `0xB1` → VK_MEDIA_PREV_TRACK

Incluye pequeños `Sleep()` para evitar que el tap sea demasiado corto y para asegurar que Windows procese el evento antes de que termine el proceso.

---

## 📄 Licencia

Este proyecto es de dominio público. Siéntete libre de usarlo, modificarlo y aprender de él.
