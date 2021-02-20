resource "aws_dynamodb_table" "dynamo-table" {
  name         = "${var.db_name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "name"
  attribute {
    name = "name"
    type = "S"
  }
  server_side_encryption {
    enabled     = true
    # kms_key_arn = aws_kms_key.dynamodb_encryption_key.arn
    # kms_key_arn = aws_kms_key.dynamodb_encryption_key.arn
  }
}