terraform {
  backend "s3" {
    bucket = "ktsuruta-test"
    key    = "tf/simple-server01/terraform.tfstate"
    region = "jp-north-1"
    access_key = "J6H3Z5UESTIWCQY1OE30"
    secret_key = "wFKk5YMMp1/=a5BMDdY1y6+XEwHXhUx3k4tS4Th+"
    endpoints = { 
	s3 = "https://s3.isk01.sakurastorage.jp" 
    }
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
#    skip_s3_checksum            = true
  }
  required_providers {
    sakuracloud = {
      source = "sacloud/sakuracloud"

      # We recommend pinning to the specific version of the SakuraCloud Provider you're using
      # since new versions are released frequently
      version = "2.17.0"
      #version = "~> 2"
    }
  }
}
provider "sakuracloud" {
  # More information on the authentication methods supported by
  # the SakuraCloud Provider can be found here:
  # https://docs.usacloud.jp/terraform/provider/

  #  profile = "default"
  profile = "ytv24336_support1"
}
