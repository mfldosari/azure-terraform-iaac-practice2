output "public_ip_address" {
  description = "The public IP address assigned to the network interface"
  value       = module.network.public_ip_address
}