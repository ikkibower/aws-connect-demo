import json
import logging

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    try:
        logger.info(f"Received event: {json.dumps(event)}")
        intent_name = event['currentIntent']['name']
        
        if intent_name == 'BookHotel':
            return book_hotel(event)
        
        raise ValueError(f"Intent with name {intent_name} not supported")
    
    except Exception as e:
        logger.error(f"Error handling event: {str(e)}")
        return handle_error(str(e))

def book_hotel(event):
    try:
        slots = event['currentIntent']['slots']
        location = slots['Location']
        check_in_date = slots['CheckInDate']
        nights = slots['Nights']
        
        if not location or not check_in_date or not nights:
            raise ValueError("Missing required slot values")
        
        confirmation_message = f"Hotel booked in {location} for {nights} night(s) starting from {check_in_date}."
        
        return close(intent_name=event['currentIntent']['name'],
                     fulfillment_state="Fulfilled",
                     message=confirmation_message)
    
    except KeyError as e:
        logger.error(f"Missing slot in event: {str(e)}")
        return handle_error("Missing required slot information")
    except Exception as e:
        logger.error(f"Error in book_hotel function: {str(e)}")
        return handle_error(str(e))

def close(intent_name, fulfillment_state, message):
    response = {
        "dialogAction": {
            "type": "Close",
            "fulfillmentState": fulfillment_state,
            "message": {
                "contentType": "PlainText",
                "content": message
            }
        }
    }
    
    return response

def handle_error(message):
    response = {
        "dialogAction": {
            "type": "Close",
            "fulfillmentState": "Failed",
            "message": {
                "contentType": "PlainText",
                "content": f"An error occurred: {message}"
            }
        }
    }
    
    return response
