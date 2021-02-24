provider "aws" {
  region = "${var.region}"
}

module "s3" {
  source = "./modules/s3"
  input_lambda_id = module.input-processor.input_lambda_arn
  iam_for_lambda_name = module.input-processor.iam_role_lambda_name
  env_name = "${var.env}"
}

# only when needed enable this
# ----------------------------
# module "database-dynamodb" {
#   source = "./../modules/dynamo_db/"
# }



module "input-db-lambda" {
  source = "./modules/db_entry_lambda"
  env_name = "${var.env}"
}

module "cra-equifax-lambda" {
  source = "./modules/cra_equifax_lambda"
  env_name = "${var.env}"
}

module "cra-gbg-lambda" {
  source = "./modules/cra_gbg_lambda"
  env_name = "${var.env}"
}

module "cleanup-lambda" {
  source = "./modules/cleanup_lambda"
  env_name = "${var.env}"
}


module "step_function" {
  source = "./modules/step_function"
  env_name = "${var.env}"
  db_lambda_arn = module.input-db-lambda.db_entry_lambda_arn
  equifax_lambda_arn = module.cra-equifax-lambda.cra_equifax_lambda_arn
  gbg_lambda_arn = module.cra-gbg-lambda.cra_gbg_lambda_arn
  cleanup_lambda_arn = module.cleanup-lambda.cleanup_lambda_arn
}

# make sure input-processor afer step-function??
module "input-processor" {
  source = "./modules/input_processor_lambda"
  env_name = "${var.env}"
  s3_input_bucket_arn = module.s3.input_s3_bucket_id
}



