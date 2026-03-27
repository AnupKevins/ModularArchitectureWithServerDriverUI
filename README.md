# ModularArchitectureWithServerDriverUI<img width="1739" height="1617" alt="mermaid-diagram" src="https://github.com/user-attachments/assets/f2e0bd98-5b53-42f8-8666-813f181cd5e8" />
# Navigation Flow After Launch 
<img width="3034" height="918" alt="mermaid-diagram (1)" src="https://github.com/user-attachments/assets/8de9c916-281c-4408-ad6a-562db6d81f43" />
# Server Driven UI
                ┌────────────────────────────┐
                │          Backend           │
                │     (UI JSON Config)       │
                └─────────────┬──────────────┘
                              │
                              ▼
                ┌────────────────────────────┐
                │        CoreModule          │
                │  - Networking              │
                │  - Caching / Utils         │
                └─────────────┬──────────────┘
                              │
                              ▼
        ┌──────────────────────────────────────────┐
        │     ServerDrivenModelsKit Module         │
        │  - Codable Models                        │
        │  - Schema (Component, Layout, Actions)   │
        └─────────────┬────────────────────────────┘
                      │
                      ▼
        ┌──────────────────────────────────────────┐
        │   ServerDrivenEngineModule               │
        │  - Parser (JSON → ViewModel)             │
        │  - Component Factory                    │
        │  - Component Registry                   │
        └─────────────┬────────────────────────────┘
                      │
                      ▼
                ┌────────────────────────────┐
                │        HomeModule          │
                │  - Uses Engine             │
                │  - Feature Logic           │
                │  - Screen Composition      │
                └─────────────┬──────────────┘
                              │
                              ▼
                ┌────────────────────────────┐
                │          UI Layer          │
                │   (Dynamic Rendering)      │
                └────────────────────────────┘
