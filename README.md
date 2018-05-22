# devops-08
A repository for DevOps assignments and projects

## Auto deployment for Yummy Recipes REST API
The script in this project is for automated deployment of the [yummy-rest](https://github.com/indungu/yummy-rest.git) project on an Ubuntu Server 16.04 instance on AWS EC2.

### Pre-requisites
Create an AWS EC2 instance of the Ubuntu Server 16.04 and ensure the following inbound rules are set as shown.

![image](https://user-images.githubusercontent.com/30072633/39813336-af65afec-5398-11e8-82ab-c75b8b07e71d.png)

### Steps

1. Connect to the instance through the ssh.
2. clone this repository
    ```bash
    git clone -b deploy-automation https://github.com/indungu/devops-08.git setup
    ```
3. Run the script 
    ```bash
    source setup/deploy-backend.sh
    ```
4. Exit the shell connection


### Building Ansible provised AWS AMIs

#### Pre-requisites
Please ensure your system has the following installed:
1. [Packer](https://www.packer.io/docs/install/index.html)
2. [Ansible](https://docs.ansible.com/ansible/2.4/intro_installation.html)

To build your own AMIs of the Yummy Recipes REST API, just follow this steps

1. Clone the repository on the `config-management` branch
    ```bash
    $ git clone -b config-managemnt https://github.com/indungu/devops-08.git setup/
    ```
2. Switch to the config/packer directory
    ```bash
    $ cd setup/config/packer
    ```
3. Export your AWS API security credentials to your environment
    ```bash
    $ export aws_access_key={YOUR_AWS_ACCOUNT_ACCESS_KEY}
    $ export aws_secret_key={YOUR_AWS_ACCOUNT_SECRET_KEY}
    ```
4. Validate the `image-template.json` file
    ```bash
    $ packer validate image-template.json
    ```
5. Build the `image-template.json` file
    ```bash
    $ packer build image-template.json
    ```
6. Login to your AWS Console and check your AMIs on the EC2 dashboard, you should have the new AMI in the list.
