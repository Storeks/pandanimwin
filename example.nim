import windows, tlhelp32

proc main =
  var pe: PROCESSENTRY32
  pe.dwSize = sizeof(PROCESSENTRY32).DWORD
  let snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
  if Process32First(snapshot, pe.addr) >0 :
    while Process32Next(snapshot, pe.addr) >0 :
      echo pe.szExeFile

main()
