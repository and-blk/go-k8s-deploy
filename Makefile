VENV ?= ~/.venv
CI_COMMIT_REF_NAME ?=
PYTHON ?= python3
PIP ?= pip3
SHELL = /bin/bash
ANSIBLE_PATH ?= ansible
USER ?= user
export PATH := $(CURDIR)/$(VENV)/bin:$(PATH)
export ANSIBLE_HOST_KEY_CHECKING=False

define source_venv
	source $(VENV)/bin/activate
endef

.PHONY: deploy
deploy:
	source $(VENV)/bin/activate;\
	cd $(ANSIBLE_PATH);\
	ANS_VARS='APP_IMAGE=$(APP_IMAGE) CI_COMMIT_SHORT_SHA=$(CI_COMMIT_SHORT_SHA) DOCKERUSER=$(USERNAME) DOCKERPASS=$(PASSWORD)'; \
	ansible-playbook k8s_deploy.yml -i $(CI_COMMIT_REF_NAME) --private-key /sshkey --extra-vars $$ANS_VARS

