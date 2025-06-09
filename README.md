# IAC_CICD_Implementation

Before running the pipeline create the s3 bucket and DynamoDB table:

**S3 Bucket:**
/n Name: terraform-s3

**DynamoDB:**
/n Table_Name: terraform-lock
/n Partition key: LockID (type: String)
