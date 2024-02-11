include .env
include .env.secret

CURRENT_DIR := $(shell pwd)
AWS := docker run --rm \
	-e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" \
	-e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" \
	-e AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION}" \
	-v ${CURRENT_DIR}:/aws \
	--entrypoint aws \
	${IMAGE_NAME}

build:
	docker build \
		--build-arg ORIGINAL_IMAGE_NAME=${ORIGINAL_IMAGE_NAME} \
		-t ${IMAGE_NAME} \
		-f Dockerfile .

version:
	${AWS} --version

test:
	${AWS} sts get-caller-identity \
		|| (echo "aws-cliコマンドテスト失敗\n認証情報を確認してください"; exit 1)
	@echo "aws-cliコマンドテスト成功\nAWSへ認証できることを確認しました"

alias:
	@echo "以下をコピーして実行してください。"
	alias aws='${AWS}'

create:
	${AWS} cloudformation create-stack \
		--stack-name MyTestStack \
		--template-body file://src/cf_s3/template.yaml

check:
	${AWS} s3 ls | grep dzn-unique-bucket-name-12345

delete:
	${AWS} cloudformation delete-stack --stack-name MyTestStack
