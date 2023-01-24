local images = {
  node: 'node:16',
  golang: 'golang:1.17.6',
  golangci_lint: 'golangci/golangci-lint:v1.44.0',
  jsonnet_build: 'grafana/jsonnet-build:c8b75df',
};

local step(name, commands, image=images.golang, volumes=[], depends_on=[]) = {
  name: name,
  commands: commands,
  image: image,
  volumes: volumes,
  depends_on: depends_on,
};

local pipeline(name, steps=[]) = {
  kind: 'pipeline',
  type: 'docker',
  name: name,
  steps: steps,
  image_pull_secrets: ['dockerconfigjson'],
  trigger+: {
    ref+: [
      'refs/pull/**',
      'refs/heads/main',
    ],
  },
};

[
  pipeline('build',     

  step(
      'build',
      ['yarn install', 'yarn build'],
      image=images.node
    )
  )
]