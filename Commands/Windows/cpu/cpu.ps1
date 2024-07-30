$threshold=80

function Send-Alert {
	param($msg)

	Write-Host "ALERT: $msg"
	
	# Enviar a notificação para o sistema
	[System.Windows.Forms.MessageBox]::Show("ALERT: $msg", "System Alert")

	# Criar Log de Sistema
	Write-EventLog -LogName Application -Source "CPUMemMonitor" -EventID 1 -EntryType Warning -Message $msg

	# limpar cache
	$null = (New-Object System.IO.StreamWritter("null")).Close()
	Invoke-Expression "sync"


	}
