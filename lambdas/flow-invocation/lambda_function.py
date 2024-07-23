import json
import logging

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    try:
        logger.info(f"Received event: {json.dumps(event)}")
        confirmation_message = "Lambda successfully invoked."
        
        return confirmation_message
        
    except Exception as e:
        logger.error(f"Error handling event: {str(e)}")
        return str(e)

# def invocation_function(event):
#     try:
        
#         confirmation_message = "Lambda successfully invoked."
        
#         return confirmation_message
    
#     except Exception as e:
#         logger.error(f"Error in book_hotel function: {str(e)}")
#         return str(e)
    

# def handle_error(message):
#     response = {
#         "dialogAction": {
#             "type": "Close",
#             "fulfillmentState": "Failed",
#             "message": {
#                 "contentType": "PlainText",
#                 "content": f"An error occurred: {message}"
#             }
#         }
#     }
    
#     return response
