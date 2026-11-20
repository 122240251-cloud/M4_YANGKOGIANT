@echo off
set PORT=8080
echo ========================================================
echo   Yangko Giant Web Local Server (http://localhost:%PORT%)
echo   Tekan Ctrl+C di jendela ini untuk mematikan server.
echo ========================================================
powershell -NoProfile -ExecutionPolicy Bypass -Command "$port = %PORT%; $listener = New-Object System.Net.HttpListener; $listener.Prefixes.Add('http://localhost:' + $port + '/'); $listener.Start(); Write-Host 'Server berjalan di http://localhost:' $port; Start-Process ('http://localhost:' + $port); while ($listener.IsListening) { $context = $listener.GetContext(); $req = $context.Request; $res = $context.Response; $path = Join-Path '%~dp0' ($req.Url.LocalPath.TrimStart('/')); if (-not (Test-Path $path) -or (Get-Item $path).PSIsContainer) { $path = Join-Path '%~dp0' 'index.html' }; if (Test-Path $path) { $bytes = [System.IO.File]::ReadAllBytes($path); $ext = [System.IO.Path]::GetExtension($path).ToLower(); $mime = switch ($ext) { '.html' {'text/html'} '.css' {'text/css'} '.js' {'application/javascript'} '.png' {'image/png'} '.jpg' {'image/jpeg'} '.jpeg' {'image/jpeg'} '.webp' {'image/webp'} '.svg' {'image/svg+xml'} default {'application/octet-stream'} }; $res.ContentType = $mime; $res.ContentLength64 = $bytes.Length; $res.OutputStream.Write($bytes, 0, $bytes.Length) } else { $res.StatusCode = 404 }; $res.Close() }"
pause
