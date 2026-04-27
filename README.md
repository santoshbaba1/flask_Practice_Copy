#  Jenkins CI/CD Pipeline for Flask Application

##  Project Overview

This project demonstrates the implementation of a **CI/CD (Continuous Integration & Continuous Deployment)** pipeline using **Jenkins** for a Python Flask web application.

The pipeline automates:

* Code checkout from GitHub
* Dependency installation
* Unit testing using pytest
* Application deployment to a staging environment
* Build notifications via email


<img width="1536" height="1024" alt="uncle jenkins" src="https://github.com/user-attachments/assets/67df3396-a98d-47ac-b7ec-30828b14e896" />

---

## 🔗 Repository

* Source Repository:
    -https://github.com/mohanDevOps-arch/flask_Practice.git

* Forked Repository (Submission):
    `https://github.com/santoshbaba1/flask_Practice_Copy.git

---

## 🛠️ Tech Stack

* Python 3
* Flask
* Jenkins
* Git & GitHub
* Pytest
* Linux (Ubuntu)

---

##  Project Structure

```id="6k2p2q"
flask_Practice/
│── app.py
│── requirements.txt
│── Jenkinsfile
│── tests/
│   └── test_app.py
│── README.md
```

---

##  Prerequisites

Ensure the following are installed on your Jenkins server:

* Jenkins
* Python 3
* pip
* Git

### Install Dependencies

```bash id="2r7j0p"
sudo apt update -y
sudo apt install -y python3 python3-pip python3-venv git
```

---

# The Jenkins pipeline includes the following stages:

## Checkout Code

* Pulls the latest code from the `main` branch of GitHub repository

## Build Stage

* Creates a Python virtual environment
* Installs dependencies using `requirements.txt`

## Test Stage

* Executes unit tests using pytest
* Ensures code quality before deployment

## Deploy Stage

* Stops any existing application instance
* Starts the Flask application

## Health Check Stage

* Stops any existing application instance
* Starts the Flask application

    - <img width="1298" height="673" alt="ci-cd" src="https://github.com/user-attachments/assets/8974e6a2-024a-46c7-a987-703afd34680e" />
    - <img width="1321" height="321" alt="ci-cd 1" src="https://github.com/user-attachments/assets/f02fba47-3e41-4bac-acd9-72e121c57135" />
    
---

## 🧾 Jenkinsfile

```groovy id="fy4g9n"
pipeline {
    agent any

    environment {
        VENV = "venv"
        PORT = "5000"
    }

    stages {
        stage('Clone Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/santoshbaba1/flask_Practice_Copy.gi                                                      t'
            }
        }

        stage('Build') {
            steps {
                sh '''
                    python3 -m venv $VENV
                    $VENV/bin/pip install --upgrade pip
                    $VENV/bin/pip install -r requirements.txt
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    . $VENV/bin/activate
                    pytest
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    pkill -f app.py || true
                    nohup venv/bin/python3 app.py > app.log 2>&1 &
                '''
            }
        }

        stage('Health Check') {
            steps {
                sh '''
                    sleep 5
                    curl -f http://localhost:$PORT || exit 1
                '''
            }
        }
    }

    post('Email Notification') {
        success {
            emailext (
                to: 'santoshpvt08@gmail.com',
                subject: "SUCCESS: Build ${BUILD_NUMBER}",
                body: "Build succeeded! Check: ${BUILD_URL}"

            )
        }
        failure {
            emailext (
                to: 'santoshpvt08@gmail.com',
                subject: "FAILED: Build ${BUILD_NUMBER}",
                body: "Build failed! Check: ${BUILD_URL}"

            )
        }
    }
}

```

---

##  Pipeline Trigger Setup

The pipeline is configured to trigger automatically on code changes.

##  Email Notification Setup

Email notifications are configured using Jenkins Email Extension Plugin.

### SMTP Configuration:

* SMTP Server: `smtp.gmail.com`
* Port: `587`
* TLS: Enabled
* Authentication: Gmail App Password

    -<img width="1313" height="666" alt="email config" src="https://github.com/user-attachments/assets/b838e2f7-bac2-4370-bc9d-48209da7ef33" />

---

##  Run Application Locally

```bash id="w0p93h"
    git clone https://github.com/mohanDevOps-arch/flask_Practice.git
    cd flask_Practice

    python3 -m venv venv
    source venv/bin/activate

    pip install -r requirements.txt
    python app.py
```

<img width="1365" height="486" alt="Uncle-1" src="https://github.com/user-attachments/assets/49298440-c8ae-49ee-bf02-ebde72fdba37" />
<img width="1365" height="721" alt="local run" src="https://github.com/user-attachments/assets/cf8bf2c6-d35f-49e9-89eb-b8bd971cce31" />
<img width="1363" height="760" alt="app1" src="https://github.com/user-attachments/assets/4086abe8-9fdc-41fd-a112-86b96a85111c" />
<img width="1361" height="752" alt="app reg" src="https://github.com/user-attachments/assets/9dbae9a9-b2e3-4e4f-a1a7-2885903bc005" />

# Code Modify
<img width="1362" height="711" alt="local run 1" src="https://github.com/user-attachments/assets/c3a7eaa3-4f23-4f0b-ba85-bee0f0ebc4ed" />
<img width="1356" height="709" alt="local run 2" src="https://github.com/user-attachments/assets/428eea0e-b353-461c-9fcc-6c58db93693c" />


<img width="1365" height="532" alt="local run 6" src="https://github.com/user-attachments/assets/cc917ad7-3d25-41ae-84fe-8ac001197fe4" />
<img width="1357" height="705" alt="local run 4" src="https://github.com/user-attachments/assets/0e89b22f-e41b-4309-8beb-3c0343e5b980" />
<img width="1357" height="431" alt="local run 3" src="https://github.com/user-attachments/assets/35fc3b3f-fab9-4487-87d8-0f2f965ac8c8" />


Access the application:

    ```id="2m55z5"
    http://localhost:5000
```

---

##  Screenshots (Add for Submission)

Include the following screenshots:

* ✅ Jenkins Dashboard
* ✅ Pipeline Stage View (Build, Test, Deploy)
* ✅ Console Output Logs
* ✅ Application Running in Browser

---

##  Key Features

* Automated CI/CD pipeline using Jenkins
* GitHub integration with webhook trigger
* Virtual environment (PEP 668 compliant)
* Automated testing with pytest
* Email notifications for build status

---

##  Challenges & Solutions

| Issue                                              | Solution                   |
| -------------------------------------------------- | -------------------------- |
| pip install error (externally-managed-environment) | Used virtual environment   |
| Branch mismatch (master vs main)                   | Configured correct branch  |
| Email notification failure                         | Configured SMTP with Gmail |
| Jenkins workspace issues                           | Cleaned workspace          |

---

## 🔮 Future Enhancements

* Docker containerization
* Kubernetes deployment
* AWS EC2 hosting
* CI/CD using GitHub Actions
* SonarQube integration

---

## Conclusion

This project successfully demonstrates a **fully automated CI/CD pipeline** for a Flask application using Jenkins, ensuring faster and reliable software delivery.

---

## License
---

## 👨‍💻 Author

**Santosh Kumar Sharma (12394)**
DevOps & Cloud Enthusiast





