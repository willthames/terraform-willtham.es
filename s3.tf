data "aws_iam_policy_document" "willtham_es" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.willtham_es.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.willtham_es.arn]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "willtham_es" {
  bucket = aws_s3_bucket.willtham_es.id
  policy = data.aws_iam_policy_document.willtham_es.json
}

resource "aws_s3_bucket" "willtham_es" {
  bucket = "willtham.es"
  website {
    index_document = "index.html"
  }
  acl = "public-read"
}

resource "aws_s3_bucket" "willtham_es_logs" {
  bucket = "willtham.es-logs"
  provider = aws.us-east-1
}
