module "s3_bucket" {
  source = "./modules/s3-config"
  bucket_name = "tf-s3-bucket-test-module"
}


module "ec2_instance" {
  source = "./modules/ec2-config"
  name = "test"
}