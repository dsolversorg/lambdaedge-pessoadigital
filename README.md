## lambda-edge-redirect-path

```
#main.tf
module "lambda_edge" {
  source = "./module"
  name   = "lambda-edge" # adicionar o nome da lambda
  bucket = "opsteam-helm-charts" # adicionar o nome do bucket para origin no cloudfront
  domain = "*.ops.team" # adicionar o dominio para que seja encontrado o certificado no ACM
  aliases = ["teste.ops.team"] # lista de url que para CNAME no cloudfront
}
```

### Lista de path a serem redirecionados
Adicionar no arquivo code/lambda_function.py o path que deverá ser criado.

```
    names = [
                'ferring',
                'mps',
                'dengue',
                'teste'
            ]
```