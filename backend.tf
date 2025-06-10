terraform {
  backend "s3" {
    bucket         = "terraform-adhinatha-s3"  # The S3 bucket name
    key            = "terraform/state.tfstate" # Path to the state file inside the bucket
    region         = "us-east-1"               # Must match your S3 bucket's region
    encrypt        = true                      # Encrypt the state file at rest
    dynamodb_table = "terraform-lock"          # Optional for state locking
  }
}
