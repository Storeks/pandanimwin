#tlhelp32 port for nim

import windows

#Tool Help Constants
const
  MAX_MODULE_NAME32* = 255
  TH32CS_INHERIT* = 0x80000000
  TH32CS_SNAPHEAPLIST* = 0x00000001
  TH32CS_SNAPMODULE* = 0x00000008
  TH32CS_SNAPMODULE32* = 0x00000010
  TH32CS_SNAPPROCESS* = 0x00000002
  TH32CS_SNAPTHREAD* = 0x00000004
  TH32CS_SNAPALL* = TH32CS_SNAPHEAPLIST or TH32CS_SNAPMODULE or TH32CS_SNAPPROCESS or TH32CS_SNAPTHREAD

#Tool Help Structures
type
  
  HEAPENTRY32* = object
    dwSize*: SIZE_T
    hHandle*: HANDLE
    dwAddress*: ULONG_PTR
    dwBlockSize*: SIZE_T
    dwFlags*: DWORD
    dwLockCount*: DWORD
    dwResvd*: DWORD
    th32ProcessID*: DWORD
    th32HeapID*: ULONG_PTR

  PHEAPENTRY32* = ptr HEAPENTRY32
  LPHEAPENTRY32* = ptr HEAPENTRY32

  HEAPLIST32* = object
    dwSize*: SIZE_T
    th32ProcessID*: DWORD
    th32HeapID*: ULONG_PTR
    dwFlags*: DWORD

  PHEAPLIST32* = ptr HEAPLIST32
  LPHEAPLIST32* = ptr HEAPLIST32

  MODULEENTRY32* = object
    dwSize*: DWORD
    th32ModuleID*: DWORD
    th32ProcessID*: DWORD
    GlblcntUsage*: DWORD
    ProccntUsage*: DWORD
    modBaseAddr*: ptr BYTE
    modBaseSize*: DWORD
    hModule*: HMODULE
    szModule*: array[MAX_MODULE_NAME32 + 1, WCHAR]
    szExePath*: array[MAX_PATH, WCHAR]

  PMODULEENTRY32* = ptr MODULEENTRY32
  LPMODULEENTRY32* = ptr MODULEENTRY32

  PROCESSENTRY32* = object
    dwSize*: DWORD
    cntUsage*: DWORD
    th32ProcessID*: DWORD
    th32DefaultHeapID*: ULONG_PTR
    th32ModuleID*: DWORD
    cntThreads*: DWORD
    th32ParentProcessID*: DWORD
    pcPriClassBase*: LONG
    dwFlags*: DWORD
    szExeFileName*: array[MAX_PATH, WCHAR]

  PPROCESSENTRY32* = ptr PROCESSENTRY32
  LPPROCESSENTRY32* = ptr PROCESSENTRY32

  THREADENTRY32* = object
    dwSize*: DWORD
    cntUsage*: DWORD
    th32ThreadID*: DWORD
    th32OwnerProcessID*: DWORD
    tpBasePri*: LONG
    tpDeltaPri*: LONG
    dwFlags*: DWORD

  PTHREADENTRY32* = ptr THREADENTRY32
  LPTHREADENTRY32* = ptr THREADENTRY32

#Toolhelp Funtions
proc CreateToolhelp32Snapshot*(dwFlags, th32ProcessID: DWORD): HANDLE
  {.stdcall, dynlib: "kernel32", importc: "CreateToolhelp32Snapshot".}

proc Heap32First*(lphe: LPHEAPENTRY32, th32ProcessID: DWORD, th32HeapID: ULONG_PTR): BOOL
  {.stdcall, dynlib: "kernel32", importc: "Heap32First".}

proc Heap32ListFirst*(hSnapshot: HANDLE, lphl: LPHEAPLIST32): BOOL
  {.stdcall, dynlib: "kernel32", importc: "Heap32ListFirst".}

proc Heap32ListNext*(hSnapshot: HANDLE, lphl: LPHEAPLIST32): BOOL
  {.stdcall, dynlib: "kernel32", importc: "Heap32ListNext".}

proc Heap32Next*(lphe: LPHEAPENTRY32): BOOL
  {.stdcall, dynlib: "kernel32", importc: "Heap32Next".}

proc Module32First*(hSnapshot: HANDLE, lpme: LPMODULEENTRY32): BOOL
  {.stdcall, dynlib: "kernel32", importc: "Module32First".}

proc Module32Next*(hSnapshot: HANDLE, lpme: LPMODULEENTRY32): BOOL
  {.stdcall, dynlib: "kernel32", importc: "Module32Next"}

proc Process32First*(hSnapshot: HANDLE, lppe: LPPROCESSENTRY32): BOOL
  {.stdcall, dynlib: "kernel32", importc: "Process32First".}

proc Process32Next*(hSnapshot: HANDLE, lppe: LPPROCESSENTRY32): BOOL
  {.stdcall, dynlib: "kernel32", importc: "Process32Next"}

proc Thread32First*(hSnapshot: HANDLE, lpte: LPTHREADENTRY32): BOOL
  {.stdcall, dynlib: "kernel32", importc: "Thread32First".}

proc Thread32Next*(hSnapshot: HANDLE, lpte: LPTHREADENTRY32): BOOL
  {.stdcall, dynlib: "kernel32", importc: "Thread32Next"}
