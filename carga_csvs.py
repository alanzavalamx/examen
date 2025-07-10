import os
import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.exc import SQLAlchemyError


def cargar_datos():
    """
    Carga datos desde archivos CSV a PostgreSQL, asumiendo que las columnas
    de ID son auto-incrementales en la base de datos.
    """

    db_user = 'postgres'
    db_password = 'postgres'
    db_host = 'localhost'
    db_port = '5432'
    db_name = 'examen'
    schema = 'memsch'

    try:
        engine = create_engine(
            f'postgresql+psycopg2://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}'
        )
        print("Conexión a la base de datos establecida exitosamente.")
    except SQLAlchemyError as e:
        print(f"Error al crear el motor de base de datos: {e}")
        return

    files_to_process = {
        r'csvs\TC_exa.csv':    {'table': 'memtratcdet',   'format': '%Y-%m-%d'},
        r'csvs\MDA_exa.csv':   {'table': 'memtramdadet',  'format': '%Y-%m-%d'},
        r'csvs\MTR_exa.csv':   {'table': 'memtramtrdet',  'format': '%Y-%m-%d'},
        r'csvs\tbfin_exa.csv': {'table': 'memtratbfinvw', 'format': '%d/%m/%Y'}
    }

    for csv_file, details in files_to_process.items():
        table_name = details['table']
        date_format = details['format']
        file_path = os.path.join(os.getcwd(), csv_file)

        try:
            print(
                f"\nProcesando archivo: '{csv_file}' para la tabla '{schema}.{table_name}'")

            df = pd.read_csv(file_path)
            df.columns = [col.lower() for col in df.columns]

            if 'fecha' in df.columns:
                clean_dates = df['fecha'].astype(str).str.strip()
                df['fecha'] = pd.to_datetime(clean_dates, format=date_format)

            print(f"Cargando {len(df)} registros...")

            df.to_sql(
                name=table_name,
                con=engine,
                schema=schema,
                if_exists='append',
                index=False,
                chunksize=1000
            )

            print(
                f"Los datos de '{csv_file}' se cargaron en la tabla '{schema}.{table_name}'.")

        except SQLAlchemyError as e:
            print(f"ERROR al procesar el archivo '{csv_file}': {e}")

    print("\n Fin.")


if __name__ == '__main__':
    cargar_datos()
