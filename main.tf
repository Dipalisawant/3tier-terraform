
# ---- VPC ----
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "main-vpc"
  }
}

# ---- Subnets ----
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1a"  # AZ 1
  map_public_ip_on_launch = false
}

resource "aws_subnet" "private2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-south-1b"  # AZ 2
  map_public_ip_on_launch = false
}
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "web1" {
  ami           = "ami-0f9708d1cd2cfee41"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]  # Use .id
  key_name      = "one"
}

resource "aws_instance" "web2" {
  ami           = "ami-0f9708d1cd2cfee41"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]  # Use .id
  key_name      = "one"
}
# ---- DB Subnet Group ----
resource "aws_db_subnet_group" "db_subnet" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]  # Must include both subnets

  tags = {
    Name = "my-db-subnet-group"
  }
}


# ---- RDS MySQL Instance ----
resource "aws_db_instance" "db" {
  identifier              = "mydb"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.db_subnet.name
  skip_final_snapshot     = true
  publicly_accessible     = false

  tags = {
    Name = "mysql-db"
  }
}



