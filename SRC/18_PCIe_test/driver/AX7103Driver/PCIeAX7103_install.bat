cd %HOMEDRIVE%
wdreg -inf windrvr6.inf install
wdreg -inf PCIe_AX7103.inf install
copy wdapi1020.dll %WINDIR%\system32