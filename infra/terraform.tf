variable "lambda_function_name" {
  default = "alexa_skill_template"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "default" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "default" {
  function_name = "${var.lambda_function_name}"
  filename = "build/skill.zip"
  source_code_hash = "${base64sha256(file("build/skill.zip"))}"
  role = "${aws_iam_role.default.arn}"
  handler = "index.handler"
  runtime = "nodejs4.3"
}

resource "aws_lambda_permission" "default" {
  statement_id  = "AllowExecutionFromAlexa"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.default.function_name}"
  principal = "alexa-appkit.amazon.com"
}

output "lambda_function_arn" {
  value = "${aws_lambda_function.default.arn}"
}
