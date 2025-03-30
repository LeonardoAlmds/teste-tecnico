import os
import pdfplumber
import pandas as pd

class DataTransformation:
    def __init__(self):
        self.output_dir = "teste_2"
        self.path_data = f"{self.output_dir}/Anexo_1.pdf"
        self.name_output_data = f"{self.output_dir}/dados_extraidos.csv"

        self.all_data = []
        self.header = []
        self.first_page = True

        self.main()

    def extract_data(self, path_data):
        print(f"Lendo arquivo '{path_data}'...")

        with pdfplumber.open(path_data) as pdf:
            total_pages = len(pdf.pages)

            for page_n, page in enumerate(pdf.pages, start=1):
                print(f"Lendo página {page_n}/{total_pages}...")
                table = page.extract_table()

                if table:
                    if self.first_page:
                        self.header = table[0]
                        self.all_data.extend(table[1:])
                        self.first_page = False
                    else:
                        self.all_data.extend(table[1:])
        print(f"Leitura concluída! {len(self.all_data)} linhas extraídas.")

    def save_data(self, data, header, name_output):
        print(f"Salvando dados extraídos em '{name_output}'...")

        os.makedirs(self.output_dir, exist_ok=True) 

        df = pd.DataFrame(data, columns=header)
        df.to_csv(name_output, index=False, encoding="utf-8")

        print(f"Leitura concluída! Dados extraídos e salvos em '{name_output}'.")
    
    def main(self):
        self.extract_data(self.path_data)
        self.save_data(self.all_data, self.header, self.name_output_data)

data_transformation = DataTransformation()