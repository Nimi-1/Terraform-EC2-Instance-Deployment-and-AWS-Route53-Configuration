module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.cidr_block
  project-name = var.project-name
}

module "ec2" {
  source = "./modules/ec2"
  project-name = var.project-name
  instance-type = var.instance_type
  public_sg_id = module.sg.public_sg_id
  public_subnet1_id = module.vpc.public_subnet1_id
  public_subnet2_id = module.vpc.public_subnet2_id
  public_subnet3_id = module.vpc.public_subnet3_id
}

module "sg" {
    source = "./modules/sg"
    project-name = var.project-name
    vpc_id = module.vpc.vpc_id
} 
module "lb" {
  source = "./modules/lb"
  lb_name = var.lb_name
  target-group-name = var.target-group-name
  lb_type = var.lb_type
  load_balancer_sg = module.sg.load_balancer_sg
  public_subnet1_id = module.vpc.public_subnet1_id
  public_subnet2_id = module.vpc.public_subnet2_id 
  public_subnet3_id = module.vpc.public_subnet3_id
  vpc_id = module.vpc.vpc_id
  pub-ec2-instance1-id = module.ec2.pub-ec2-instance1-id
  pub-ec2-instance2-id = module.ec2.pub-ec2-instance2-id
  pub-ec2-instance3-id = module.ec2.pub-ec2-instance3-id
}
module "r53" {
  source = "./modules/r53"
  domain_name = var.domain_name
  sub_domain_name = var.sub_domain_name
  load_balancer-dns-name = module.lb.load_balancer-dns-name
  load_balancer-zone-id = module.lb.load_balancer-zone-id
}