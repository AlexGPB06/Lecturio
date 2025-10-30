import SwiftUI

// --- 1. Modelo de Datos para el Juego de Emociones ---
struct Emotion: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let emoji: String
}

// --- 2. Lista de Todas las Emociones (15) ---
let allEmotions: [Emotion] = [
    Emotion(name: "Feliz", emoji: "😄"),
    Emotion(name: "Triste", emoji: "😢"),
    Emotion(name: "Enojado", emoji: "😡"),
    Emotion(name: "Sorprendido", emoji: "😮"),
    Emotion(name: "Asustado", emoji: "😱"),
    Emotion(name: "Aburrido", emoji: "🥱"),
    Emotion(name: "Nervioso", emoji: "😟"),
    Emotion(name: "Confundido", emoji: "😕"),
    Emotion(name: "Orgulloso", emoji: "😎"),
    Emotion(name: "Tímido", emoji: "😳"),
    Emotion(name: "Cansado", emoji: "😴"),
    Emotion(name: "Emocionado", emoji: "🤩"),
    Emotion(name: "Hambriento", emoji: "😋"),
    Emotion(name: "Pensativo", emoji: "🤔"),
    Emotion(name: "Enfermo", emoji: "🤢")
]


// --- 3. Vista del Juego de Cartas Emocionales ---
struct EmotionalFacesGameView: View {
    
    // --- Estado del Juego ---
    @State private var score = 0
    // Selecciona una emoción al azar para empezar
    @State private var currentEmotion: Emotion = allEmotions.randomElement()!
    @State private var options: [Emotion] = []
    
    // --- Estado del Feedback ---
    @State private var feedbackMessage = ""
    @State private var feedbackColor: Color = .clear
    @State private var isAnswered = false // Bloquea los botones después de responder
    
    // --- Columnas para la cuadrícula de opciones ---
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            // Fondo alegre a juego (cielo a pasto)
            LinearGradient(
                colors: [Color(red: 0.6, green: 0.9, blue: 1.0), Color(red: 0.7, green: 1.0, blue: 0.7)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // --- Puntaje ---
                    Text("Puntaje: \(score)")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(15)
                        .padding(.top)
                    
                    // --- Tarjeta de Emoción (Emoji) ---
                    VStack {
                        Text(currentEmotion.emoji)
                            .font(.system(size: 140)) // Emoji bien grande
                            .padding()
                            // Pequeño "pop" al responder
                            .scaleEffect(isAnswered ? 1.1 : 1.0)
                            .animation(.spring(), value: isAnswered)
                    }
                    .padding(30)
                    .background(Color.white.opacity(0.85)) // Fondo de "nube"
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                    
                    // --- Pregunta ---
                    Text("¿Qué emoción es esta?")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.black.opacity(0.7))
                    
                    // --- Mensaje de Feedback ---
                    if isAnswered {
                        Text(feedbackMessage)
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(feedbackColor)
                            .padding(10)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(10)
                            // Animación para aparecer
                            .transition(.scale.combined(with: .opacity))
                    } else {
                        // Espaciador para que el layout no salte
                        Text(" ")
                            .font(.system(.headline, design: .rounded))
                            .padding(10)
                    }
                    
                    // --- Cuadrícula de Opciones (4 botones) ---
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(options) { emotion in
                            Button(action: {
                                // Solo permite responder una vez
                                if !isAnswered {
                                    checkAnswer(emotion)
                                }
                            }) {
                                Text(emotion.name)
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black.opacity(0.8))
                                    .frame(maxWidth: .infinity, minHeight: 60)
                                    .padding()
                                    .background(Color.white.opacity(0.85))
                                    .cornerRadius(20)
                                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                            }
                            // Desactiva el botón después de responder
                            .disabled(isAnswered)
                        }
                    }
                    .padding(.horizontal)
                    
                }
                .padding()
            }
        }
        .navigationTitle("Cartas Emocionales")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            setupNewRound() // Configura la primera ronda
        }
    }
    
    // --- 4. Lógica del Juego ---
    
    func setupNewRound() {
        isAnswered = false
        feedbackMessage = ""
        
        // 1. Elige una emoción aleatoria
        currentEmotion = allEmotions.randomElement()!
        
        // 2. Crea las opciones, empezando con la correcta
        var tempOptions: [Emotion] = [currentEmotion]
        
        // 3. Obtiene otras 3 emociones diferentes
        let otherEmotions = allEmotions.filter { $0.id != currentEmotion.id }
        tempOptions.append(contentsOf: otherEmotions.shuffled().prefix(3))
        
        // 4. Baraja las 4 opciones
        options = tempOptions.shuffled()
    }
    
    func checkAnswer(_ selectedEmotion: Emotion) {
        isAnswered = true
        
        if selectedEmotion.id == currentEmotion.id {
            // --- Respuesta Correcta ---
            feedbackMessage = "¡Muy bien! ¡Es \(currentEmotion.name)!"
            feedbackColor = .green
            score += 1
        } else {
            // --- Respuesta Incorrecta ---
            feedbackMessage = "¡Oh no! Esa era \(currentEmotion.name)."
            feedbackColor = .red
        }
        
        // --- Prepara la siguiente ronda después de 2 segundos ---
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                setupNewRound()
            }
        }
    }
}

// --- 5. Vista Previa (Para Xcode) ---
#Preview {
    // Se envuelve en un NavigationStack para que se vea el título
    NavigationStack {
        EmotionalFacesGameView()
    }
}
