provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_key_pair" "chavo" {
  key_name   = "chavo"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "web" {
  ami           = "ami-03e261022a6446f10"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.chavo.id}"

  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "file" {
    source      = "asset"
    destination = "/tmp"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/asset/setup-web.sh",
      "sudo /tmp/asset/setup-web.sh",
    ]
  }
}
