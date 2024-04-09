variable "name" {
  default = ""
}

variable "runtime" {
  default = "python3.12"
}

variable "handler" {
  default = "lambda_function.lambda_handler"
}

variable "source_file" {
  default = "./code/lambda_function.py"
}

variable "bucket" {
  default = ""
}

variable "domain" {
  default = ""
}

variable "default_root_object" {
  default = "index.html"
}

variable "allowed_methods" {
  default = ["GET", "HEAD", "OPTIONS"]
}

variable "viewer_protocol_policy" {
  default = "redirect-to-https"
}

variable "aliases" {
  default = []
}

variable "comment" {
  default = "redirect path"
}