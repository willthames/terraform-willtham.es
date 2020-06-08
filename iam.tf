resource "aws_iam_user" "willtham_es_ci_s3" {
  name = "willtham.es-ci"
}

resource "aws_iam_user_policy_attachment" "willtham_es_ci_s3" {
  user = aws_iam_user.willtham_es_ci_s3.name
  policy_arn = aws_iam_policy.willtham_es_ci_s3.arn
}

resource "aws_iam_policy" "willtham_es_ci_s3" {
  name   = "willtham.es-ci"
  policy = data.aws_iam_policy_document.willtham_es_ci_s3.json
}

data "aws_iam_policy_document" "willtham_es_ci_s3" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]

    resources = [
      "${aws_s3_bucket.willtham_es.arn}*",
    ]
  }
}

