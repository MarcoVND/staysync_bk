# Imagen base oficial de Python
FROM python:3.12-slim

# Evita que Python genere archivos .pyc
ENV PYTHONDONTWRITEBYTECODE=1
# Evita buffering de logs (útil en dev)
ENV PYTHONUNBUFFERED=1

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Instalar pipenv o requirements.txt (ejemplo con requirements.txt)
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el proyecto entero
COPY . /app/

# Puerto expuesto para el servidor de Django
EXPOSE 8000

# Comando por defecto (puede sobreescribirse en docker-compose)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]