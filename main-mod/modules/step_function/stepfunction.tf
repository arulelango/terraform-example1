
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
    # dynamodb = {
    #   dynamodb = ["arn:aws:dynamodb:eu-west-1:052212379155:table/Test"]
    # }

    lambda = {
      lambda = ["${var.db_lambda_arn}", "${var.equifax_lambda_arn}", "${var.gbg_lambda_arn}", "${var.cleanup_lambda_arn}"]
    }
  }

  type = "STANDARD"

  tags = {
    Module = "my"
  }
}

resource "null_resource" "ConfigureAnsibleLabelVariable" {
  provisioner "local-exec" {
    command = "( echo [DEFAULT]; echo  ${var.env_name}-stepfunction-arn=${module.step_function.this_state_machine_arn} ) > ./../src/cra-integration/input-processor/${var.env_name}-config.txt"
  }

  # provisioner "local-exec" {
  #   command = "echo  ${var.env_name}-stepfunction-arn=${module.step_function.this_state_machine_arn} > ./../src/cra-integration/input-processor/config.txt"
  # }
}