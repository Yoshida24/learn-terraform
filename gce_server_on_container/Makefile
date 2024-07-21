.PHONY: init
init:
	(cd environments/develop && terraform init)

.PHONY: push
push:
	sh scripts/push_example_container.sh

.PHONY: local
local:
	sh scripts/local.sh

.PHONY: plan
plan:
	(cd environments/develop && terraform plan -var-file="develop.tfvars" -out=plan.out)

.PHONY: deploy
deploy:
	(cd environments/develop && terraform plan -var-file="develop.tfvars" -out=plan.out && terraform apply -auto-approve -var-file="develop.tfvars")

.PHONY: destroy
destroy:
	(cd environments/develop && terraform destroy -auto-approve -var-file="develop.tfvars")
