output "web_sec_grp_id" {
    value = aws_security_group.web.id
}

output "app_sec_grp_id" {
    value = aws_security_group.app.id
}

output "rds_sec_grp_id" {
    value = aws_security_group.rds.id
}

output "web_elb_sec_grp_id" {
    value = aws_security_group.elb_web.id
}

output "app_elb_sec_grp_id" {
    value = aws_security_group.elb_app.id
}