# Terraform

# Installation
```
$ sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

$ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

$ sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

$ sudo apt-get update && sudo apt-get install terraform -y
```
# Credentials
```
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
$ export AWS_DEFAULT_REGION="us-west-2"
```

# Debug/Logs
## Log
### Resolution
You can set the Terraform log level and location via the TF_LOG and TF_LOG_PATH environment variables.

##  Set log level with TF_LOG
The environment variableTF_LOG defines the log level. Valid log levels are (in order of decreasing verbosity): TRACE, DEBUG, INFO, WARN or ERROR.

Set the log level in your environment with the appropriate command (substituting your preferred log level):

Bash: export TF_LOG="DEBUG"

PowerShell: $env:TF_LOG="DEBUG"

## Redirect Terraform logs with TF_LOG
The environment variable TF_LOG_PATH specifies the file in which Terraform will write logs. If TF_LOG_PATH is not set, output is sent to standard output and error in the terminal. If the environment variable is set, Terraform will append logs from each run to the specified file.

Set the Terraform log location in your environment with the appropriate command (substituting the path to your preferred file):

Bash: export TF_LOG_PATH="tmp/terraform.log"
