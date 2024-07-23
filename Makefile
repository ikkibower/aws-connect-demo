terraform-format:
	cd terraform
	terraform fmt
	cd ..
terraform-init:
	cd terraform
	terraform init
	cd ..
terraform-plan:
	cd terraform
	terraform plan
	cd ..
terraform-apply:
	cd terraform
	terraform apply
	cd ..
execute-local:
	cd lambdas/book-hotel
	ls -la
	cd ..
lint:
	cd lambdas/book-hotel
	ruff check
	cd ..