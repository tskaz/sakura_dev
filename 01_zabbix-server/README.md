# [Deproying Sample] さくらのクラウドでterraform - プライベート監視サーバ構築

## Deployment Summary
This codes are deploy that Monitioring server on Sakura CLoud IaaS based on Zabbix Server.

It is useful for deploying in a new environment using vpc-router or in an existing switch environment.

## Versions confirmed to work

|tools||
|---|---|
|terraform|1.9.3|
|opwnssh|1.8.9|

|terraform-providers||
|---|---|
|sacloud/sakuracloud|2.23.0|
|hashicorp/local|2.5.1|
|hashicorp/null|3.2.2|
|hashicorp/template|2.2.0|
|ojford/wireguard|0.3.1|


|OS/MW||
|---|---|
|AlmaLinux|9.3(cloud-img)|
|PostgreSQL|13.3|
|Zabbix|7.0.2(LTS)|

## Using Steps

1. clone to this codes.
~~~
git clone [giturl] [dirname]
~~~

2. edit variables.tf
~~~
vi variables.tf
~~~

note 

3. TF init/plan/apply
~~~
terraform init
terraform plan
terraform apply
~~~

4. Confirm Output (belowed sample)
~~~

~~~

