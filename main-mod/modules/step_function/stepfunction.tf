
module "step_function" {
  source = "terraform-aws-modules/step-functions/aws"

  name       = "${var.env_name}-step-function"
  definition = <<EOF
{
  "Comment": "CRA processing",
  "StartAt": "create-db-entries",
  "States": {
    "create-db-entries": {
      "Type": "Task",
      "Resource": "${var.db_lambda_arn}",
      "Next": "call-equifax"
    },
    "call-equifax": {
      "Type": "Task",
      "Resource": "${var.equifax_lambda_arn}",
      "Next": "call-gbg"
    },
    "call-gbg": {
      "Type": "Task",
      "Resource": "${var.gbg_lambda_arn}",
      "Next": "cleanup"
    },
    "cleanup": {
      "Type": "Task",
      "Resource": "${var.cleanup_lambda_arn}",
      "End": true
    }
  }
}
EOF

  service_integrations = {
    lambda = {
      lambda = ["${var.db_lambda_arn}", "${var.equifax_lambda_arn}", "${var.gbg_lambda_arn}", "${var.cleanup_lambda_arn}"]
    }
  }

  type = "STANDARD"

  tags = {
    Module = "my"
  }
}
