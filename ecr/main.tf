resource "aws_ecr_repository" "metabank-ecr" {
  name                 = "metabank-ecr"
  image_tag_mutability = "MUTABLE" # 이미지 태그의 변경 가능성 설정
  image_scanning_configuration {
    scan_on_push = true # 이미지 푸시 시 자동으로 스캔하는 설정
  }
}

resource "aws_ecr_repository_policy" "ecr-policy" {
  repository = aws_ecr_repository.metabank-ecr.name
  policy     = data.aws_iam_policy_document.ecr-policy.json
}