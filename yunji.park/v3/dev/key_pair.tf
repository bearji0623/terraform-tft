module "key_pair" {
    source = "../module/key_pair"

    # Key Pair Name
    key_name = "${var.service}-${var.env}"

    # PEM File Name
    key_file_name = "${var.service}-${var.env}.pem"
}