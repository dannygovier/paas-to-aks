
[CmdletBinding()]
param (
    # Sitecore Topology
    [Parameter(Mandatory)]
    [ValidateSet('xm1', 'xp1')]
    [string]
    $Topology, 

    # Path to tls secrets folder
    [Parameter()]
    [string]
    $Path = "..\sitecore\k8s\$Topology\secrets\tls"
)

$ErrorActionPreference = 'Stop'

if (!(Get-Command mkcert.exe)) {
    Invoke-WebRequest https://github.com/FiloSottile/mkcert/releases/download/v1.4.1/mkcert-v1.4.1-windows-amd64.exe -UseBasicParsing -OutFile mkcert.exe
}

mkcert -install

$certificatePath = Resolve-Path $Path

$cmCrtPath = Join-Path $certificatePath "global-cm\tls.crt"
$cmKeyPath = Join-Path $certificatePath "global-cm\tls.key"
mkcert -cert-file $cmCrtPath -key-file $cmKeyPath "cm.globalhost"

$cdCrtPath = Join-Path $certificatePath "global-cd\tls.crt"
$cdKeyPath = Join-Path $certificatePath "global-cd\tls.key"
mkcert -cert-file $cdCrtPath -key-file $cdKeyPath "cd.globalhost"

$idCrtPath = Join-Path $certificatePath "global-id\tls.crt"
$idKeyPath = Join-Path $certificatePath "global-id\tls.key"
mkcert -cert-file $idCrtPath -key-file $idKeyPath "id.globalhost"

Remove-Item .\mkcert.exe -ErrorAction SilentlyContinue