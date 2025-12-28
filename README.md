# win-mediakey-lolbin

An ultra-lightweight Windows native utility (~4KB) to control media playback (Play/Pause, Next, Prev) from the command line.

---

## Context: LOLBin and MITRE ATT&CK

This project is also an educational proof of concept about **LOLBins** (Living Off the Land Binaries).

It is documented in MITRE ATT&CK as [T1027.004 "Compile After Delivery"](https://attack.mitre.org/techniques/T1027/004/), an evasion technique where code is delivered as plain text and compiled in-situ with `csc.exe` (the .NET Framework compiler pre-installed on Windows).

In this case, the usage is completely legitimate: a 4KB utility to control the music player.

---

## What it does

Compiles a single executable: `MediaKey.exe`

Supports these commands:

- `MediaKey.exe playpause` → Play/Pause
- `MediaKey.exe next` → Next track
- `MediaKey.exe prev` → Previous track

Works on players that respect media keys (Spotify, YouTube in browser, VLC, etc.).

---

## Requirements

- Windows 10/11
- .NET Framework 4.x (to have `csc.exe` available)
  - Typical path (x64):
    - `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe`
  - Typical path (x86):
    - `C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe`

---

## Compile

1) Clone/download the repo.
2) Run:

```bat
.\compile.bat
````

The script:

* detects `csc.exe` (Framework64 → Framework → PATH),
* creates `.\bin\`,
* compiles as **winexe** (without console window),
* and shows the size and usage.

Example output:

```text
Compiling bin\MediaKey.exe...

OK: Compilation successful.
Generated: "C:\Tools\win-mediakey-lolbin\bin\MediaKey.exe" (4096 bytes)

Usage:
   ...\bin\MediaKey.exe playpause
   ...\bin\MediaKey.exe next
   ...\bin\MediaKey.exe prev
```

---

## Usage

```bat
.\bin\MediaKey.exe playpause
.\bin\MediaKey.exe next
.\bin\MediaKey.exe prev
```

Example for Logitech Options+/G Hub (Ring Actions):

* Action 1: `C:\...\bin\MediaKey.exe playpause`
* Action 2: `C:\...\bin\MediaKey.exe next`
* Action 3: `C:\...\bin\MediaKey.exe prev`

---

## How it works

The program calls `user32.dll` and simulates the media key event with `keybd_event` using the VKs:

* `0xB3` → VK_MEDIA_PLAY_PAUSE
* `0xB0` → VK_MEDIA_NEXT_TRACK
* `0xB1` → VK_MEDIA_PREV_TRACK

It includes small `Sleep()` calls to prevent the tap from being too short and to ensure Windows processes the event before the process ends.

---

## 📄 License

This project is public domain. Feel free to use it, modify it, and learn from it.
