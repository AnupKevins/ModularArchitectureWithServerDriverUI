Builder → SDK → Processor → Repository → NetworkClient → Retry → Interceptors → Backend

┌──────────────────────────┐
│        Client App        │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│   PaymentSDKBuilder      │  ← Initialization Layer
│--------------------------│
│ + baseURL                │
│ + withAuth()             │
│ + withRetry()            │
│ + build()                │
└────────────┬─────────────┘
             │ creates
             ▼
┌──────────────────────────┐
│     PaymentSDKImpl       │  ← Public Entry (Facade)
│--------------------------│
│ + pay(request)           │
│ + IdempotencyStore       │
└────────────┬─────────────┘
             │ orchestrates
             ▼
┌──────────────────────────┐
│    PaymentProcessor      │  ← Core (Use Case)
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│  PaymentRepository       │  ← Abstraction
└────────────┬─────────────┘
             │ implemented by
             ▼
┌──────────────────────────┐
│ PaymentRepositoryImpl    │  ← Data Layer
│--------------------------│
│ + APIRequest mapping     │
│ + DTO → Domain           │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────────────────┐
│      DefaultNetworkClient            │  ← Infrastructure
│--------------------------------------│
│ + request()                          │
│ + performRequest()                   │
│                                      │
│  ┌──────────────────────────────┐    │
│  │     RetryExecutor            │    │
│  │------------------------------│    │
│  │ + execute()                  │    │
│  │ + exponential backoff        │    │
│  └──────────────┬───────────────┘    │
│                 │ wraps              │
│                 ▼                    │
│  ┌──────────────────────────────┐    │
│  │   RequestInterceptor[]       │    │
│  │------------------------------│    │
│  │ AuthInterceptor              │
│  │ LoggingInterceptor (opt)     │
│  └──────────────┬───────────────┘
│                 │ modifies
│                 ▼
│        URLRequest (HTTP)
└────────────┬─────────────────────────┘
             │
             ▼
┌──────────────────────────┐
│       URLSession         │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│      Backend API         │
└──────────────────────────┘

🧠 How to explain this (killer answer 🎤)
🎯 Start with layers

“This SDK follows clean architecture with clear separation between public API, core business logic, data layer, and infrastructure.”

🎯 Builder

“The builder initializes the SDK by wiring dependencies like network client, authentication, interceptors, and retry logic.”

🎯 Entry point

“PaymentSDKImpl acts as a facade and orchestrates the payment flow, including idempotency checks.”

🎯 Core

“PaymentProcessor handles the business use case and delegates to the repository.”

🎯 Data layer

“The repository converts domain models into API requests and maps responses back.”

🎯 Infrastructure

“The network client handles execution, where retry logic wraps the request and interceptors modify it before sending it via URLSession.”

🎯 Retry (IMPORTANT 🔥)

“RetryExecutor wraps the network execution and applies exponential backoff, ensuring failures are retried without blocking threads.”

🎯 Interceptors

“Interceptors like AuthInterceptor inject headers such as tokens before the request is sent.”
