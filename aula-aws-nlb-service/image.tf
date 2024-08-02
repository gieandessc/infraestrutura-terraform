resource "docker_image" "this" {
  name = format("%v:%v", module.ecr.repository_url, formatdate("YYYY-MM-DD'T'hh-mm-ss", timestamp()))
  build {
    context = "./app" # Path to your local Dockerfile
  }
}

resource "docker_registry_image" "this" {
  keep_remotely = true
  name          = resource.docker_image.this.name
}
