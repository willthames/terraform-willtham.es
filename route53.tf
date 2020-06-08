data "aws_route53_zone" "willtham_es" {
  name = "willtham.es"
}

resource "aws_route53_record" "willtham_es" {
  zone_id = data.aws_route53_zone.willtham_es.zone_id
  name    = "willtham.es"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.willtham_es.domain_name
    zone_id                = aws_cloudfront_distribution.willtham_es.hosted_zone_id
    evaluate_target_health = false
  }
}
