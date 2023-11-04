# terraform-eks-cluster

## Usage


```
terraform apply -var-file my.tfvars
```

## my.tfvars

```cluster_role_name = "eksClusterRole"
node_role_name = "eksNodeRole"
cluster_name = "cluster1"
cluster_version = "1.27"
```
