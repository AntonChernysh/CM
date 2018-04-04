Prerequisites:
* S3 bucket for Terraform state.
* SSH keypair created in AWS
* Private key downloaded to your management machine. 

How-to:
* Review `variables.tf` and update all variables with your values.
* `terraform plan`
* `terraform apply`

At the end you will get Ubuntu machine with python installed running in public subnet. 
* Note instance IP and move on to Ansible part.
