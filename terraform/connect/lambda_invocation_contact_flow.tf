resource "aws_connect_contact_flow" "lambda_invocation_contact_flow" {
  instance_id = aws_connect_instance.test_connect_instance.id
  name        = "lambdaInvocationContactFlow"
  description = "Lambda invocation contact flow"
  content     = <<EOF
{
  "Version": "2019-10-30",
  "StartAction": "4d36a741-bc87-4035-b3fa-9c8390e687ac",
  "Metadata": {
    "entryPointPosition": {
      "x": 38.4,
      "y": 14.4
    },
    "ActionMetadata": {
      "7329da0c-3dcb-4661-a72e-95b6e841a4a4": {
        "position": {
          "x": 930.4,
          "y": 360.8
        }
      },
      "35c77601-311e-4e0b-85a5-883381ac2655": {
        "position": {
          "x": 688,
          "y": 388
        },
        "conditions": [],
        "conditionMetadata": [
          {
            "id": "025b7943-e3b3-4c78-b429-b8820cbca973",
            "operator": {
              "name": "Equals",
              "value": "Equals",
              "shortDisplay": "="
            },
            "value": "unknown"
          }
        ]
      },
      "5d737fb6-6df3-4e27-beff-eb3395bada65": {
        "position": {
          "x": 684.8,
          "y": 36.8
        }
      },
      "96f62f74-1905-40cd-acca-714c0782717a": {
        "position": {
          "x": 1725.6,
          "y": 448
        }
      },
      "1b9a1e90-a330-450b-85a9-dcad8ef3b045": {
        "position": {
          "x": 1188,
          "y": 72.8
        }
      },
      "75a15841-1848-42a0-8933-e6baccb5ffaf": {
        "position": {
          "x": 702.4,
          "y": 186.4
        },
        "dynamicParams": []
      },
      "31dd3a3e-7d66-4829-9252-8ea344160f5e": {
        "position": {
          "x": 1461.6,
          "y": 384.8
        }
      },
      "94cd8c74-9a86-41bd-8fe2-d08bc8f9e41e": {
        "position": {
          "x": 1208.8,
          "y": 336.8
        },
        "parameters": {
          "ContactFlowId": {
            "displayName": "Sample inbound flow (first contact experience)"
          }
        },
        "ContactFlow": {
          "text": "Sample inbound flow (first contact experience)"
        }
      },
      "4d36a741-bc87-4035-b3fa-9c8390e687ac": {
        "position": {
          "x": 192.8,
          "y": 49.6
        }
      },
      "431f29e2-cca7-44e4-a449-90a38c2d327b": {
        "position": {
          "x": 926.4,
          "y": 565.6
        }
      },
      "68f1b094-8c1c-4231-879d-b106e53de281": {
        "position": {
          "x": 440.8,
          "y": 120.8
        },
        "conditions": [],
        "conditionMetadata": [
          {
            "id": "fc41ddf1-24f4-4df1-be7b-e684bbc99ea6",
            "operator": {
              "name": "Equals",
              "value": "Equals",
              "shortDisplay": "="
            },
            "value": "CHAT"
          },
          {
            "id": "b6714a1f-2a62-4607-8975-4b9ec0ba386c",
            "operator": {
              "name": "Equals",
              "value": "Equals",
              "shortDisplay": "="
            },
            "value": "TASK"
          }
        ]
      },
      "7eefafd6-402f-4759-967c-b017ef5f3969": {
        "position": {
          "x": 149.6,
          "y": 244.8
        },
        "dynamicMetadata": {}
      }
    },
    "Annotations": [],
    "name": "Sample Lambda integration",
    "description": "Invokes a lambda function to determine information about the user.",
    "type": "contactFlow",
    "status": "PUBLISHED",
    "hash": {}
  },
  "Actions": [
    {
      "Parameters": {
        "Text": "Based on the number you are calling from, your area code is located in $.External.State"
      },
      "Identifier": "7329da0c-3dcb-4661-a72e-95b6e841a4a4",
      "Type": "MessageParticipant",
      "Transitions": {
        "NextAction": "1b9a1e90-a330-450b-85a9-dcad8ef3b045"
      }
    },
    {
      "Parameters": {
        "ComparisonValue": "$.External.State"
      },
      "Identifier": "35c77601-311e-4e0b-85a5-883381ac2655",
      "Type": "Compare",
      "Transitions": {
        "NextAction": "7329da0c-3dcb-4661-a72e-95b6e841a4a4",
        "Conditions": [
          {
            "NextAction": "431f29e2-cca7-44e4-a449-90a38c2d327b",
            "Condition": {
              "Operator": "Equals",
              "Operands": [
                "unknown"
              ]
            }
          }
        ],
        "Errors": [
          {
            "NextAction": "7329da0c-3dcb-4661-a72e-95b6e841a4a4",
            "ErrorType": "NoMatchingCondition"
          }
        ]
      }
    },
    {
      "Parameters": {
        "Text": "Here is your fun fact: $.External.Fact"
      },
      "Identifier": "5d737fb6-6df3-4e27-beff-eb3395bada65",
      "Type": "MessageParticipant",
      "Transitions": {
        "NextAction": "1b9a1e90-a330-450b-85a9-dcad8ef3b045"
      }
    },
    {
      "Parameters": {},
      "Identifier": "96f62f74-1905-40cd-acca-714c0782717a",
      "Type": "DisconnectParticipant",
      "Transitions": {}
    },
    {
      "Parameters": {
        "Text": "Now returning you to the main menu."
      },
      "Identifier": "1b9a1e90-a330-450b-85a9-dcad8ef3b045",
      "Type": "MessageParticipant",
      "Transitions": {
        "NextAction": "94cd8c74-9a86-41bd-8fe2-d08bc8f9e41e"
      }
    },
    {
      "Parameters": {
        "Attributes": {
          "FunFact": "Here is your fun fact: $.External.Fact"
        },
        "TargetContact": "Current"
      },
      "Identifier": "75a15841-1848-42a0-8933-e6baccb5ffaf",
      "Type": "UpdateContactAttributes",
      "Transitions": {
        "NextAction": "94cd8c74-9a86-41bd-8fe2-d08bc8f9e41e",
        "Errors": [
          {
            "NextAction": "94cd8c74-9a86-41bd-8fe2-d08bc8f9e41e",
            "ErrorType": "NoMatchingError"
          }
        ]
      }
    },
    {
      "Parameters": {
        "Text": "Failed to transfer back to main flow"
      },
      "Identifier": "31dd3a3e-7d66-4829-9252-8ea344160f5e",
      "Type": "MessageParticipant",
      "Transitions": {
        "NextAction": "96f62f74-1905-40cd-acca-714c0782717a"
      }
    },
    {
      "Parameters": {
        "ContactFlowId": "${aws_connect_contact_flow.landing_contact_flow.arn}"
      },
      "Identifier": "94cd8c74-9a86-41bd-8fe2-d08bc8f9e41e",
      "Type": "TransferToFlow",
      "Transitions": {
        "NextAction": "31dd3a3e-7d66-4829-9252-8ea344160f5e",
        "Errors": [
          {
            "NextAction": "31dd3a3e-7d66-4829-9252-8ea344160f5e",
            "ErrorType": "NoMatchingError"
          }
        ]
      }
    },
    {
      "Parameters": {
        "Text": "Now performing a data dip using AWS Lambda. Based on your phone number, we will lookup the state you are calling from if you are on a voice call or tell you a fun fact if you are on chat."
      },
      "Identifier": "4d36a741-bc87-4035-b3fa-9c8390e687ac",
      "Type": "MessageParticipant",
      "Transitions": {
        "NextAction": "7eefafd6-402f-4759-967c-b017ef5f3969"
      }
    },
    {
      "Parameters": {
        "Text": "Sorry, we failed to find the state for your phone number's area code."
      },
      "Identifier": "431f29e2-cca7-44e4-a449-90a38c2d327b",
      "Type": "MessageParticipant",
      "Transitions": {
        "NextAction": "1b9a1e90-a330-450b-85a9-dcad8ef3b045"
      }
    },
    {
      "Parameters": {
        "ComparisonValue": "$.Channel"
      },
      "Identifier": "68f1b094-8c1c-4231-879d-b106e53de281",
      "Type": "Compare",
      "Transitions": {
        "NextAction": "35c77601-311e-4e0b-85a5-883381ac2655",
        "Conditions": [
          {
            "NextAction": "5d737fb6-6df3-4e27-beff-eb3395bada65",
            "Condition": {
              "Operator": "Equals",
              "Operands": [
                "CHAT"
              ]
            }
          },
          {
            "NextAction": "75a15841-1848-42a0-8933-e6baccb5ffaf",
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
            "NextAction": "35c77601-311e-4e0b-85a5-883381ac2655",
            "ErrorType": "NoMatchingCondition"
          }
        ]
      }
    },
    {
      "Parameters": {
        "LambdaFunctionARN": "${module.lambdas.flow_invocation_lambda_invoke_arn}",
        "InvocationTimeLimitSeconds": "4",
        "ResponseValidation": {
          "ResponseType": "STRING_MAP"
        }
      },
      "Identifier": "7eefafd6-402f-4759-967c-b017ef5f3969",
      "Type": "InvokeLambdaFunction",
      "Transitions": {
        "NextAction": "68f1b094-8c1c-4231-879d-b106e53de281",
        "Errors": [
          {
            "NextAction": "431f29e2-cca7-44e4-a449-90a38c2d327b",
            "ErrorType": "NoMatchingError"
          }
        ]
      }
    }
  ]
}
EOF
}

output "lambda_invocation_contact_flow_id" {
  value = aws_connect_contact_flow.lambda_invocation_contact_flow.id
}