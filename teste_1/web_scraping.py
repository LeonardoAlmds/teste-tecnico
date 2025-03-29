import requests
from bs4 import BeautifulSoup

class Scraping:
    def __init__(self):
        # URL para fazer o scraping
        self.page_request = requests.get("https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos")
        
        # Faz o parse do conteudo html
        self.page_data = BeautifulSoup(self.page_request.content, "html.parser")

        self.get_main_class = self.page_data.find_all("a", class_="internal-link")

        self.main()
    
    def get_links(self, class_name):
        for attribute in class_name:
            href = attribute.get("href")
            
            if href.endswith(".pdf") and "anexo" in href.lower():
                print(href)

    def main(self):
        self.get_links(self.get_main_class)


scraping = Scraping()