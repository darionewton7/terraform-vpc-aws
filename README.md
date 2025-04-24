# 🚀 terraform-vpc-aws

Provisionamento de uma infraestrutura na AWS utilizando **Terraform**, com foco na criação de uma **VPC personalizada** e recursos associados como sub-redes, instâncias de cluster e automação com boas práticas de DevOps.

---

## 📘 Visão Geral

Este projeto tem como objetivo provisionar uma VPC na AWS com múltiplos recursos de rede e orquestração, usando **Infrastructure as Code (IaC)** com o Terraform.

O projeto contempla:

- Criação de VPC personalizada
- Sub-redes públicas e privadas
- Configuração de instâncias (ex: nodes de cluster)
- Separação de variáveis e estados
- Estrutura modular e limpa para reuso
- Suporte a múltiplos ambientes (via `.tfvars`)

---

## 📂 Estrutura dos Arquivos

| Arquivo                     | Descrição |
|----------------------------|-----------|
| `vpc.tf`                   | Criação da VPC principal |
| `cluster.tf`               | Definições para criação do cluster |
| `nodes.tf`                 | Provisionamento de instâncias/nodes |
| `providers.tf`             | Configuração do provider AWS |
| `outputs.tf`               | Exporta os outputs do Terraform |
| `terraform.tfvars`         | Definições de variáveis personalizadas |
| `varieble.tf`              | Declaração das variáveis usadas |
| `terraform.tfstate`        | Estado da infraestrutura (não versionado) |
| `terraform.tfstate.backup` | Backup do estado da infraestrutura |
| `kubeconfig-...`           | Arquivo de configuração do cluster Kubernetes |
| `.gitignore`               | Ignora arquivos sensíveis e de cache |
| `.terraform.lock.hcl`      | Lockfile para versionamento seguro de providers |

---
