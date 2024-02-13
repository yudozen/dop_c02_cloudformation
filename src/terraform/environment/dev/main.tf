terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

module "iam" {
    source = "../../module/iam"
    name = "cloudformation_s3"
}
