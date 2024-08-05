resource "aws_api_gateway_vpc_link" "vpc_link" {
  name        = "my-vpc-link"
  target_arns = [aws_lb.nlb.arn]
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "aula-api"
  description = "API para listar aulas"
}

resource "aws_api_gateway_resource" "aulas" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "aulas"
}

resource "aws_api_gateway_method" "get_aulas" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.aulas.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_aulas" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.aulas.id
  http_method             = aws_api_gateway_method.get_aulas.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "http://${aws_lb.nlb.dns_name}:8081/aulas"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.vpc_link.id
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on  = [aws_api_gateway_integration.get_aulas]
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
}
