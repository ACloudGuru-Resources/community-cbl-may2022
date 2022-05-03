# Cloud Builder Live - May 2022

In this episode, I will be diving into Azure Bicep.  I will cover key concepts around infrastructure as code within Azure as well as Bicep concepts including templates, parameters, variables, and modules.  

![Azure Bicep Template](/images/thumbnail.jpg)

## Watch It

The episode will air live at 6pm Eastern Time on May 3, 2022.  You can watch it here: [Watch Episode](https://www.youtube.com/watch?v=Zzw4-cxeMRk)

## Branches

This repository represents the completed state of the demo.  There is only one branch used for this episode.

## Additional Project

This repository uses an additional project for deployment.  You can review this repository here: [COVID API Demo](https://github.com/davidtucker/covid-data-api-demo)

## Adding in Azure Credentials for GitHub

To add in the needed Azure credentials for GitHub, you will need to do the following steps.

First, you will need to create a new service principal that will be used for this deployment.  Be sure to substitute the values for app name (your choice), subscription ID, and resource group.

```bash
az ad sp create-for-rbac \
  --name {app-name} \
  --role contributor \
  --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group} \
  --sdk-auth
```

This will return JSON similar to the following:

```json
{
  "clientId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx",
  "clientSecret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "subscriptionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx",
  "tenantId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
}
```

Copy this entire JSON output.  

Next, head over to GitHub to your repository.  Navigate to settings and then Secrets (Actions).    Click `New repository secret`.  Name the secret `AZURE_CREDENTIALS`. Paste in the JSON output from the previous command.

![Adding in GitHub Secret](/images/github-secret.jpg)

You will also need to add in two additional secrets: `AZURE_SUBSCRIPTION` (which will have your subscription ID) and `AZURE_RG` (containing your resource group name).  When those have been entered, you should see the following in secrets:

![Adding in GitHub Secret](/images/github-secret-completed.jpg)

With that in place, your will be ready to configure your GitHub action to deploy your Bicep template.

## Useful Links

As you dive into Azure Bicep, here are some links that you may find helpful:

- [Resource Reference for ARM and Bicep](https://docs.microsoft.com/en-us/azure/templates/)
- [Bicep Documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
- [Configuring VS Code](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/quickstart-create-bicep-use-visual-studio-code?tabs=CLI)
- [Bicep with GitHub Actions](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-github-actions?tabs=CLI)
- [Azure Quickstart Templates](https://github.com/Azure/azure-quickstart-templates)