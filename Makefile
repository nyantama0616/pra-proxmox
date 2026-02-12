.PHONY: deploy dry-run ping tf-plan tf-apply tf-destroy vault-edit

# Ansible
deploy:
	cd ansible && ansible-playbook site.yml
dry-run:
	cd ansible && ansible-playbook site.yml --check
ping:
	cd ansible && ansible all -m ping
vault-edit:
	cd ansible && ansible-vault edit group_vars/all/vault.yml

# Terraform
tf-plan:
	cd terraform && terraform plan

tf-apply:
	cd terraform && terraform apply

tf-destroy:
	cd terraform && terraform destroy
