group "default" {
  targets = ["stable", "beta"]
}

variable "STABLE_TAG" {
    default = "latest"
}

variable "BETA_TAG" {
    default = "beta-latest"
}

taget "common" {
    dockerfile = "Dockerfile"
    platforms = ["linux/amd64", "linux/arm64"]
}

target "stable" {
    inherits = ["common"]
    context = "Omada Beta"
    tags = ["docker.io/jkunczik/home-assistant-omada:${STABLE_TAG}"]
}

target "beta" {
    inherits = ["common"]
    context = "Omada Beta"
    tags = ["docker.io/jkunczik/home-assistant-omada:${BETA_TAG}"]
}