import json
import pandas as pd
import boto3

s3 = boto3.client('s3')

def lambda_handler(event, context):
    bucket = 'cleansubmissionanswersbucket'
    key = 'clean_data_15July.csv'

    response = s3.get_object(Bucket=bucket, Key=key)

    content = response['Body']

    df = pd.read_csv(content)
    print("Total cells: " + str(df.size))
    print("Columns: " + str(df.columns))
    print("Rows: " + str(df.shape))
    print("-----------")


    return {
        'statusCode': 200,
        'body': json.dumps({'df.columns': df.columns, 'df.shape': df.shape, 'df.size': df.size})
    }
