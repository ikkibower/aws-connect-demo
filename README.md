# AWS Connect Demo

## What is this?

This repo deploys an AWS Connect instance via Terraform. This instance contains a single call flow with lambda integration, hours of operation, and Queues. A simple Lex bot has been created with an associated lambda written in Python. A few DynamoDB tables have been created for storaging associated items, and metadata.

```
                              ┌──────────────────────────────┐
                              │   ┌──────────────────────┐   │
                              │   │    Amazon Connect    │   │
                              │   └──────────────────────┘   │
                              │   ┌──────────────────────┐   │
                              │   │    Incoming Call     │   │
                              │   └──────────────────────┘   │
                              └──────────────────────────────┘
                                              │
                                              │
                                              ▼
                              ┌──────────────────────────────┐
                              │   ┌──────────────────────┐   │
                              │   │    Amazon Connect    │   │
                              │   └──────────────────────┘   │
                              │   ┌──────────────────────┐   │
                              │   │ Landing Contact Flow │   │
                              │   └──────────────────────┘   │
                              │   ┌──────────────────────┐   │
                              │   │     DTMF Branch      │   │
                              │   └──────────────────────┘   │
                              └──────────────────────────────┘

                                      ┌────      ────┐
                                      │              │
┌──────────────────────────────┐      │              │      ┌──────────────────────────────┐
│   ┌──────────────────────┐   │  ◀───┘              └───▶  │   ┌──────────────────────┐   │
│   │         Lex          │   │                            │   │        Lambda        │   │
│   └──────────────────────┘   │                            │   └──────────────────────┘   │
│   ┌──────────────────────┐   │                            │   ┌──────────────────────┐   │
│   │      BookHotel       │   │ ────────────┐              │   │    FlowInvocation    │   │
│   └──────────────────────┘   │             │              │   └──────────────────────┘   │
└──────────────────────────────┘             │              └──────────────────────────────┘
              │   ▲                          │                              │
              ▼   │                          │                              ▼
┌──────────────────────────────┐             │              ┌──────────────────────────────┐
│   ┌──────────────────────┐   │             │              │   ┌──────────────────────┐   │
│   │        Lambda        │   │             │              │   │    Amazon Connect    │   │
│   └──────────────────────┘   │             │              │   └──────────────────────┘   │
│   ┌──────────────────────┐   │             │              │   ┌──────────────────────┐   │
│   │   BookHotel Lambda   │   │             │              │   │ Landing Contact Flow │   │
│   └──────────────────────┘   │             └────────────▶ │   └──────────────────────┘   │
└──────────────────────────────┘                            │   ┌──────────────────────┐   │
                │                                           │   │      Disconnect      │   │
                ▼                                           │   └──────────────────────┘   │
┌──────────────────────────────┐                            └──────────────────────────────┘
│   ┌──────────────────────┐   │
│   │       DynamoDB       │   │
│   └──────────────────────┘   │
│   ┌──────────────────────┐   │
│   │ Hotel Bookings Table │   │
│   └──────────────────────┘   │
└──────────────────────────────┘
```
