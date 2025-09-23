import apache_beam as beam
from apache_beam.options.pipeline_options import PipelineOptions
from beam_nuggts.io import relational_db

records = [
    {'name': 'Jan', 'num': 10},
    {'name': 'Feb', 'num': 20},
    {'name': 'Mar', 'num': 30},
    {'name': 'Apr', 'num': 40},
    {'name': 'May', 'num': 50},
]
source_config = relational_db.SourceConfiguration(
    drivername='postgresql+pg8000', # postgresql +pg8000
    host='localhost',
    port=5432,
    username='postgres',
    password= 'cvsgcp01',
    database='postgres',
    create_if_missing=True #create the database if not there
)

table_config = relational_db.TableConfiguration(
    name='months_col',
    create_if_missing=True,
    primary_key_columns=['num']
)

with beam.Pipeline(options=PipelineOptions()) as p:
    months = p | "Reading month records" >> beam.Create(records)
    months | 'Writing to BD table' >> relational_db.Write(
        source_config=source_config, 
        table_config=table_config
    )

if __name__ == '__main__':
    print('demo code ran suucessfully')
        
