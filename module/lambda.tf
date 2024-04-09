data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = [
                      "lambda.amazonaws.com", 
                      "edgelambda.amazonaws.com"
                    ]
    }

    actions = ["sts:AssumeRole"]
  }
}


resource "aws_iam_role" "iam_for_lambda" {
  name               = join("-", ["role-lambda", var.name])
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = var.source_file 
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = join("-", ["function", var.name])
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.handler
  publish       = true
  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = var.runtime
}

