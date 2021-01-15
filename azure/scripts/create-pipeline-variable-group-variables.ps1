$org = 'https://dev.azure.com/org-name/'
$project = 'Paas-To-AKS'
$variableGroupName = 'paas-to-aks'

# The syntax of '"$(token)-text"' is neccessary to escape variable notation
az pipelines variable-group create `
    --authorize=false `
    --org=$org `
    --project=$project `
    --name $variableGroupName `
    --variables acrName='passtoaksacr' `
    aksName='"$(deploymentId)-aks-cluster"' `
    azureArtifacts='"$(System.DefaultWorkingDirectory)/_artifacts/Azure"' `
    azureServiceConnection='WAY Azure Internal 2.0' `
    azureSubscriptionId='00000000-0000-0000-0000-000000000000' `
    deploymentId='pass-to-aks' `
    keyvaultName='"$(deploymentId)-kv"' `
    kubernetesArtifacts='"$(System.DefaultWorkingDirectory)/_artifacts/Kubernetes"' `
    kubernetesServiceConnection='Pass-to-AKS-Cluster' `
    location='centralus' `
    redisCacheName='"$(deploymentId)-redis"' `
    resourceGroupname='"$(deploymentId)"' `
    sitecore-database-elasticpool-name='"$(deploymentId)-sql-pool"' `
    solrDeployTemplate='"$(Pipeline.Workspace)/Azure/templates/solr/templates/deploy-solr.json"' `
    solrDeployTemplateParameters='"$(Pipeline.Workspace)/Azure/templates/solr/templates/deploy-solr.parameters.json"' `
    topology='xp1' `
    --output yaml