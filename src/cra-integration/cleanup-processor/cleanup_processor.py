def lambda_handler(event, context):
    print("Cleanup lambda function")
    print(event['message'])
    return { 
        'message' : "Message from cleanup..."
    }