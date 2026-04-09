+---------------------+
|    FeatureHome      |
|---------------------|
| PaymentInput        |
| UI / ViewModel      |
+----------+----------+
           |
           ↓
+---------------------+
|     CoreModule      |
|---------------------|
| PaymentService      |
| PaymentServiceImpl  |
| PaymentInstrument   |
| SDKMapping          |
+----------+----------+
           |
           ↓
+------------------------------+
|      PaymentSDKModule        |
|------------------------------|
| PaymentSDKImpl               |
| PaymentProcessor             |
| PaymentHandlerRegistry       |
|------------------------------|
| UPIHandler                   |
| NEFTHandler                  |
| CustomPaymentHandler         |
+----------+-------------------+
           |
           ↓
+---------------------+
|      Data Layer     |
|---------------------|
| PaymentRepository   |
+----------+----------+
           |
           ↓
+---------------------+
|    Network Layer    |
|---------------------|
| NetworkClient       |
| Interceptors        |
| Auth + Retry        |
+---------------------+

	•	Feature → sends generic input
	•	Core → maps to SDK
	•	SDK → selects handler (Strategy Pattern)
	•	Handler → calls repository
	•	Repository → calls network
