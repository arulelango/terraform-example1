def lambda_handler(event, context):    
    print(event['message'])
    return { 
        'message' : event.message
    }