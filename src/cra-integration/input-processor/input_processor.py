import json
import urllib.parse
import boto3
import uuid

print('Loading function')

s3 = boto3.client('s3')
client = boto3.client('stepfunctions')

def lambda_handler(event, context):
    #1 - Get the bucket name
    bucket = event['Records'][0]['s3']['bucket']['name']

    #2 - Get the file/key name
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    print("FileName :"+key)
    
    try:
        #3 - Fetch the file from S3
        response = s3.get_object(Bucket=bucket, Key=key)

        #4 - Deserialize the file's content
        text = response["Body"].read().decode()
        data = json.loads(text)

        #5 - Print the content
        print(data)

        # Invoke the step function

        data = { "first_name": "Arul", "last_name": "Elan"}
        transactionId = str(uuid.uuid1())

        print('Calling step function...')
        client.start_execution(
            stateMachineArn = 'arn:aws:states:eu-west-2:266283146648:stateMachine:my-step-function',
            name = transactionId,
            input = json.dumps(data)
        )
        print('Step function invoked successfully.....')

        return 'Success!'

    except Exception as e:
        print(e)
        raise e

# def lambda_handler(event, context):
#     print("Hello from Python")

