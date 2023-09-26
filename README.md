# terraform-azurerm-storageaccount

## Create a bastic storage account in Azure
This is a module for demonstrating Terraform Private Module registry using an Azure storage account and related resources.

Running the `terraform plan` first to inspect the plan is strongly advised.

## Usage

```hcl
provider "azurerm" {
  features {}
}
resource "random_string" "sa_name" {
  length  = 6
  special = false
  upper   = false
  lower   = true
  numeric = true
}

resource "azurerm_resource_group" "rg01" {
  name     = "${random_string.sa_name.result}-rg01"
  location = "southcentralus"
}

module "storageaccount" {
  source  = "app.terraform.io/{yourOrgName}/storageaccount/azurerm"
  version = "1.3.0"
    env     = "dev"
  rg_name = azurerm_resource_group.rg01.name
  sa_name = random_string.sa_name.result
  network_rule_ip_rules = ["127.0.0.1"]
  account_replication_type = "LRS"

  depends_on = [azurerm_resource_group.rg01]
}
```
## Pre-Commit & Pr-Check & Test

### Configurations

- [Configure Terraform for Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure)

We assumed that you have setup service principal's credentials in your environment variables like below:

```shell
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"
```

On Windows Powershell:

```shell
$env:ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
$env:ARM_TENANT_ID="<azure_subscription_tenant_id>"
$env:ARM_CLIENT_ID="<service_principal_appid>"
$env:ARM_CLIENT_SECRET="<service_principal_password>"
```

We provide a docker image to run the pre-commit checks and tests for you: `mcr.microsoft.com/azterraform:latest`

To run the pre-commit task, we can run the following command:

```shell
$ docker run --rm -v $(pwd):/src -w /src mcr.microsoft.com/azterraform:latest make pre-commit
```

On Windows Powershell:

```shell
$ docker run --rm -v ${pwd}:/src -w /src mcr.microsoft.com/azterraform:latest make pre-commit
```

In pre-commit task, we will:

1. Run `terraform fmt -recursive` command for your Terraform code.
2. Run `terrafmt fmt -f` command for markdown files and go code files to ensure that the Terraform code embedded in these files are well formatted.
3. Run `go mod tidy` and `go mod vendor` for test folder to ensure that all the dependencies have been synced.
4. Run `gofmt` for all go code files.
5. Run `gofumpt` for all go code files.
6. Run `terraform-docs` on `README.md` file, then run `markdown-table-formatter` to format markdown tables in `README.md`.

Then we can run the pr-check task to check whether our code meets our pipeline's requirement(We strongly recommend you run the following command before you commit):

```shell
$ docker run --rm -v $(pwd):/src -w /src -e TFLINT_CONFIG=.tflint_alt.hcl mcr.microsoft.com/azterraform:latest make pr-check
```

On Windows Powershell:

```shell
$ docker run --rm -v ${pwd}:/src -w /src -e TFLINT_CONFIG=.tflint_alt.hcl mcr.microsoft.com/azterraform:latest make pr-check
```

To run the e2e-test, we can run the following command:

```text
docker run --rm -v $(pwd):/src -w /src -e ARM_SUBSCRIPTION_ID -e ARM_TENANT_ID -e ARM_CLIENT_ID -e ARM_CLIENT_SECRET mcr.microsoft.com/azterraform:latest make e2e-test
```

On Windows Powershell:

```text
docker run --rm -v ${pwd}:/src -w /src -e ARM_SUBSCRIPTION_ID -e ARM_TENANT_ID -e ARM_CLIENT_ID -e ARM_CLIENT_SECRET mcr.microsoft.com/azterraform:latest make e2e-test
```

## Prerequisites

- [Docker](https://www.docker.com/community-edition#/download)

## Authors

Originally created by [Eugene Chuvyrov](http://github.com/echuvyrov)

## License

[MIT](LICENSE)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version       |
|---------------------------------------------------------------------------|---------------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3        |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.0, < 4.0 |

## Providers

| Name                                                          | Version       |
|---------------------------------------------------------------|---------------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0, < 4.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                     | Type        |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)                          | resource    |
| [storage_account_network_rules.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules)      | resource    |

<!-- END_TF_DOCS -->