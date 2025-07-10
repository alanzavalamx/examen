# Solución de Examen Técnico de Datos

## Descripción

Este proyecto presenta una solución integral para el análisis de datos del Mercado Eléctrico Mayorista (MEM). El proceso abarca desde la configuración de un entorno de desarrollo local con Docker y PostgreSQL, la creación de un esquema de base de datos relacional, la ingesta de datos desde archivos CSV mediante un script de Python, hasta la ejecución de consultas para el análisis de la información.

El objetivo es demostrar las habilidades en la manipulación, procesamiento y análisis de datos, utilizando herramientas estándar de la industria como SQL, Python (con Pandas y SQLAlchemy) y Docker.

## Reporte Final

El análisis detallado, las consultas SQL, las visualizaciones y las conclusiones se encuentran consolidadas en el siguiente documento:

- [**Ver Reporte Final (PDF)**](./reporte/reporte.pdf)

## Características

- **Entorno Aislado:** Uso de Docker y Docker Compose para levantar una base de datos PostgreSQL, garantizando consistencia y facilidad de configuración.
- **Base de Datos Relacional:** Un esquema SQL bien definido para almacenar los datos del mercado de manera estructurada.
- **Carga de Datos Automatizada:** Un script en Python que lee múltiples archivos CSV y los carga de forma masiva y eficiente en la base de datos.
- **Manejo de Dependencias:** Archivo `requirements.txt` para una fácil instalación de las librerías de Python necesarias.
- **Análisis de Datos:** La estructura facilita la posterior consulta y análisis de los datos para extraer información de valor.

## Requisitos Previos

Asegúrate de tener instaladas las siguientes herramientas en tu sistema:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Python 3.8+](https://www.python.org/downloads/)
- [Git](https://git-scm.com/downloads/) (Opcional, para clonar el repositorio)

## Instalación y Configuración

Sigue estos pasos para configurar el entorno de desarrollo:

1.  **Clona el repositorio (si aplica):**
    ```bash
    git clone <URL-del-repositorio>
    cd <nombre-del-directorio>
    ```

2.  **Levanta el servicio de la Base de Datos:**
    Abre una terminal en la raíz del proyecto y ejecuta el siguiente comando para iniciar el contenedor de PostgreSQL en segundo plano.
    ```bash
    docker-compose up -d
    ```
    El contenedor estará configurado con las siguientes credenciales (definidas en `docker-compose.yml`):
    - **Usuario:** `postgres`
    - **Contraseña:** `postgres`
    - **Base de datos:** `examen`
    - **Puerto:** `5432`

3.  **Instala las dependencias de Python:**
    Crea un entorno virtual (recomendado) y activa la instalación de las librerías necesarias.
    ```bash
    # Crea el entorno virtual
    python -m venv venv

    # Actívalo (en Windows)
    .\venv\Scripts\activate
    # Actívalo (en macOS/Linux)
    # source venv/bin/activate

    # Instala las dependencias
    pip install -r requirements.txt
    ```

## Uso del Proyecto

Una vez configurado el entorno, sigue estos pasos para poblar la base de datos.

### 1. Crear las Tablas

Conéctate a la base de datos `examen` utilizando tu cliente de PostgreSQL preferido (como DBeaver, pgAdmin, o `psql` desde la línea de comandos) y ejecuta el script `create_tables.sql`. Esto creará el esquema `memsch` y todas las tablas necesarias.

### 2. Cargar los Datos

Ejecuta el script de Python para leer los archivos `.csv` y cargarlos en las tablas que creaste en el paso anterior.

```bash
python carga_csvs.py
```

El script procesará cada archivo, estandarizará los nombres de las columnas y los insertará en la tabla correspondiente. Verás mensajes de progreso en la consola.

## Análisis y Respuestas al Examen

Las respuestas a los puntos solicitados en el documento `examen.docx` se encuentran desarrolladas en los siguientes archivos:

- **`examen_seccion_sql.sql`**: Contiene todas las consultas en SQL utilizadas para responder a cada uno de los puntos del análisis de datos. Cada consulta está documentada para indicar a qué pregunta corresponde.

- **`notebook.ipynb`**: Un Notebook de Jupyter que incluye el codigo que contesta cada uno de los puntos requeridos en la rubrica.

## Estructura del Proyecto

```
.
├── carga_csvs.py              # Script de Python para la carga de datos a PostgreSQL.
├── create_tables.sql          # Script SQL para la creación del esquema y las tablas.
├── docker-compose.yml         # Define el servicio de la base de datos PostgreSQL.
├── examen.docx                # Documento con los requerimientos del examen.
├── examen_seccion_sql.sql     # Contiene las consultas SQL que responden a los puntos del examen.
├── notebook.ipynb             # Notebook con el análisis, visualizaciones y respuestas del examen.
├── README.md                  # Este archivo.
├── requirements.txt           # Dependencias de Python.
├── csvs/                      # Carpeta que contiene los archivos de datos.
│   ├── MDA_exa.csv
│   ├── MTR_exa.csv
│   ├── tbfin_exa.csv
│   └── TC_exa.csv
└── reporte/                   # Carpeta con el reporte y las gráficas generadas.
    ├── reporte.pdf            # Reporte final de la solución en formato PDF.
    ├── reporte.tex            # Archivo fuente LaTeX del reporte.
    ├── 1_gra_ev_mda_mtr_nodo.png
    ├── 2_diff_prom_precio.png
    └── 3_comp_precios.png
```

---
**Autor:** Alan Alexis Zavala Mendoza
