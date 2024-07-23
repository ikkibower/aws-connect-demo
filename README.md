# AWS Connect Demo
## What is this?
This repo deploys an AWS Connect instance via Terraform. This instance contains a single call flow, and a simple Lex bot with an associated lambda written in Python.

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