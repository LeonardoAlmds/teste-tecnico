import os
import pdfplumber
import pandas as pd
import zipfile

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
        try:
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
        except FileNotFoundError:
            print(f"Erro: Arquivo '{path_data}' não encontrado.")
        except Exception as e:
            print(f"Erro ao extrair dados do PDF: {e}")

    def replace_values(self, data):
        try:
            if data == self.header:
                for i in range(len(data)):
                    if data[i] == "OD":
                        data[i] = "SEG. ODONTOLÓGICA"
                    elif data[i] == "AMB":
                        data[i] = "SEG. AMBULATORIAL"
            else:                
                for line in data:
                    for i in range(len(line)):
                        if line[i] == "OD":
                            line[i] = "Seg. Odontológica"
                        elif line[i] == "AMB":
                            line[i] = "Seg. Ambulatorial"
        except Exception as e:
            print(f"Erro ao substituir valores: {e}")
        
    def save_data(self, data, header, name_output):
        try:
            os.makedirs(self.output_dir, exist_ok=True) 
            df = pd.DataFrame(data, columns=header)
            df.to_csv(name_output, index=False, encoding="utf-8")
            print(f"Leitura concluída! Dados extraídos e salvos em '{name_output}'.")
        except Exception as e:
            print(f"Erro ao salvar os dados em CSV: {e}")

    def compress_file(self, file_path):
        try:
            zip_file = f"{self.output_dir}/Teste_Leonardo_Silva_de_Almeida.zip"

            with zipfile.ZipFile(zip_file, 'w') as zipf:
                zipf.write(file_path, arcname=os.path.basename(file_path)) 
            
            print(f"Arquivo compactado salvo em '{zip_file}'.")
        except Exception as e:
            print(f"Erro ao compactar o arquivo: {e}")

    def main(self):
        self.extract_data(self.path_data)
        
        if self.all_data and self.header:
            self.replace_values(self.all_data)
            self.replace_values(self.header)
            self.save_data(self.all_data, self.header, self.name_output_data)
            self.compress_file(self.name_output_data)
        else:
            print("Nenhum dado foi extraído, encerrando o processo.")

data_transformation = DataTransformation()