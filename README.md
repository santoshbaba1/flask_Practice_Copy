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

👉 Source Repository: https://github.com/mohanDevOps-arch/flask_Practice.git

👉 Forked Repository (Submission):
`<Add your forked repo link here>`

---

## 🛠️ Tech Stack

* Python 3
* Flask
* Jenkins
* Git & GitHub
* Pytest
* Linux (Ubuntu)

---

## 📂 Project Structure

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

## ⚙️ Prerequisites

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

---

## 🧾 Jenkinsfile

```groovy id="fy4g9n"
pipeline {
    agent any

    environment {
        VENV = "venv"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/mohanDevOps-arch/flask_Practice.git'
            }
        }

        stage('Build') {
            steps {
                sh '''
                python3 -m venv $VENV
                . $VENV/bin/activate
                pip install --upgrade pip
                pip install -r requirements.txt
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
                nohup python3 app.py > app.log 2>&1 &
                '''
            }
        }
    }

    post {
        success {
            emailext (
                to: 'your-email@example.com',
                subject: "SUCCESS: Jenkins Build ${BUILD_NUMBER}",
                body: "Build Successful!"
            )
        }
        failure {
            emailext (
                to: 'your-email@example.com',
                subject: "FAILED: Jenkins Build ${BUILD_NUMBER}",
                body: "Build Failed!"
            )
        }
    }
}
```

---

## 🔔 Pipeline Trigger Setup

The pipeline is configured to trigger automatically on code changes.

### GitHub Webhook Configuration:

1. Go to GitHub → Settings → Webhooks
2. Add webhook:

   ```
   http://<jenkins-url>/github-webhook/
   ```
3. Content type: `application/json`
4. Trigger: Push events

---

## 📧 Email Notification Setup

Email notifications are configured using Jenkins Email Extension Plugin.

### SMTP Configuration:

* SMTP Server: `smtp.gmail.com`
* Port: `587`
* TLS: Enabled
* Authentication: Gmail App Password

---

## 🚀 Run Application Locally

```bash id="w0p93h"
git clone https://github.com/mohanDevOps-arch/flask_Practice.git
cd flask_Practice

python3 -m venv venv
source venv/bin/activate

pip install -r requirements.txt
python app.py
```

Access the application:

```id="2m55z5"
http://localhost:5000
```

---

## 📸 Screenshots (Add for Submission)

Include the following screenshots:

* ✅ Jenkins Dashboard
* ✅ Pipeline Stage View (Build, Test, Deploy)
* ✅ Console Output Logs
* ✅ Application Running in Browser

---

## 🎯 Key Features

* Automated CI/CD pipeline using Jenkins
* GitHub integration with webhook trigger
* Virtual environment (PEP 668 compliant)
* Automated testing with pytest
* Email notifications for build status

---

## 🧠 Challenges & Solutions

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

## 👨‍💻 Author

**Santosh Kumar Sharma**
DevOps & Cloud Enthusiast

---

## 📌 Conclusion

This project successfully demonstrates a **fully automated CI/CD pipeline** for a Flask application using Jenkins, ensuring faster and reliable software delivery.

---

## License
***********************************************************************************************************

---

## 👨‍💻 Author

**Santosh Kumar Sharma**
DevOps & Cloud Enthusiast

---

## 📌 Repository Link

👉 https://github.com/santoshbaba1/flask_Practice_Copy.git

---

***********************************************************************************************************

MIT License


Author

Santosh Kumar Sharma (12394), Batch-15

DevOps & Cloud Enthusiast
---



