import  random
import  string
from robot.api.deco import keyword
from datetime import datetime

@keyword
def generate_corporateName():
    prefixos = ["Global", "Prime", "Tech", "Digital", "Next", "Smart", "Future", "Ultra"]
    nomes = ["Solutions", "Systems", "Enterprises", "Group", "Holdings", "Ventures", "Networks", "Corp"]
    sufixos = ["Inc", "LLC", "Ltd", "S.A.", "Corp", "GmbH", "Pvt", "Co."]

    prefixo = random.choice(prefixos)
    nome = random.choice(nomes)
    sufixo = random.choice(sufixos)

    corporate_name = f"{prefixo} {nome} {sufixo}"
    return corporate_name

@keyword
def generate_registerCompany():
    def calculate_digit(cnpj_base):
        weights = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        total = sum(int(cnpj_base[i]) * weights[i + 1] for i in range(12))
        remainder = total % 11
        return '0' if remainder < 2 else str(11 - remainder)

    base = ''.join([str(random.randint(0, 9)) for _ in range(12)])
    first_digit = calculate_digit(base)
    second_digit = calculate_digit(base + first_digit)
    registerCompany = base + first_digit + second_digit
    return registerCompany

@keyword
def generate_matriz():
    prefixos = ["Comercial", "Indústria", "Serviços", "Tecnologia", "Consultoria", "Distribuidora", "Grupo", "Organização"]
    nomes = ["Alfa", "Beta", "Gama", "Delta", "Sigma", "Omega", "Platinum", "Prime"]
    sufixos = ["Ltda", "S.A.", "ME", "EPP", "EIRELI"]

    prefixo = random.choice(prefixos)
    nome = random.choice(nomes)
    sufixo = random.choice(sufixos)

    razao_social = f"{prefixo} {nome} {sufixo}"
    return razao_social

@keyword
def generate_email():
    random_number = random.randint(10000, 99999)
    return f"user{random_number}@example.com"

@keyword
def generate_cpf():
    cpf = ''.join([str(random.randint(0, 9)) for _ in range(9)])
    cpf += calculate_cpf_digit(cpf)
    cpf += calculate_cpf_digit(cpf)
    return cpf

def calculate_cpf_digit(cpf):
    weights = list(range(len(cpf) + 1, 1, -1))
    total = sum(int(digit) * weight for digit, weight in zip(cpf, weights))
    digit = (total * 10) % 11
    return str(digit) if digit < 10 else '0'

@keyword
def sort_companies(companies):
    return sorted(companies, key=lambda x: x['corporateName']);

@keyword 
def sort_companies_by_date(companies_list):
    return sorted(companies_list, key=lambda company: company['audit'][0]['registrationDate'])
    