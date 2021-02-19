def lambda_handler(event, context):    
    message = 'Hello {} {}!'.format(event['first_name'], event['last_name'])  
    print(message)
    return {
          "message": [
    {
      "userId": "krish",
      "jobTitle": "Developer",
      "firstName": "Krish",
      "lastName": "Lee",
      "employeeCode": "E1",
      "region": "CA",
      "phoneNumber": "123456",
      "emailAddress": "krish.lee@learningcontainer.com"
    },
    {
      "userId": "devid",
      "jobTitle": "Developer",
      "firstName": "Devid",
      "lastName": "Rome",
      "employeeCode": "E2",
      "region": "CA",
      "phoneNumber": "1111111",
      "emailAddress": "devid.rome@learningcontainer.com"
    },
    {
      "userId": "tin",
      "jobTitle": "Program Directory",
      "firstName": "tin",
      "lastName": "jonson",
      "employeeCode": "E3",
      "region": "CA",
      "phoneNumber": "2222222",
      "emailAddress": "tin.jonson@learningcontainer.com"
    }
  ]
    }