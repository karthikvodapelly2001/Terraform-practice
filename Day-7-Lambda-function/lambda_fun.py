import json

def lambda_handler(event, context):
    """
    Sample AWS Lambda Function that returns a structured message block.
    """
    response = {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "message": "Hello from Terraform Lambda!",
            "request_id": context.aws_request_id,
            "event_received": event
        })
    }
    return response

