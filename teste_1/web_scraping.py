import os
import requests
from bs4 import BeautifulSoup
import zipfile

class Scraping:
    def __init__(self):
        self.page_request = requests.get(
            "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"
        )

        self.output_dir = "teste_1" 

        self.page_data = BeautifulSoup(self.page_request.content, "html.parser")
        self.get_main_class = self.page_data.find_all("a", class_="internal-link")
        self.files = []

        self.main()

    def download_file(self, url, file_name):
        try:
            file_path = os.path.join(self.output_dir, file_name) 
            print(f"Baixando {file_name}...")

            response = requests.get(url, stream=True, timeout=10)
            response.raise_for_status()

            with open(file_path, "wb") as file:
                for chunk in response.iter_content(chunk_size=8192):
                    file.write(chunk)

            print(f"Arquivo {file_name} baixado com sucesso!")
            self.files.append(file_path) 

        except requests.exceptions.RequestException as e:
            print(f"Erro ao baixar {file_name}: {e}")
        except IOError as e:
            print(f"Erro ao salvar o arquivo {file_name}: {e}")

    def get_links(self, class_name):
        print("Iniciando o download dos arquivos...")
        count = 1

        for attribute in class_name:
            href = attribute.get("href")

            if href and href.endswith(".pdf") and "anexo" in href.lower():
                file_name = f"Anexo_{count}.pdf"
                self.download_file(href, file_name)
                count += 1

    def compress_files(self):
        try:
            if not self.files:
                print("Nenhum arquivo para compactar.")
                return

            print("Compactando arquivos...")
            zip_filename = os.path.join(self.output_dir, "Anexos.zip")

            with zipfile.ZipFile(zip_filename, "w", zipfile.ZIP_DEFLATED) as zipf:
                for file in self.files:
                    zipf.write(file, os.path.basename(file)) 

            print(f"Arquivos compactados com sucesso em {zip_filename}!")

        except Exception as e:
            print(f"Erro ao compactar arquivos: {e}")

    def main(self):
        print("Iniciando o scraping...")
        self.get_links(self.get_main_class)

        if self.files:
            self.compress_files()

        print("Scraping finalizado com sucesso!")

scraping = Scraping()
