locals {
  s3_origin_id = "willtham.es"
}

resource "aws_cloudfront_origin_access_identity" "willtham_es" {
  comment = "willtham.es built by Terraform"
}

resource "aws_cloudfront_distribution" "willtham_es" {
  origin {
    domain_name = aws_s3_bucket.willtham_es.website_endpoint
    origin_id   = local.s3_origin_id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled         = true
  is_ipv6_enabled = true
  comment         = "willtham.es built by Terraform"

  logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.willtham_es_logs.bucket_domain_name
    prefix          = "cloudfront"
  }

  aliases = ["willtham.es"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      headers      = ["Origin"]
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_200"

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate_validation.willtham_es.certificate_arn
    ssl_support_method  = "sni-only"
  }
}

