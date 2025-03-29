import requests
from bs4 import BeautifulSoup
import wget

class Scraping:
    def __init__(self):
        self.page_request = requests.get("https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos")
        
        self.page_data = BeautifulSoup(self.page_request.content, "html.parser")

        self.get_main_class = self.page_data.find_all("a", class_="internal-link")

        self.main()

    def download_file(self, url, file_name):
        response = requests.get(url, stream=True)

        if response.status_code == 200:
            with open(file_name, 'wb') as file:
                for chunk in response.iter_content(chunk_size=8192):
                    file.write(chunk)
            print(f"Arquivo {file_name} baixado com sucesso!")
        else:
            print(f"Falha ao baixar o arquivo: {url}")
        
    def get_links(self, class_name):
        count = 1
        for attribute in class_name:
            href = attribute.get("href")
            
            if href.endswith(".pdf") and "anexo" in href.lower():
                file_name = f"Anexo_{count}.pdf"
                self.download_file(href, file_name)
                count += 1    
    
    def main(self):
        self.get_links(self.get_main_class)

scraping = Scraping()