#  LLD
┌────────────────────────────────────────────┐
│ PaymentUIService                           │
│--------------------------------------------│
│ startPayment(amount)                       │
│                                            │
│ • Entry point for SDK                      │
│ • Orchestrates complete payment flow       │
└───────────────────┬────────────────────────┘
                    │
                    ▼
┌────────────────────────────────────────────┐
│ PaymentMethodsProvider                     │
│--------------------------------------------│
│ fetchPaymentOptions()                      │
│                                            │
│ • Gets available payment methods           │
│ • Implemented by Client App                │
└───────────────────┬────────────────────────┘
                    │
                    ▼
┌────────────────────────────────────────────┐
│ PaymentOptionView                          │
│--------------------------------------------│
│ onSelect(option)                           │
│                                            │
│ • Shows Wallet / UPI / Card / NEFT         │
│ • User selects payment method              │
└───────────────────┬────────────────────────┘
                    │
                    ▼
┌────────────────────────────────────────────┐
│ PaymentMethodPlugin                        │
│--------------------------------------------│
│ canHandle(option)                          │
│ handle(option)                             │
│                                            │
│ • Payment method behavior abstraction      │
└─────────────┬──────────────┬───────────────┘
              │              │
              │              │
              ▼              ▼

┌──────────────────────┐   ┌──────────────────────┐
│ WalletPlugin         │   │ UPIPlugin            │
│----------------------│   │----------------------│
│ collectOtp()         │   │ appSwitch()          │
│ validateOTP()        │   │ verifyUPIStatus()   │
│ handle()             │   │ handle()            │
│                      │   │                     │
│ Auth Flow            │   │ App Switch Flow     │
└──────────┬───────────┘   └──────────┬──────────┘
           │                          │
           ▼                          ▼

┌────────────────────────────────────────────┐
│ PaymentSelection                           │
│--------------------------------------------│
│ methodType                                 │
│ details                                    │
│     See at the bottom                      │
│ • Output of authentication flow            │
└───────────────────┬────────────────────────┘
                    │
                    ▼

┌────────────────────────────────────────────┐
│ PaymentSDKImpl                             │
│--------------------------------------------│
│ processPayment()                           │
│                                            │
│ • Generate idempotency key                 │
│ • Build PaymentRequestModel                │
│ • Trigger payment processing               │
└───────────────────┬────────────────────────┘
                    │
                    ▼

┌────────────────────────────────────────────┐
│ PaymentProcessor                           │
│--------------------------------------------│
│ process(request)                           │
│                                            │
│ • Finds correct handler                    │
└───────────────────┬────────────────────────┘
                    │
                    ▼

┌────────────────────────────────────────────┐
│ PaymentHandlerRegistry                     │
│--------------------------------------------│
│ handler(for methodType)                    │
│                                            │
│ • Maps payment type to handler             │
└───────────────────┬────────────────────────┘
                    │
                    ▼

        ┌────────────────────────────┐
        │ PaymentHandler             │
        │----------------------------│
        │ handlePayment(request)     │
        └───────┬───────────┬────────┘
                │           │
                ▼           ▼

┌──────────────────────┐   ┌──────────────────────┐
│ WalletHandler        │   │ UPIHandler           │
│----------------------│   │----------------------│
│ handlePayment()      │   │ handlePayment()      │
│                      │   │                      │
│ Backend execution    │   │ Backend execution    │
└──────────┬───────────┘   └──────────┬───────────┘
           │                          │
           ▼                          ▼

┌────────────────────────────────────────────┐
│ PaymentRepository                          │
│--------------------------------------------│
│ createPayment()                            │
│ validateWalletOTP()                        │
│                                            │
│ • Business API abstraction                 │
└───────────────────┬────────────────────────┘
                    │
                    ▼

┌────────────────────────────────────────────┐
│ NetworkClient                              │
│--------------------------------------------│
│ request()                                  │
│ performRequest()                           │
│                                            │
│ • Executes HTTP requests                   │
│ • Applies interceptors                     │
│ • Uses RetryExecutor                       │
└───────────────────┬────────────────────────┘
                    │
                    ▼

┌────────────────────────────────────────────┐
│ RetryExecutor                              │
│--------------------------------------------│
│ execute()                                  │
│ computeDelay()                             │
│                                            │
│ • Retry transient failures                 │
│ • Exponential backoff                      │
└───────────────────┬────────────────────────┘
                    │
                    ▼

              ┌─────────────┐
              │   Backend   │
              └─────────────┘




┌────────────────────────────────────────────┐
│ PaymentSelection                           │
│--------------------------------------------│
│ methodType                                │
│ details                                   │
│                                            │
│ Examples:                                 │
│                                            │
│ Wallet                                    │
│ └─ authToken                              │
│ └─ walletId                               │
│                                            │
│ UPI                                       │
│ └─ upiId                                  │
│ └─ transactionReference                   │
│                                            │
│ Card                                      │
│ └─ cardToken                              │
│ └─ threeDSAuthId                          │
│                                            │
│ NEFT                                      │
│ └─ accountNumber                          │
│ └─ ifscCode                               │
│                                            │
│ • Output of Plugin Authentication Flow    │
│ • Represents User's Final Payment Choice  │
│ • Passed to PaymentSDKImpl                │
│ • Converted into PaymentRequestModel      │
│ • Decouples UI/Auth from Backend Payment  │
└───────────────────┬────────────────────────┘
