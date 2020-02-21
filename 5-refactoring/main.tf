//provider "aws" {
//  region = "us-west-2"
//}
//
//resource "random_pet" "this" {
//  length = 2
//}
//
//resource "aws_devicefarm_project" "this" {
//  name = random_pet.this.id
//}
//
//output "this_devicefarm_project_arn" {
//  value = aws_devicefarm_project.this.arn
//}
