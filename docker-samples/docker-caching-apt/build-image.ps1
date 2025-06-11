docker build `
    -t docker-caching-apt `
    --progress=plain `
    --file Dockerfile `
    --cache-to type=local,dest=.\cache `
    --cache-from type=local,src=.\cache `
    .
