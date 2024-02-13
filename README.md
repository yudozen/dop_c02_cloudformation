# DOP_C02 CloudFormation

AWS Certified DevOps Engineer - Professional CloudFormationの実習です

# 前提条件
- Dockerfileをビルドできる環境
    - Docker Desktopなど

# 使い方
```
### ソースを取得します。
$ git clone https://github.com/yudozen/dop_c02_cloudformation.git
$ cd dop_c02_cloudformation
$ git submodule init
$ git submodule update

### 最小権限の原則にのっとったアクセスキーを`.env.secret`に指定します。
$ cp .env.secret.example .env.secret
$ vi .env.secret

### Dockerイメージを作成します。
$ make build

### AWSへの認証を確認します。
$ make test_aws

### CloudFormationスタックを作成します。
$ make create

### S3バケットが作成されたことを確認します。
$ make check

### CloudFormationスタックを削除します。
# make delete
```

#

```
git submodule add https://github.com/yudozen/terraform_container.git ./submodule/terraform_container
git submodule init
git submodule update
```