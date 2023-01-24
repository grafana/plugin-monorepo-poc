.PHONY: .drone.jsonnet

.drone.jsonnet: ## Render .drone.yml pipeline file
	drone jsonnet --stream --format --source .drone/drone.jsonnet --target .drone.yml
	drone lint .drone.yml
