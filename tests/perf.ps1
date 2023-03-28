[CmdletBinding()]
param (
    [Parameter()]
    [int]
    $NumberOfExecutions=1
)

Write-Host "Executing web request $NumberOfExecutions times..."

for (($i = 0); $i -lt $NumberOfExecutions; $i++)
{
    Write-Host '.' -NoNewline
    $r = Invoke-WebRequest https://ca-test-ae.blackrock-1e0e890c.australiaeast.azurecontainerapps.io/someapicall
    if ($r.StatusCode -gt 204) 
    {
        Write-Warning "Status Code recieved: $($r.StatusCode)"
    }
}

