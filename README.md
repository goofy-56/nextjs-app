# nextjs-k8s-deploy (Starter)

**What you get in this ZIP:** a minimal Next.js frontend (in `next-app/`), a multi-stage `Dockerfile`, a GitHub Actions workflow to build & push the image to GHCR, and Kubernetes manifests (`k8s/`) to deploy to Minikube.

**Yes — the ZIP includes a working frontend** (Next.js pages and a simple API route). It is intentionally minimal so it builds quickly in CI/local.

## Dependencies (install on your machine / EC2)
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
   ```bash
   docker run -p 3000:3000 nextjs-k8s
   ```
   Open http://localhost:3000 — you should see the Next.js page. The API is at http://localhost:3000/api/hello

4. (Optional) If you prefer to run Next.js without Docker for development:
   ```bash
   cd next-app
   npm install
   npm run dev
   ```
   Then open http://localhost:3000

## GitHub Actions & GHCR
1. Push this repo to GitHub (replace <your-repo-url>):
   ```bash
   git init
   git add .
   git commit -m "Initial commit - nextjs k8s starter"
   git branch -M main
   git remote add origin <your-repo-url>
   git push -u origin main
   ```
2. The workflow in `.github/workflows/ci.yml` will run on push to `main`, build the Docker image, and push to GHCR as:
   - `ghcr.io/<your-username>/nextjs-k8s:latest`
   - `ghcr.io/<your-username>/nextjs-k8s:<sha>`

## Deploy to Minikube (line-by-line)
1. Start Minikube:
   ```bash
   minikube start
   ```
2. Apply manifests:
   ```bash
   kubectl apply -f k8s/
   ```
3. Check pods and services:
   ```bash
   kubectl get pods
   kubectl get svc
   ```
4. Open the app (Minikube will open the service in your browser):
   ```bash
   minikube service nextjs-service
   ```

## Notes about images & GHCR
- The k8s manifest currently references `ghcr.io/goofy-56/nextjs-k8s:latest`. Replace `goofy-56` with your GitHub username after you push and verify images in GHCR.
- The GitHub Actions workflow uses the automatic `GITHUB_TOKEN` so no extra secret is required for pushing to GHCR for the same user/org.

## AWS: Security group ports and recommended instance types

**Ports to open (inbound rules)**:
- SSH: TCP 22 — restrict to your IP only
- HTTP: TCP 80 — allow 0.0.0.0/0 if you want the app public
- HTTPS: TCP 443 — allow 0.0.0.0/0 (if you add TLS)
- NodePort range (if using NodePort on EC2): TCP 30000-32767 — allow only if you use NodePort (we used nodePort 32000 in k8s manifest)
- PostgreSQL (if you run it on the host): TCP 5432 — **do not** open to the world; restrict to your IP/network only

**AWS EC2 instance recommendations**:
- Testing / small demo: `t3.small` (2 vCPU, 2 GB RAM) — cheap but may be slow for builds
- Recommended for light production / CI: `t3.medium` (2 vCPU, 4 GB RAM)
- Production: `t3.large` (2 vCPU, 8 GB RAM) or `t3.xlarge` for heavier workloads
- Disk: 40 GB gp3 (or gp2) minimum

## Final tips
- Replace the GHCR image reference in `k8s/deployment.yaml` with your own `ghcr.io/<username>/nextjs-k8s:latest` after the workflow pushes the image.
- For a production-grade K8s deployment use `type: LoadBalancer` for the Service (on cloud providers) and use Secrets for any credentials.
- If you want I can replace `goofy-56` with another username in the manifest for you.

Enjoy — this is a minimal, runnable starter you can extend for the assessment.
