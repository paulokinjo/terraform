Azure Infrastructure Provisioning
=================================

## Planning

```bash

open set-envs.ps1 and configure the environment variables values.

RUN set-envs.ps1
RUN pre-requisite.ps1 -RESOURCE_GROUP $env:resource_group -LOCATION $env:location -STORAGE_ACCOUNT $env:storage_account -CONTAINER $env:container

# Change current directory to the environment configuration dir
cd environments/${ENVIRONMENT}
```

### Configuration steps (scripted)

```bash
#!/usr/bin/env bash
	 
// set to value of ${CUSTOMER}
customer    = ""
// set to value of ${ENVIRONMENT}
environment = ""
// set to value of ${LOCATION}
location    = ""       

// Azure Subscription ID (value of ${SUBSCRIPTION_ID}) 
subscription_id = ""
```
	 
## Apply configuration

Initialize and execute `infrastructure` sub-project. 

> Replace `<ENVIRONMENT>` with desired environment: `prod`, `stage`, etc.

```bash     
$ cd environments/<ENVIRONMENT>/infrastructure
terragrunt init

# Generate execution plan
terragrunt plan -out=infrastructure.tfplan -input=false

# Apply execution plan
terragrunt apply infrastructure.tfplan
```
[1]:	https://docs.microsoft.com/en-en/cli/azure/install-az-cli2
[2]:	https://www.terraform.io/intro/getting-started/install.html
[3]:	https://terragrunt.gruntwork.io/docs/getting-started/install/
