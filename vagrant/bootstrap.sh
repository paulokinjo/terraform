echo "[Task - 1] Add the keys"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

echo "[Task - 2] Add the repositories"
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

echo "[Task - 3] Update the OS"
sudo apt-get update

echo "[Task - 4] Install Terraform"
sudo apt-get install terraform

echo "[Task - 5] Clone terraform repository"
git clone https://github.com/paulokinjo/terraform
