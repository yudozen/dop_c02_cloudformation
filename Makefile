include submodule/aws_cli_container/Makefile

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
