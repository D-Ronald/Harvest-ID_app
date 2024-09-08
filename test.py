import requests
from io import BytesIO
from services import send


# Montar o Google Drive
drive.mount('/content/drive')

# Use o subdomínio do Ngrok como endereço IP, 
url_colab = "https://543a-35-233-239-38.ngrok-free.app/predict"
# Caminho do arquivo de imagem no Google Drive
image_path = "/content/drive/MyDrive/API/tomate 0.jpg"

# Ler o conteúdo binário da imagem usando a biblioteca io
with open(image_path, 'rb') as file:
    image_content = BytesIO(file.read())

# Enviar a solicitação POST com o objeto BytesIO como arquivo
files = {'image': ('image.jpg', image_content)}
response = requests.post(url_colab, files=files)

# Verificar o código de status da resposta
if response.status_code == 200:
    # Se o código de status for 200 (OK), imprima a resposta da API
    print(response.json())
else:
    # Se o código de status for diferente de 200, imprima a mensagem de erro
    print(f"Erro {response.status_code}: {response.text}")