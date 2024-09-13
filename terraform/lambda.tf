data "archive_file" "lambda" {
  type = "zip"

  source_dir  = "../${path.module}/lambda"
  output_path = "../${path.module}/lambda.zip"
}

resource "aws_lambda_function" "function" {
  function_name = "function"
  runtime       = "nodejs16.x"
  handler       = "function.handler"

  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256

  role = aws_iam_role.lambda_exec.arn

  vpc_config {
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = ["${aws_security_group.service.id}"]
  }

  environment {
    variables = {
      DB_CONNECTION_STRING = "mongodb://${aws_docdb_cluster.service.master_username}:${aws_docdb_cluster.service.master_password}@${aws_docdb_cluster.service.endpoint}:${aws_docdb_cluster.service.port}"
    }
  }
}