provider "aws" {
  region = "eu-central-1"
  access_key = "AKIA6GRE36CT4NJHBOQG"
  secret_key = "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"
}

terraform{

   
  backend "s3" {
    bucket = "autodesk-infra-state"
    key    = "autodesk-infra-key.tfstate"
    region = "eu-central-1"
    dynamodb_table = "autodesk-infra-lock"
  }

}