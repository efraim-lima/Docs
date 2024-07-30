# Monitor CPU usage
$cpuUsage = (Get-Counter -Counter "Processor(_Total)\% Processor Time" -SampleInterval 5 -MaxSamples 1).CounterSamples.CookedValue

# Monitor RAM usage
$ramUsage = (Get-Counter -Counter "Memory\Committed Bytes" -SampleInterval 5 -MaxSamples 1).CounterSamples.CookedValue / 1GB

# Monitor cache usage
$cacheUsage = (Get-Counter -Counter "Memory\Cache Bytes" -SampleInterval 5 -MaxSamples 1).CounterSamples.CookedValue / 1GB

# Set thresholds for alerting
$cpuThreshold = 80
$ramThreshold = 80
$cacheThreshold = 80

# Check if thresholds are exceeded
if ($cpuUsage -gt $cpuThreshold -or $ramUsage -gt $ramThreshold -or $cacheUsage -gt $cacheThreshold) {
    # Send alert
    Write-Host "Alert: CPU usage is $cpuUsage%, RAM usage is $ramUsage GB, Cache usage is $cacheUsage GB" -ForegroundColor Red

    # Create log
    $logMessage = "CPU usage is $cpuUsage%, RAM usage is $ramUsage GB, Cache usage is $cacheUsage GB"
    Add-Content -Path "C:\logs\performance.log" -Value $logMessage

    # Clear cache, RAM, and more to save memory
    # Use the MemPlus tool to clear cache and RAM
    & "C:\Program Files\MemPlus\MemPlus.exe" -clearcache -clearram

    # Use the EmptyWorkingSet function to clear working sets of all processes
    Add-Type -MemberDefinition '[DllImport("psapi.dll")] public static extern int EmptyWorkingSet(IntPtr hwProc);' -Name 'Win32' -Namespace 'Win32'
    $processes = Get-Process
    foreach ($process in $processes) {
        $handle = $process.Handle
        [Win32]::EmptyWorkingSet($handle) | Out-Null
    }
}
