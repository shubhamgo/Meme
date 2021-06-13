provider "aws" {
  region = "eu-central-1"
  access_key = "AKIA6GRE36CT6XVR23JL"
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