output "alb_dns_name_id" {
    value = aws_alb.juno-alb-web-pub.dns_name
}

output "alb_zone_id" {
    value = aws_alb.juno-alb-web-pub.zone_id
}

output "alb_web_id" {
    value = aws_alb.juno-alb-web-pub.id
}