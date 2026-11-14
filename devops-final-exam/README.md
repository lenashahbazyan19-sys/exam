# DevOps Final Practical Examination

## Repository Structure

```
devops-final-exam/
├── task1-linux/
│   └── system_monitor.sh
├── task2-python/
│   ├── log_analyzer.py
│   └── report.json
├── task3-docker/
│   ├── app.py
│   ├── requirements.txt
│   ├── Dockerfile
│   └── .dockerignore
├── task4-ansible/
│   ├── inventory.ini
│   └── setup.yml
├── task5-terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── task6-kubernetes/
│   ├── deployment.yaml
│   └── service.yaml
└── README.md
```

## Environment Assumptions
* **OS:** Ubuntu 22.04 / 24.04 LTS
* **Tools installed:** Bash, Python 3.12+, Docker, Ansible, Terraform v1.5+, kubectl, and Minikube.
* **Security:** No credentials, private keys, `.tfvars` with secrets, or Terraform state files are committed to this repository.

---

## Task 1: Linux & Bash Scripting

### Setup & Verification Commands
```bash
cd task1-linux
chmod +x system_monitor.sh
./system_monitor.sh
cat system_report.log
```

### Execution Evidence
```===== SYSTEM MONITOR =====
Hostname: kali
User: lena
Uptime: 3 hours, 39 minutes
Total RAM: 15867 MB
Available RAM: 11189 MB
Disk Usage: 13%
Disk Status: OK
Docker: Installed
==========================
```

---

## Task 2: Python Log Automation

### Setup & Verification Commands
```bash
cd task2-python
python3 log_analyzer.py
cat report.json
```

### Execution Evidence
```json
{
  "total_logs": 8,
  "info": 3,
  "warning": 2,
  "error": 3,
  "most_common_error": "Database timeout"
}
```

---

## Task 3: Docker Containerization

### Setup & Verification Commands
```bash
cd task3-docker
docker build -t devops-exam:v1 .
docker run -d --name flask-exam -p 8080:5000 devops-exam:v1
curl -i http://localhost:8080/health
```

### Execution Evidence
```curl -i http://localhost:8080/health
HTTP/1.1 200 OK
Server: Werkzeug/3.1.9 Python/3.12.16
Date: Sat, 14 Nov 2026 15:45:36 GMT
Content-Type: application/json
Content-Length: 21
Connection: close

{"status":"healthy"}
```

---

## Task 4: Ansible Automation

### Setup & Verification Commands
```bash
cd task4-ansible
# First run (applies changes)
ansible-playbook -i inventory.ini setup.yml
# Second run (idempotency check - changed=0)
ansible-playbook -i inventory.ini setup.yml
# Verify HTTP response
curl -i http://<UBUNTU_HOST_IP>
```

### Execution Evidence
```PLAY RECAP *********************************************************************
ubuntu-host                : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
curl -i http://51.20.10.172
HTTP/1.1 200 OK
Server: nginx/1.24.0 (Ubuntu)
Content-Type: text/html

<h1>DevOps Exam - Ansible Deployment</h1>
```

---

## Task 5: Terraform & AWS Infrastructure

### Setup & Verification Commands
*(Note: `terraform apply` was intentionally omitted per exam instructions).*
```bash
cd task5-terraform
terraform init
terraform fmt -check
terraform validate
terraform plan
```

### Execution Evidence
```Success! The configuration is valid.

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + instance_public_ip = (known after apply)
```

---

## Task 6: Kubernetes Deployment

### Setup & Verification Commands
```bash
# Load local image into Minikube
minikube image load devops-exam:v1

# Apply manifests
cd task6-kubernetes
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Verify resources
kubectl get pods -n devops-exam
kubectl get deployments -n devops-exam
kubectl get services -n devops-exam

# Test endpoint via Service
minikube service flask-service -n devops-exam --url
curl http://<MINIKUBE_SERVICE_URL>/health
```

### Execution Evidence
```$ kubectl get pods,deployments -n devops-exam
NAME                                    READY   STATUS    RESTARTS   AGE
pod/flask-deployment-xxxxxxxxxx-xxxxx   1/1     Running   0          2m
pod/flask-deployment-xxxxxxxxxx-xxxxx   1/1     Running   0          2m
pod/flask-deployment-xxxxxxxxxx-xxxxx   1/1     Running   0          2m

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/flask-deployment   3/3     3            3           2m

kubectl get services -n devops-exam
NAME            TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S) AGE
flask-service   NodePort   10.101.218.58   <none>        80:31008/TCP 93s
minikube service flask-service -n devops-exam --url
http://192.168.49.2:31008
curl -i http://192.168.49.2:31008/health           
HTTP/1.1 200 OK
Server: Werkzeug/3.1.9 Python/3.12.16
Date: Sat, 14 Nov 2026 18:26:11 GMT
Content-Type: application/json
Content-Length: 21
Connection: close

{"status":"healthy"}
```
