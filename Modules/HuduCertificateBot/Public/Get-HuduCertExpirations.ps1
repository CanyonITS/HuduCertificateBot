function Get-HuduCertExpirations {
    if (Initialize-HuduApi) {
        $Layout = Get-HuduAssetLayouts -Name $env:HuduSSLCertAssetLayoutName
        $Assets = Get-HuduAssets -AssetLayoutId $Layout.id

        foreach ($Asset in $Assets) {
            $Expiry = ($Asset.fields | Where-Object { $_.label -eq 'Cert Expires' }).value
            if (![string]::IsNullOrEmpty($Expiry)) {
                if ($Expiry -ge (Get-Date) -and $Expiry -le (Get-Date).AddDays(20)) {
                    $Asset
                }
            }
        }
    }
}
