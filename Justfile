_default:
    just --list

build:
    nom build --no-link "."
    du -h $(nix build --print-out-paths --no-link ".")

load: build
    docker load -q --input $(nix build --print-out-paths --no-link ".")
    docker images

run: load
    docker run --ulimit core=0 --name ffglitch -d $(docker images ffglitch --format="{{{{.ID}}" )

shell: load
    docker run --rm -it $(docker images ffglitch --format="{{{{.ID}}" ) bash

clean:
    -docker stop ffglitch
    -docker rm ffglitch
    -docker rmi $(docker images ffglitch --format="{{{{.ID}}")
    #nh clean all -k 10 -K 1w
    #nix-store --optimize
