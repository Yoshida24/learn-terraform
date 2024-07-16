#!/bin/bash
(cd cloudfunction_public_http_2nd_gen/environments/production && terraform init)
(cd cloudfunction_public_http_2nd_gen/environments/production && terraform plan -out=plan.out -var-file=production.tfvars)
(cd cloudfunction_public_http_2nd_gen/environments/production && terraform apply -auto-approve -var-file=production.tfvars)
