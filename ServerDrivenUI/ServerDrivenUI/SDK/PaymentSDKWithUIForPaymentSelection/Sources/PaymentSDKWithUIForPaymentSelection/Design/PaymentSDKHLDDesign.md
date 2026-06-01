#High Level Architecture Design

Client App
    ↓
PaymentUIService.startPayment()
    ↓
Fetch Available Payment Methods
    ↓
Show Payment Selection UI
    ↓
User Chooses Method
    ↓
Find Matching Plugin
    ↓
Plugin Authentication Flow
    ↓
Build PaymentSelection
    ↓
PaymentSDKImpl
    ↓
Build PaymentRequestModel
    ↓
PaymentProcessor
    ↓
PaymentHandler
    ↓
Repository
    ↓
Backend

