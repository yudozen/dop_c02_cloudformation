include submodule/aws_cli_container/Makefile
include submodule/terraform_container/Makefile
include submodule/pike_container/Makefile

test_aws:
	${AWS} sts get-caller-identity \
		|| (echo "aws-cliコマンドテスト失敗\n認証情報を確認してください"; exit 1)
	@echo "aws-cliコマンドテスト成功\nAWSへ認証できることを確認しました"

create:
	${AWS} cloudformation create-stack \
		--stack-name MyTestStack \
		--template-body file://src/cf_s3/template.yaml

check:
	${AWS} s3 ls | grep dzn-unique-bucket-name-12345

delete:
	${AWS} cloudformation delete-stack --stack-name MyTestStack

init:
	${TERRAFORM} -chdir=src/terraform/environment/dev init
	
plan:
	${TERRAFORM} -chdir=src/terraform/environment/dev plan

apply:
	${TERRAFORM} -chdir=src/terraform/environment/dev apply

scan:
	${PIKE} scan -w -i -d /pike/src/terraform/environment/dev

pike_make:
	${PIKE} make -d /pike/src/terraform/environment/dev

git_init:
	git init

git_remote_add_aws_origin:
	git remote add aws_origin ${GIT_AWS_ORIGIN}
