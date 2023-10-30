resource "aws_s3_bucket" "s3_bucket" {
  bucket = "test-s3-bucket-devops"
  tags = {
    name = "Test"
    Environment = "Test"
  }
}