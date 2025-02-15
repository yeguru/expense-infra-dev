variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = "true"
    }
}


variable "zone_id" {
    default = "Z06508112VPXSCQX7ADNT"
}

variable "domain_name" {
    default = "rajaws82s.shop"
}