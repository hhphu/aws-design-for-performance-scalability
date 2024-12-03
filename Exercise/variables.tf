variable "subnet_id"{
	type = string
	description = "The Id of the subnets where EC2 intances are created"
	default = "subnet-09ec81a6d0cd51fab"
}

variable "ec2_image"{
	type = string
	description = "The images used for creating EC2 intance. This image is Ubuntu"
	default = "ami-0866a3c8686eaeeba"
}

variable "lambda_function_name" {
	type = string
	description = "The name of the Lambda function"
	default = "greet_lambda"
}