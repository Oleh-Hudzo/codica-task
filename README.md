# **Project Name: AWS Infrastructure Deployment**

## **About the Project**
This project is designed to deploy a WordPress application, providing the ability to launch it fast and easily. The infrastructure is created with Terraform and fully automated using Ansible for provisioning. The goal of this project is to provide a reliable and scalable WordPress deployment on AWS.

## **Requirements**
In order to use this project, you will need the following tools installed on your local machine:

- AWS CLI
- Terraform 1.3 or later
- Ansible v2.14 or later

## Getting Started
**1. Clone the repository to your local machine:**

`git clone https://github.com/Oleh-Hudzo/codica-task.git`

**2. Change directory to aws-infrastructure-deployment/terraform:**

`cd codica-task/terraform`

**3. Configure your AWS credentials: aws configure:**

`aws configure --profile codica_task`

_Notice, that codica_task profile should be configured in AWS console and added to admin group._

**4. Manage s3 bucket to store terraform state**

Change the bucket value in backend.tf file to your bucket name. (You need to create it first in AWS CONSOLE with a globally unique name)

**5. Change the configuration in variables.tf file if needed**

Variables have descriptions. Also change the credentials in _**ansible/playboks/files/docker-compose.yaml**_
 
**6. Run terraform init to initialize the Terraform modules.**

`terraform init`

**7. Run terraform plan to see all the stages and changes during creation.**

`terraform plan`

**8. Run terraform apply to create the infrastructure.**

`terraform apply`

**9. Once the infrastructure is created, you can find the web application load balancer URL in the Terraform output.**

**10. To destroy the infrastructure, run terraform destroy.**

`terraform destroy`

## How Infrastructure Works

By default, it uses the newest Ubuntu 20.04 AMI, but this can be easily configured to use the newest AWS Linux 2 AMI instead. The Ansible playbooks provided in this project can be used to configure both Ubuntu and RHEL-based systems.

This project creates the following AWS resources:

- Two public subnets and two private subnets in different Availability Zones for high availability and fault tolerance.
- An RDS instance in a private subnet for database storage.
- A NAT Gateway in a public subnet to provide outbound internet access for instances in the private subnets.
- An EC2 instance for hosting the WordPress application.
- An Application Load Balancer in a public subnet for distributing traffic to the EC2 instance.
- Two security groups: one for the web resources (instance and load balancer) and one for the RDS instance.
- The subnets provide the network environment for the resources to operate. Public subnets allow resources to communicate with the internet, while private subnets do not allow direct access from the internet.

**The RDS instance** provides a managed database service for storing the WordPress data. By placing the RDS instance in a private subnet, it is not directly accessible from the internet, which improves the security of the data.

**The Application Load Balancer** is an AWS-managed service that distributes incoming traffic to the EC2 instance based on rules defined in the listener. In this project, it distributes traffic to the only EC2 instance that is running.

**The security groups** provide a way to control the inbound and outbound traffic to the resources.

**The NAT Gateway** provides outbound internet access for instances in the private subnets. This allows the instances to access the internet for software updates, patches, and other necessary tasks. The NAT Gateway is placed in a public subnet and is used as a gateway for outbound traffic from the private subnets. The security group for the private instances only allows outbound traffic to the NAT Gateway on port 80 and 443 for HTTP and HTTPS traffic. This helps to improve the security of the private instances by preventing direct access from the internet.

Overall, this infrastructure provides a highly available and secure environment for running WordPress application.

## Important note
* Note: This is a sample Terraform+Ansible configuration and it is intended for learning and testing purposes only. It is not production-ready and should not be used in a production environment.

