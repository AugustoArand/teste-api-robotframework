# Robot Framework API Testing

[![Robot Framework Tests](https://github.com/AugustoArand/robot-poetry-api/actions/workflows/robot-tests.yml/badge.svg)](https://github.com/AugustoArand/robot-poetry-api/actions/workflows/robot-tests.yml)
[![Code Quality Check](https://github.com/AugustoArand/robot-poetry-api/actions/workflows/quality-check.yml/badge.svg)](https://github.com/AugustoArand/robot-poetry-api/actions/workflows/quality-check.yml)

Projeto de testes automatizados de API usando Robot Framework com Poetry.

## 🚀 Configuração do Ambiente

### Pré-requisitos
- Python 3.12 ou superior
- Poetry

### Instalação
```bash
# Instalar dependências
poetry install

# Ativar ambiente virtual
poetry shell

# Ou usar diretamente
poetry run robot --version
```

## 🧪 Executando Testes

### Comandos Locais - Poetry
```bash
# Ativar o ambiente virtual
poetry env activate

# Verificar se o ambiente está ativo
poetry env info

# Rodar teste simples
poetry run robot test.robot

# Rodar suíte de testes
poetry run robot Suite/

# Rodar testes com relatórios personalizados
poetry run robot --outputdir results --report report.html --log log.html Suite/

# Rodar testes com tags específicas
poetry run robot --include post_order Suite/
```

### Testes de Qualidade
```bash
# Verificar sintaxe dos arquivos Robot
poetry run robot --dryrun --output NONE --report NONE --log NONE Suite/

# Análise de código com RoboCop
poetry run robocop Suite/ Resources/

# Instalar dependências de desenvolvimento
poetry install --extras dev
```

## 🔄 Integração Contínua (GitHub Actions)

Este projeto está configurado com três workflows do GitHub Actions:

### 1. **Robot Framework Tests** (`robot-tests.yml`)
- **Trigger**: Push e Pull Request para `main` e `develop`
- **Função**: Executa todos os testes automatizados
- **Artefatos**: Relatórios HTML e XML dos testes

### 2. **Advanced Tests** (`advanced-tests.yml`)
- **Trigger**: Agendamento diário (2:00 AM UTC) e execução manual
- **Função**: Testes em múltiplos sistemas operacionais e versões do Python
- **Matriz**: Ubuntu, Windows, macOS com Python 3.12 e 3.13

### 3. **Code Quality Check** (`quality-check.yml`)
- **Trigger**: Push e Pull Request para `main` e `develop`
- **Função**: Análise de qualidade de código e verificação de sintaxe
- **Ferramentas**: RoboCop, Robot Framework Lint

## 📊 Relatórios e Artefatos

Os workflows geram automaticamente:
- Relatórios HTML dos testes
- Logs detalhados de execução
- Arquivos XML para integração com ferramentas de CI/CD
- Relatórios de qualidade de código

## 🛠️ Configuração no GitHub

Para usar este projeto no GitHub:

1. **Substitua `SEU_USUARIO`** nos badges do README pelo seu usuário do GitHub
2. **Configure os secrets** se necessário (para testes que precisam de API keys)
3. **Ajuste os branches** nos workflows conforme sua estratégia de branching

## 📁 Estrutura do Projeto

```
├── .github/workflows/       # Workflows do GitHub Actions
├── Resources/              # Recursos reutilizáveis
│   ├── asserts/           # Validações
│   ├── requests/          # Requisições HTTP
│   ├── session/           # Gerenciamento de sessão
│   └── test_data/         # Dados de teste
├── Suite/                 # Suítes de teste
├── results/              # Resultados dos testes (ignorado pelo Git)
├── pyproject.toml        # Configurações do Poetry e RoboCop
└── .gitignore           # Arquivos ignorados pelo Git
```

## 🔧 Personalização

### Adicionando Novos Testes
1. Crie novos arquivos `.robot` na pasta `Suite/`
2. Use recursos da pasta `Resources/` para reutilização
3. Adicione tags apropriadas para organização

### Configurando Ambientes
- Modifique as variáveis nos workflows para diferentes ambientes
- Use secrets do GitHub para informações sensíveis
- Ajuste a matriz de testes conforme necessário

## 📈 Monitoramento

- **GitHub Actions**: Monitore execuções na aba Actions do repositório
- **Badges**: Acompanhe status no README
- **Artefatos**: Download de relatórios detalhados após cada execução