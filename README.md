# **Project Name: AWS Infrastructure Deployment**

## **About the Project**
This project is designed to deploy a WordPress application, providing the ability to launch it fast and easily. The goal of this project is to provide a fully automated infrastructure deployment.

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

Change the bucket value in backend.tf file to your bucket name. (You need to create it first with a globally unique name)
 
**5. Run terraform init to initialize the Terraform modules.**

`terraform init`

**6. Run terraform plan to see all the stages and changes during creation.**

`terraform plan`

**7. Run terraform apply to create the infrastructure.**

`terraform apply`

**8. Once the infrastructure is created, you can find the web application load balancer URL in the Terraform output.**

**9. To destroy the infrastructure, run terraform destroy.**

`terraform destroy`

## How Infrastructure Works

This project creates the following AWS resources:

- Two public subnets and two private subnets in different Availability Zones for high availability and fault tolerance.
- An RDS instance in a private subnet for database storage.
- An EC2 instance in a private subnet for hosting the WordPress application.
- An Application Load Balancer in a public subnet for distributing traffic to the EC2 instance.
- Two security groups: one for the web resources (instance and load balancer) and one for the RDS instance.
- The subnets provide the network environment for the resources to operate. Public subnets allow resources to communicate with the internet, while private subnets do not allow direct access from the internet.

**The RDS instance** provides a managed database service for storing the WordPress data. By placing the RDS instance in a private subnet, it is not directly accessible from the internet, which improves the security of the data.

**The EC2 instance** runs the WordPress application and is placed in a private subnet to minimize its exposure to the internet. It is accessible only through the load balancer, which distributes the incoming traffic to the instance.

**The Application Load Balancer** is an AWS-managed service that distributes incoming traffic to the EC2 instance based on rules defined in the listener. In this project, it distributes traffic to the only EC2 instance that is running.

**The security groups** provide a way to control the inbound and outbound traffic to the resources. The web security group allows incoming traffic on port 80 from the Application Load Balancer and allows outbound traffic to the RDS instance. The RDS security group allows incoming traffic only from the web security group on port 3306, which is the default port for MySQL.

Overall, this infrastructure provides a highly available and secure environment for running WordPress application.

## Important note
* Note: This is a sample Terraform+Ansible configuration and it is intended for learning and testing purposes only. It is not production-ready and should not be used in a production environment.

