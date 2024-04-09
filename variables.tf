variable "regions" {
  description = "A map of regions where resources will be created"
  type        = map(string)
  default     = {
    "west_eu" = "West Europe",
    "east_us" = "East US",
    "southeast_asia" = "Southeast Asia"
  }
}
