# nextjs-app-deploy (Starter)

a  Next.js frontend (in next-app), a multi-stage Dockerfile, a GitHub Actions workflow to build & push the image to GHCR, and Kubernetes manifests (k8s) to deploy to Minikube.

## Dependencies (install on  machine / EC2)
- Node.js 18+ (required for building Next.js)
- npm (comes with Node)
- Docker (for local image build & running)
- Minikube and kubectl (for Kubernetes deployment)
- Git (to push code to GitHub)

## Quick local steps (line-by-line)

1. Unzip the project and `cd` into it:
   ```bash
   unzip nextjs-k8s.zip
   cd nextjs-k8s
   ```

2. Build the Docker image locally (optional):
   ```bash
   docker build -t nextjs-k8s .
   ```

3. Run the image locally:
   bash
   docker run -p 3000:3000 nextjs-k8s
   ```
   Open http://localhost:3000 — you should see the Next.js page. The API is at http://localhost:3000/api/hello


## GitHub Actions & GHCR
1. Push this repo to GitHub (replace https://github.com/goofy-56/nextjs-app.git ):
   bash
   git init
   git add .
   git commit -m "Initial commit - nextjs k8s starter"
   git branch -M main
   git remote add origin <your-repo-url>
   git push -u origin main
   ```
2. The workflow in '.github/workflows/ci.yml' will run on push to 'mai', build the Docker image, and push to GHCR as:
   - 'ghcr.io/<your-username>/nextjs-k8s:latest'
   - 'ghcr.io/<your-username>/nextjs-k8s:<sha>'or e734f1b024fb1b229baaab2a6faf2fba402df9ae 

## Deploy to Minikube (line-by-line)
1. Start Minikube:
   bash
   minikube start
   ```
2. Apply manifests:
   bash
   kubectl apply -f k8s/
   ```
3. Check pods and services:
   bash
   kubectl get pods
   kubectl get svc
   ```
4. Open the app (Minikube will open the service in your browser):
   bash
   minikube service nextjs-service
   ```

## Notes about images & GHCR
- The k8s manifest currently references `ghcr.io/goofy-56/nextjs-k8s:latest`. Replace `goofy-56` with your GitHub username after you push and verify images in GHCR.
- The GitHub Actions workflow uses the automatic `GITHUB_TOKEN` so no extra secret is required for pushing to GHCR for the same user/org.

## AWS: Security group ports and instance types

**Ports to open (inbound rules)**:
- SSH: TCP 22 — restrict to your IP only
- HTTP: TCP 80 — allow 0.0.0.0/0 if you want the app public
- HTTPS: TCP 443 — allow 0.0.0.0/0 (if you add TLS)
- NodePort range (if using NodePort on EC2): TCP 30000-32767 — allow only if  use NodePort (i used nodePort 32000 in k8s manifest)
- PostgreSQL (if you run it on the host): TCP 5432 — **do not** open to the world; restrict to your IP/network only

**AWS EC2 instance **:
- Recommended  light production / CI: `t3.medium` (2 vCPU, 4 GB RAM)

- Note: Parts of this assignment were completed with the help of ChatGPT for learning and clarification purposes. Guidance and code suggestions were taken from documentation




<img width="1920" height="1008" alt="Screenshot 2025-10-08 004216" src="https://github.com/user-attachments/assets/e8e81c60-e9bd-4a49-8183-660a22d1caa9" />
<img width="1920" height="1008" alt="Screenshot 2025-10-08 004209" src="https://github.com/user-attachments/assets/3fb7a371-38ad-4b52-96bd-f28656a95349" />
<img width="1920" height="1008" alt="Screenshot 2025-10-08 004103" src="https://github.com/user-attachments/assets/24fdef00-cbc1-4582-8d61-1d42ce452c66" />
<img width="1920" height="1008" alt=<img width="1920" height="1008" alt="Screenshot 2025-10-08 002143" src="https://github.com/user-attachments/assets/e796cfbc-1e7e-49b5-a255-72dfc6d6c818" />
"Screenshot 2025-10-08 004057" src="https://github.com/user-attachments/assets/660246ec-6bf9-4462-92ca-99f48964e37b" />
<img width="1920" height="1008" alt="Screenshot 2025-10-08 001118" src="https://github.com/user-attachments/assets/929a8593-ec20-4ef6-9eb5-a102f38b9f16" />
<img width="1920" height="1008" alt="Screenshot 2025-10-08 004057" src="https://github.com/user-attachments/assets/844fa687-bedc-4f78-aae2-a87ec068eb06" />

