resource "aws_s3_bucket" "jenkins_artifacts" {
  bucket = "jenkins-artifacts342r"
}

resource "aws_efs_file_system" "efs" {
  creation_token = "efs-token"
  performance_mode = "generalPurpose"
}

resource "aws_efs_mount_target" "efs_mount_target" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = var.private_subnets[0]
}

output "s3_bucket_name" {
  value = aws_s3_bucket.jenkins_artifacts.bucket
}
