# Simple-Combine-and-SwiftUI-Showcase

## Objetivo
Este APP foi apresentado aos desenvolvedores para iOS da [@Via](https://github.com/viavarejo), com o objetivo de demonstrar como Combine e SwiftUI se encaixariam no padrão arquitetural existente, além de apresentar alguns conceitos básicos destes Frameworks.

## Como rodar
Para rodar este APP criamos uma API mock utilizando o [Mockoon](https://mockoon.com/). Pode-se criar os mesmos endpoints com as mesmas configurações utilizando o seguinte JSON:

```JSON
{
    "uuid": "ae4534ab-d236-4bb5-84a1-7df48ce1becf",
    "lastMigration": 20,
    "name": "Demo API",
    "endpointPrefix": "",
    "latency": 0,
    "port": 3000,
    "hostname": "0.0.0.0",
    "routes": [
        {
            "uuid": "84027f32-231d-45c1-9f41-dec02d08e1be",
            "documentation": "Generate random body (JSON, text, CSV, etc) with templating",
            "method": "get",
            "endpoint": "address/all",
            "responses": [
                {
                    "uuid": "51feae64-344b-4451-a74e-9f0620af7b71",
                    "body": "[\n  {\n    \"id\": \"1\",\n    \"title\": \"Casa\",\n    \"street\": \"Avenida Saturnino de Brito\",\n    \"number\": \"46\",\n    \"district\": \"Vila Jardim\",\n    \"city\": \"Porto Alegre\",\n    \"state\": \"RS\",\n    \"zipCode\": \"91320970\"\n  },\n  {\n    \"id\": \"2\",\n    \"title\": \"Casa 2\",\n    \"street\": \"Rua Lagoa Tramandaí\",\n    \"number\": \"10\",\n    \"district\": \"Santo Onofre\",\n    \"city\": \"Viamão\",\n    \"state\": \"RS\",\n    \"zipCode\": \"94445755\"\n  },\n  {\n    \"id\": \"3\",\n    \"title\": \"Casa 3\",\n    \"street\": \"Rua Vereador José Pederzoli Sobrinho\",\n    \"number\": \"20\",\n    \"district\": \"Porto\",\n    \"city\": \"Pelotas\",\n    \"state\": \"RS\",\n    \"zipCode\": \"96076250\"\n  }\n]",
                    "latency": 0,
                    "statusCode": 200,
                    "label": "Returns three addresses",
                    "headers": [],
                    "filePath": "",
                    "sendFileAsBody": false,
                    "rules": [],
                    "rulesOperator": "OR",
                    "disableTemplating": false,
                    "fallbackTo404": false,
                    "default": false
                },
                {
                    "uuid": "8a0ee3bb-e83f-4856-a241-fdd1bcb38786",
                    "body": "[]",
                    "latency": 0,
                    "statusCode": 200,
                    "label": "Returns empty array",
                    "headers": [],
                    "filePath": "",
                    "sendFileAsBody": false,
                    "rules": [],
                    "rulesOperator": "OR",
                    "disableTemplating": false,
                    "fallbackTo404": false,
                    "default": false
                }
            ],
            "enabled": true,
            "randomResponse": false,
            "sequentialResponse": true
        },
        {
            "uuid": "cdd182dc-c543-4f3e-9b67-9ee1940d3592",
            "documentation": "",
            "method": "put",
            "endpoint": "address/edit",
            "responses": [
                {
                    "uuid": "b4172ebc-7a5b-4119-a46b-8aa57891c753",
                    "body": "",
                    "latency": 0,
                    "statusCode": 200,
                    "label": "",
                    "headers": [],
                    "filePath": "",
                    "sendFileAsBody": false,
                    "rules": [],
                    "rulesOperator": "OR",
                    "disableTemplating": false,
                    "fallbackTo404": false,
                    "default": true
                },
                {
                    "uuid": "6c9688f4-5d5a-44ed-bd0b-9f131d25fde3",
                    "body": "",
                    "latency": 0,
                    "statusCode": 403,
                    "label": "",
                    "headers": [],
                    "filePath": "",
                    "sendFileAsBody": false,
                    "rules": [],
                    "rulesOperator": "OR",
                    "disableTemplating": false,
                    "fallbackTo404": false,
                    "default": false
                }
            ],
            "enabled": true,
            "randomResponse": false,
            "sequentialResponse": true
        }
    ],
    "proxyMode": false,
    "proxyHost": "",
    "proxyRemovePrefix": false,
    "tlsOptions": {
        "enabled": false,
        "type": "CERT",
        "pfxPath": "",
        "certPath": "",
        "keyPath": "",
        "caPath": "",
        "passphrase": ""
    },
    "cors": true,
    "headers": [
        {
            "key": "Content-Type",
            "value": "application/json"
        }
    ],
    "proxyReqHeaders": [
        {
            "key": "",
            "value": ""
        }
    ],
    "proxyResHeaders": [
        {
            "key": "",
            "value": ""
        }
    ]
}
```
