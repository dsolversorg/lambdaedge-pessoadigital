module "lambda_edge" {
  source = "./module"
  name   = "lambda-edge-pessoadigital"
  bucket = "sites.pessoadigital.digitalsolvers.com"
  domain = "*.digitalsolvers.com"
  aliases = ["pessoadigital.digitalsolvers.com"]
}