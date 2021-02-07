terraform {
  backend "s3" {
    bucket = "deployments-state"
    key    = "terraform-state/ccgen-test"
    region = "us-east-1"
  }
}
