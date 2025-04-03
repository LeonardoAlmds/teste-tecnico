from fastapi import FastAPI, Query, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import csv
import re
from unidecode import unidecode

class Operator:
    def __init__(self, **data):
        for k, v in data.items():
            setattr(self, k.upper(), v)

    def to_dict(self):
        return self.__dict__

class OperatorService:
    def __init__(self, file):
        self.operators = []
        self.load_csv_data(file)

    def load_csv_data(self, file):
        with open(file, newline='', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile, delimiter=';')
            self.operators = [Operator(**{k.upper(): v for k, v in row.items()}) for row in reader]

    def normalizar(self, texto):
        return re.sub(r"\s+", "", unidecode(texto).upper())

    def search_operators(self, term):
        term = self.normalizar(term)
        return [
            op.to_dict() for op in self.operators
            if term in self.normalizar(op.NOME_FANTASIA) or term in self.normalizar(op.RAZAO_SOCIAL)
        ]

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],  
    allow_headers=["*"],  
)

operator_service = OperatorService("Relatorio_cadop.csv")

@app.get("/buscar/nome_fantasia-razao_social")
def search_operators(q: str = Query(..., description="Search term")):
    try:
        result = operator_service.search_operators(q)
        return {"total_found": len(result), "operators": result}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao buscar operadoras: {str(e)}")

@app.get("/buscar/todos")
def get_all_operators():
    try:
        result = operator_service.operators
        return {"total_found": len(result), "operators": [op.to_dict() for op in result]}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao buscar todas as operadoras: {str(e)}")
