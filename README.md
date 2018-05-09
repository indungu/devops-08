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
    source setup/deploy-cp.sh
    ```
4. Close the `gunicorn` and exit the shell connection

