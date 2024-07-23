resource "aws_connect_contact_flow" "landing_contact_flow" {
  depends_on = [ aws_connect_lambda_function_association.flow_invocation_lambda_connect_association,  aws_connect_instance.test_connect_instance ]
  instance_id = aws_connect_instance.test_connect_instance.id
  name        = "LandingContactFlow"
  description = "Landing contact flow"
  content     = <<EOF
{
  "Version": "2019-10-30",
  "StartAction": "b11b10a6-c4bd-41ba-a9d9-098cc5374035",
  "Metadata": {
    "entryPointPosition": {
      "x": 14.4,
      "y": 14.4
    },
    "ActionMetadata": {
      "a456069e-9995-4119-9427-bd63308fa17f": {
        "position": {
          "x": 1060.8,
          "y": 197.6
        },
        "dynamicParams": []
      },
      "6063b277-5cd1-41fc-a069-ae76887f2a23": {
        "position": {
          "x": 1145.6,
          "y": 505.6
        }
      },
      "4cb86557-b541-46a3-a452-cee0b241a3cf": {
        "position": {
          "x": 832.8,
          "y": 55.2
        },
        "conditions": [],
        "conditionMetadata": [
          {
            "id": "29ebce2d-9b97-4559-aa6e-1d038ac8be69",
            "operator": {
              "name": "Equals",
              "value": "Equals",
              "shortDisplay": "="
            },
            "value": "true"
          }
        ]
      },
      "b11b10a6-c4bd-41ba-a9d9-098cc5374035": {
        "position": {
          "x": 582.4,
          "y": 24
        },
        "conditions": [],
        "conditionMetadata": [
          {
            "id": "ff319b8e-ac9a-413a-8458-2eb047d9410c",
            "operator": {
              "name": "Equals",
              "value": "Equals",
              "shortDisplay": "="
            },
            "value": "CHAT"
          },
          {
            "id": "8e4c7942-8b43-4449-b80a-67f86d407762",
            "operator": {
              "name": "Equals",
              "value": "Equals",
              "shortDisplay": "="
            },
            "value": "TASK"
          }
        ]
      },
      "83b76e76-52cc-4732-81ff-1519b0c0f132": {
        "position": {
          "x": 2201.6,
          "y": 580.8
        }
      },
      "7c0a92c0-3a0d-4941-9d0e-2ae0e16ce58b": {
        "position": {
          "x": 1978.4,
          "y": 580
        }
      },
      "98a70ec0-069b-44a4-ada6-2a1810b1c675": {
        "position": {
          "x": 1376.8,
          "y": 333.6
        },
        "conditionMetadata": [
          {
            "id": "92b1b6c6-40d8-4e4b-a347-935398e4f8a8",
            "value": "1"
          }
        ]
      },
      "0e520569-a08c-4322-ae38-5ffcb6e86390": {
        "position": {
          "x": 1665.6,
          "y": 286.4
        },
        "parameters": {
          "LambdaFunctionARN": {
            "displayName": "FlowInvocationLambda"
          }
        },
        "dynamicMetadata": {}
      }
    },
    "Annotations": [],
    "name": "Sample inbound flow (first contact experience)",
    "description": "First contact experience",
    "type": "contactFlow",
    "status": "saved",
    "hash": {}
  },
  "Actions": [
    {
      "Parameters": {
        "Attributes": {
          "greetingPlayed": "true"
        },
        "TargetContact": "Current"
      },
      "Identifier": "a456069e-9995-4119-9427-bd63308fa17f",
      "Type": "UpdateContactAttributes",
      "Transitions": {
        "NextAction": "6063b277-5cd1-41fc-a069-ae76887f2a23",
        "Errors": [
          {
            "NextAction": "6063b277-5cd1-41fc-a069-ae76887f2a23",
            "ErrorType": "NoMatchingError"
          }
        ]
      }
    },
    {
      "Parameters": {
        "Text": "Hello, thanks for calling. These are some examples of what the Amazon Connect virtual contact center can enable you to do."
      },
      "Identifier": "6063b277-5cd1-41fc-a069-ae76887f2a23",
      "Type": "MessageParticipant",
      "Transitions": {
        "NextAction": "98a70ec0-069b-44a4-ada6-2a1810b1c675"
      }
    },
    {
      "Parameters": {
        "ComparisonValue": "$.Attributes.greetingPlayed"
      },
      "Identifier": "4cb86557-b541-46a3-a452-cee0b241a3cf",
      "Type": "Compare",
      "Transitions": {
        "NextAction": "a456069e-9995-4119-9427-bd63308fa17f",
        "Conditions": [
          {
            "NextAction": "98a70ec0-069b-44a4-ada6-2a1810b1c675",
            "Condition": {
              "Operator": "Equals",
              "Operands": [
                "true"
              ]
            }
          }
        ],
        "Errors": [
          {
            "NextAction": "a456069e-9995-4119-9427-bd63308fa17f",
            "ErrorType": "NoMatchingCondition"
          }
        ]
      }
    },
    {
      "Parameters": {
        "ComparisonValue": "$.Channel"
      },
      "Identifier": "b11b10a6-c4bd-41ba-a9d9-098cc5374035",
      "Type": "Compare",
      "Transitions": {
        "NextAction": "4cb86557-b541-46a3-a452-cee0b241a3cf",
        "Conditions": [
          {
            "NextAction": "",
            "Condition": {
              "Operator": "Equals",
              "Operands": [
                "CHAT"
              ]
            }
          },
          {
            "NextAction": "",
            "Condition": {
              "Operator": "Equals",
              "Operands": [
                "TASK"
              ]
            }
          }
        ],
        "Errors": [
          {
            "NextAction": "4cb86557-b541-46a3-a452-cee0b241a3cf",
            "ErrorType": "NoMatchingCondition"
          }
        ]
      }
    },
    {
      "Parameters": {},
      "Identifier": "83b76e76-52cc-4732-81ff-1519b0c0f132",
      "Type": "DisconnectParticipant",
      "Transitions": {}
    },
    {
      "Parameters": {
        "Text": "We're sorry, an error occurred. Goodbye."
      },
      "Identifier": "7c0a92c0-3a0d-4941-9d0e-2ae0e16ce58b",
      "Type": "MessageParticipant",
      "Transitions": {
        "NextAction": "83b76e76-52cc-4732-81ff-1519b0c0f132"
      }
    },
    {
      "Parameters": {
        "Text": "Press 1 to hear the results of an AWS Lambda data dip. ",
        "StoreInput": "False",
        "InputTimeLimitSeconds": "8"
      },
      "Identifier": "98a70ec0-069b-44a4-ada6-2a1810b1c675",
      "Type": "GetParticipantInput",
      "Transitions": {
        "NextAction": "0e520569-a08c-4322-ae38-5ffcb6e86390",
        "Conditions": [
          {
            "NextAction": "0e520569-a08c-4322-ae38-5ffcb6e86390",
            "Condition": {
              "Operator": "Equals",
              "Operands": [
                "1"
              ]
            }
          }
        ],
        "Errors": [
          {
            "NextAction": "7c0a92c0-3a0d-4941-9d0e-2ae0e16ce58b",
            "ErrorType": "InputTimeLimitExceeded"
          },
          {
            "NextAction": "0e520569-a08c-4322-ae38-5ffcb6e86390",
            "ErrorType": "NoMatchingCondition"
          },
          {
            "NextAction": "7c0a92c0-3a0d-4941-9d0e-2ae0e16ce58b",
            "ErrorType": "NoMatchingError"
          }
        ]
      }
    },
    {
      "Parameters": {
        "LambdaFunctionARN": "${module.lambdas.flow_invocation_lambda_invoke_arn}",
        "InvocationTimeLimitSeconds": "3",
        "ResponseValidation": {
          "ResponseType": "STRING_MAP"
        }
      },
      "Identifier": "0e520569-a08c-4322-ae38-5ffcb6e86390",
      "Type": "InvokeLambdaFunction",
      "Transitions": {
        "NextAction": "83b76e76-52cc-4732-81ff-1519b0c0f132",
        "Errors": [
          {
            "NextAction": "7c0a92c0-3a0d-4941-9d0e-2ae0e16ce58b",
            "ErrorType": "NoMatchingError"
          }
        ]
      }
    }
  ]
}

EOF
}

output "landing_contact_flow_id" {
  value = aws_connect_contact_flow.landing_contact_flow.id
}
