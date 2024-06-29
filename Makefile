.PHONY: init
init:
	(cd cloudfunction_public_http_2nd_gen/environments/production && terraform init)

.PHONY: plan
plan:
	sh scripts/plan.sh

.PHONY: deploy
deploy:
	sh scripts/deploy.sh
