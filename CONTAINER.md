# Run locally with Docker

- Build and start with Docker Compose:

```bash
docker compose up --build
```

- Or build and run manually:

```bash
docker build -t meetingless .
docker run --rm -it -p 4000:4000 -v "$PWD":/srv/jekyll meetingless
```

Open http://localhost:4000 in your browser. Files are mounted so edits on the host are picked up by Jekyll inside the container.
