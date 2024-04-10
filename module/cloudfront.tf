resource "aws_cloudfront_origin_access_control" "default" {
  name                              = var.bucket
  description                       = "Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = data.aws_s3_bucket.domain_name.bucket_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = data.aws_s3_bucket.bucket.id
    
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.comment
  default_root_object = var.default_root_object


  aliases = var.aliases

  default_cache_behavior {
    cache_policy_id  = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    allowed_methods  = var.allowed_methods
    #cached_methods   = ["GET", "HEAD"]
    target_origin_id = data.aws_s3_bucket.bucket.id

    #forwarded_values {
    #  query_string = false
    #
    #  cookies {
    #    forward = "none"
    # }

    }

    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = aws_lambda_function.lambda.qualified_arn
      include_body = false
    }
      
      

    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  #restrictions {
  #  geo_restriction {
  #    restriction_type = "none"
  #    locations = []
  # }
  #}

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
    acm_certificate_arn = data.aws_acm_certificate.issued.arn
  }
}