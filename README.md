# 📌 Teste Técnico

## 🚀 Etapas do Projeto

### 📝 Teste 1: Web Scraping
No primeiro teste, utilizei **BeautifulSoup** e **Requests** para realizar o scraping, pois são bibliotecas mais leves e rápidas que outras soluções como Selenium. Selenium é mais utilizado quando há necessidade de interação com páginas dinâmicas, o que não era o caso aqui.

- **BeautifulSoup**: Facilita a extração de dados estruturados em HTML/XML.
- **Requests**: Permite fazer requisições HTTP de forma simples e eficiente.
- **Zipfile**: Utilizei esta biblioteca pois, diferente de shutil, permite compactar múltiplos arquivos de uma vez.

### 📊 Teste 2: Processamento de Dados
No segundo teste, foi necessário manipular arquivos de planilhas e PDFs. Para isso, utilizei:

- **Pandas**: Biblioteca essencial para manipulação e análise de dados tabulares.
- **pdfplumber**: Uma das bibliotecas mais rápidas para extração de tabelas em PDFs.
- **Zipfile**: Mantive o uso do Zipfile pela sua praticidade na compactação dos arquivos processados.

O desafio aqui foi processar arquivos grandes de forma eficiente, garantindo que os dados extraídos fossem otimizados antes de serem armazenados.

### 🛠️ Teste 3: Tratamento de Dados com SQL
No terceiro teste, realizei todo o tratamento dos dados utilizando apenas SQL, conforme solicitado no desafio. Isso incluiu:

- Análise das planilhas para entender a estrutura dos dados.
- Definição de tipos de colunas e normalização dos dados.
- Remoção de espaços vazios e substituição de valores nulos por "S/N".
- Aplicação de regras específicas do desafio para limpeza e validação dos dados.

### 🔥 Teste 4: Desenvolvimento do Backend com FastAPI
O backend foi construído utilizando **FastAPI**, uma biblioteca moderna e eficiente para criação de APIs. A escolha do FastAPI se deu por sua:

- **Facilidade de uso**: Simples de configurar e implementar.
- **Alto desempenho**: Consideravelmente mais rápido que Flask em benchmarks.
- **Documentação Automática**: Gera a documentação da API automaticamente via Swagger UI e Redoc.

No backend, foram criadas as seguintes rotas para buscar os dados:

#### Endpoints Disponíveis:
- `GET /buscar/todos`: Retorna todos os operadores disponíveis na base de dados.
- `GET /buscar/nome_fantasia-razao_social?q=`: Realiza uma busca por Razão Social ou Nome Fantasia, filtrando os resultados conforme o termo informado.

A implementação também inclui tratamento de erros para garantir a estabilidade da API.

### 🎨 Desenvolvimento do Frontend
Para o frontend, utilizei:

- **Vue.js**: Framework reativo e performático para interfaces web.
- **Axios**: Biblioteca para realizar requisições HTTP de forma simples.
- **CSS Puro**: Estilização personalizada para manter uma identidade visual própria.

A interface permite que os usuários filtrem, pesquisem e visualizem detalhes sobre os operadores cadastrados.

