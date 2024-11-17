import  random
from robot.api.deco import keyword
import re

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
    def calculate_digit(cnpj_base, weights):
        total = sum(int(cnpj_base[i]) * weights[i] for i in range(len(weights)))
        remainder = total % 11
        return '0' if remainder < 2 else str(11 - remainder)

    base = ''.join([str(random.randint(0, 9)) for _ in range(12)])
    
    weights_first_digit = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    weights_second_digit = [6] + weights_first_digit

    first_digit = calculate_digit(base, weights_first_digit)
    second_digit = calculate_digit(base + first_digit, weights_second_digit)

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
def generate_fullName():
    primeiros_nomes = ["Alexandre", "Bruna", "Carlos", "Daniela", "Eduardo", "Fernanda", "Gabriel", "Helena"]
    sobrenomes = ["Silva", "Santos", "Oliveira", "Souza", "Lima", "Pereira", "Costa", "Ribeiro"]
    sobrenomes_complementares = ["Almeida", "Melo", "Barbosa", "Correia", "Fernandes", "Rocha", "Gomes", "Martins"]

    primeiro_nome = random.choice(primeiros_nomes)
    sobrenome = random.choice(sobrenomes)
    sobrenome_complementar = random.choice(sobrenomes_complementares)

    nome_completo = f"{primeiro_nome} {sobrenome} {sobrenome_complementar}"
    return nome_completo

@keyword
def generate_email():
    nomes = ["alexandre", "bruna", "carlos", "daniela", "eduardo", "fernanda", "gabriel", "helena"]
    dominios = ["gmail.com", "yahoo.com", "outlook.com", "hotmail.com", "empresa.com"]
    numeros = random.randint(1000, 9999) 

    nome = random.choice(nomes)
    dominio = random.choice(dominios)

    email = f"{nome}{numeros}@{dominio}"
    return email

@keyword
def generate_cpf():
    base = [random.randint(0, 9) for _ in range(9)]

    for peso in [10, 11]:
        soma = sum(v * p for v, p in zip(base, range(peso, 1, -1)))
        base.append(0 if soma % 11 < 2 else 11 - soma % 11)

    return ''.join(map(str, base))

@keyword
def sort_companies(companies):
    return sorted(companies, key=lambda x: x['corporateName']);

@keyword 
def sort_companies_by_date(companies_list):
    return sorted(companies_list, key=lambda company: company['audit'][0]['registrationDate'])

import random


