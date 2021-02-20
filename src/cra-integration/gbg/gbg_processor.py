def lambda_handler(event, context):
    print("GBG lambda function")
    print(event['message'])
    return { 
        'message' : "GBG called successfully"
    }