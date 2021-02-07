TERRAFORM_VERSION=0.14.6
TEMP_DIR=$(shell pwd)/tmp

include ops/aws-lambda.mk
include ops/ci.mk
include ops/shell.mk
include ops/github.mk


# Figure out which OS we are running.
OS="linux"
ifeq ("$(shell uname)", "Darwin")
	OS="darwin"
endif

check_defined = $(strip $(foreach 1, $1, $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = $(if $(value $1),, $(error Undefined $1$(if $2, ($2))$(if $(value @), required by target `$@`)))

common_terraform_binary:
	curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${OS}_amd64.zip -o /tmp/terraform_${TERRAFORM_VERSION}_${OS}_amd64.zip
	unzip -o /tmp/terraform_${TERRAFORM_VERSION}_${OS}_amd64.zip -d ${TEMP_DIR}/
	chmod +x ${TEMP_DIR}/terraform

common_jq_binary:
	curl -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -o ${TEMP_DIR}/jq
	chmod +x ${TEMP_DIR}/jq

common_aws_cli:
	pip install --user awscli
