terraform-format:
	cd terraform
	terraform fmt
	cd ..
terraform-init:
	cd terraform
	terraform init
	cd ..
execute-local:
	cd lambdas/book-hotel
	ls -la
	cd ..