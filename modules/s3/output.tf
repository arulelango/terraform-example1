output "input_s3_bucket_id" {
  value = "${aws_s3_bucket.bucket.arn}"
}