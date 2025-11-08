if not exist bin (
    mkdir bin
)

%systemroot%\Microsoft.NET\Framework\v4.0.30319\jsc.exe ^
    /target:exe ^
    /debug+ ^
    /out:bin\HelloWorld.exe ^
    src\Program.js
