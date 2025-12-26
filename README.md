# Earthlink

Earthlink is a virtual world that is being developed to train autonomous intelligent agents to explore other worlds and evaluate their fitness to do so.

This repository provides an overview of the two components that make up Earthlink and links to their repositories.

## Components

- Earthlink Client: https://github.com/Yuxi-Labs/earthlink-client
    - Tauri desktop application for visualization and interactive control.

- Earthlink Server: https://github.com/Yuxi-Labs/earthlink-server
    - Python backend (FastAPI/Ray/PyTorch) for agent execution, learning, simulation, and persistence.

## Running

Backend:

```bash
cd server
docker compose up -d
```

API: `http://localhost:8000`  
OpenAPI docs: `http://localhost:8000/docs`

Client:

```bash
cd client
npm install
npm run tauri dev
```

## Tests

Run backend tests inside the backend container:

```bash
cd server
docker compose run --rm api pytest tests/
```

## Copyright

(c) 2025 William Sawyerr