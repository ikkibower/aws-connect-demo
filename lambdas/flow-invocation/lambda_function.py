import json
import os
import boto3
from aws_lambda_powertools import Logger

logger = Logger(service="flow_invocation")
dynamodb = boto3.resource('dynamodb')
table_name = os.getenv('DYNAMODB_TABLE')
table = dynamodb.Table(table_name)

def get_item_from_table(key):
    response = table.get_item(Key=key)
    item = response.get('Item')
    
    return item

def lambda_handler(event, context):
    try:
        logger.info(f"Received event: {json.dumps(event)}")

        booking = get_item_from_table("example-hotel-booking-node")
        logger.info(f"Booking: {json.dumps(booking)}")

        confirmation_message = f"Hotel booked in {booking['location']} for {booking['nights']} night(s) starting from {booking['check_in_date']}."
        
        return confirmation_message
        
    except Exception as e:
        logger.error(f"Error handling event: {str(e)}")
        return str(e)
