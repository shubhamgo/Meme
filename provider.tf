provider "aws" {
  region = "eu-central-1"
  access_key = "AKIA6GRE36CT3EPVWJGV"
  secret_key = "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"
}

terraform{

   
  backend "s3" {
    bucket = "tw-infra-state"
    key    = "TW-infra-key.tfstate"
    region = "eu-central-1"
    dynamodb_table = "TW-infra-lock"
  }

}