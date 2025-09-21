resource "aws_s3_bucket" "avatars" {
  bucket = "grocerymate-avatars-mahnoosh1409"

  tags = {
    Name        = "grocerymate-avatars"
    Environment = "Dev"
  }
}