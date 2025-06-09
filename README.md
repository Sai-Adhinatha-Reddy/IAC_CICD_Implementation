# IAC_CICD_Implementation

Before running the pipeline create the s3 bucket and DynamoDB table:

**S3 Bucket:**

Name: terraform-s3

**DynamoDB:**

Table_Name: terraform-lock

Partition key: LockID (type: String)
