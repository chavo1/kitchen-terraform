output "public_ip" {
  value = "${aws_instance.web.public_ip}"
}

output "address" {
  value = "${aws_instance.web.public_dns}"
}
