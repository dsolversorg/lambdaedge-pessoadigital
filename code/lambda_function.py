import json

def lambda_handler(event, context):
    # Lista de nomes para os quais serão definidas as regras de redirecionamento
    names = [
                'assets',
                'cart',
                'dengue',
                'ferring',
                'moderna',
                'mps',
                'wama',
                'mrna',
                'metadoctors'
                'mps-eng'
            ]
    
    # Dicionário com as regras de redirecionamento
    redirect_rules = {}
    for name in names:
        redirect_rules[f'/{name}'] = f'https://pessoadigital.digitalsolvers.com/{name}/index.html'
        redirect_rules[f'/{name}/'] = f'https://pessoadigital.digitalsolvers.com/{name}/index.html'

    # Adicionando a regra padrão para '/'
    redirect_rules['/'] = 'https://www.digitalsolvers.com/'

    # Obtendo o request do evento CloudFront
    request = event['Records'][0]['cf']['request']

    # Definindo o URI solicitado
    uri = request['uri']

    # Verificando se o URI está nas regras de redirecionamento
    if uri in redirect_rules:
        # Configurando a resposta para redirecionamento
        response = {
            'status': '301',
            'statusDescription': 'Moved Permanently',
            'headers': {
                'location': [{
                    'key': 'Location',
                    'value': redirect_rules[uri]
                }]
            }
        }
        return response

    # Se não for um dos URIs de redirecionamento, retorna o request original
    return request
