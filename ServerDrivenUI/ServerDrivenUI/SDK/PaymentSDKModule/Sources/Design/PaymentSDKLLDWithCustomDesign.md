                ┌──────────────────────────┐
                │      PaymentService      │  (Core Protocol)
                └───────────┬──────────────┘
                            │
                            ▼
                ┌──────────────────────────┐
                │  PaymentServiceImpl      │
                │  (depends on SDK)        │
                └───────────┬──────────────┘
                            │
                            ▼
                ┌──────────────────────────┐
                │       PaymentSDK         │  (SDK Protocol)
                └───────────┬──────────────┘
                            │
                            ▼
                ┌──────────────────────────┐
                │    PaymentSDKImpl        │
                └───────────┬──────────────┘
                            │
                            ▼
                ┌──────────────────────────┐
                │    PaymentProcessor      │
                └───────────┬──────────────┘
                            │
                            ▼
                ┌──────────────────────────┐
                │ PaymentHandlerRegistry   │
                └───────────┬──────────────┘
                            │
        ┌───────────────────┼───────────────────┐
        ▼                   ▼                   ▼
┌──────────────┐   ┌──────────────┐   ┌────────────────────┐
│ UPIHandler   │   │ NEFTHandler  │   │ CustomPaymentHandler│
└──────┬───────┘   └──────┬───────┘   └─────────┬──────────┘
       │                  │                     │
       └────────────┬─────┴────────────┬────────┘
                    ▼                  ▼
            ┌──────────────────────────────┐
            │     PaymentRepository        │ (Protocol)
            └──────────────┬───────────────┘
                           │
                           ▼
            ┌──────────────────────────────┐
            │  PaymentRepositoryImpl       │
            └──────────────┬───────────────┘
                           │
                           ▼
            ┌──────────────────────────────┐
            │      NetworkClient           │
            └──────────────────────────────┘

 Key Protocols & Classes
 
🟢 Core Layer
 
    protocol PaymentService
    final class PaymentServiceImpl
    
🔵 SDK Layer

    protocol PaymentSDK
    final class PaymentSDKImpl
    final class PaymentProcessor

🟣 Strategy Layer

    protocol PaymentHandler

    final class UPIHandler
    final class NEFTHandler
    final class CustomPaymentHandler

🟡 Registry

    struct PaymentHandlerRegistry
    
🟠 Data Layer

    protocol PaymentRepository
    final class PaymentRepositoryImpl
    
🌐 Network

    protocol NetworkClient
    final class NetworkClientImpl


1️⃣ Dependency Flow

    Feature → PaymentService(Core)
    Core → PaymentSDK
    SDK → Processor → Registry → Handler
    Handler → Repository → Network
