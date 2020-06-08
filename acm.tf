resource "aws_acm_certificate" "willtham_es" {
  domain_name       = "willtham.es"
  validation_method = "DNS"
  provider          = aws.us-east-1
}

resource "aws_route53_record" "cert_validation" {
  name    = aws_acm_certificate.willtham_es.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.willtham_es.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.willtham_es.zone_id
  records = [aws_acm_certificate.willtham_es.domain_validation_options.0.resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "willtham_es" {
  certificate_arn         = aws_acm_certificate.willtham_es.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
  provider                = aws.us-east-1
}
