final class PaymentHandlerRegistry {
    
    private let handlers: [String: PaymentHandler]
    
    init(handlers: [PaymentHandler]) {
        self.handlers = Dictionary(uniqueKeysWithValues: handlers.map { ($0.methodType, $0)
            }
        )
    }
    // $0.methodType
    // String → "UPI", "CARD", etc.
    // 👉 This becomes the key
    
    // $0
    // 👉 The whole handler object → becomes the value
    // (key: methodType, value: handler)
    
    func handler(for type: String) -> PaymentHandler? {
        handlers[type]
    }
}
