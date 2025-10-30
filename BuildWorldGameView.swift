import SwiftUI

// --- 1. Modelo de Palabra con Imagen ---
struct WordItem: Identifiable {
    let id = UUID()
    let word: String
    let imageName: String // Usaremos SF Symbols como placeholder
}

// --- 2. Lista de Palabras Sencillas (Original) ---
let simpleWordList: [String] = [
    // 3 Letras
    "SOL", "PAN", "REY", "LUZ", "MAR", "SAL", "DOS", "TRES", "SEIS", "DIEZ", "OJO", "UVA",
    "PIE", "SUR", "NORTE", "FIN", "VER", "IR", "SER", "DAR", "PAZ", "MAS", "CON", "POR",
    
    // 4 Letras
    "GATO", "PERRO", "CASA", "MESA", "SILLA", "PATO", "VACA", "LUNA", "RANA", "MANO", "BOCA",
    "ROJO", "AZUL", "VERDE", "AGUA", "LECHE", "JUGO", "FLOR", "NUBE", "LLAVE", "LIBRO",
    "LAPIZ", "CAMA", "PAPA", "MAMA", "BEBE", "NIÑO", "NIÑA", "CARRO", "TREN", "AVION",
    "BARCO", "PALA", "CUBO", "BOTA", "LAPIZ", "GOMA", "REGLA", "PISO", "TECHO", "MURO",
    "PATO", "SAPO", "TORO", "OSO", "LEON", "TIGRE", "LOBO", "RATA", "PEZ", "PULPO", "FOCA",
    "HOLA", "ADIOS", "SI", "NO", "BUENO", "MALO", "RICO", "FEO", "DIA", "NOCHE", "CALOR",
    "FRIO", "MANO", "DEDO", "PIE", "OJO", "DIENTE", "PELO", "CARA", "PIEL", "HUESO", "PICO",
    "PATA", "COLA", "NIDO", "HUEVO", "CAJA", "BOTE", "TAPA", "COPA", "VASO", "TELA", "LANA",
    "SEDA", "ORO", "PLATA", "HIELO", "FUEGO", "HUMO", "ROCA", "LODO", "ARENA", "MAPA",
    
    // 5 Letras
    "ARBOL", "PERA", "MANGO", "LIMON", "MELON", "SANDIA", "FRESA", "CIRCO", "PAYASO",
    "GLOBO", "MAGIA", "RATON", "QUESO", "PLATO", "TAZA", "RADIO", "MUSICA", "BAILE",
    "CANTO", "JUEGO", "PELOTA", "CUERDA", "PARQUE", "CALLE", "PLAZA", "PUENTE", "TORRE",
    "HOTEL", "PLAYA", "SELVA", "MONTE", "CAMPO", "NIEVE", "LLUVIA", "VIENTO", "TRONO",
    "CINCO", "SIETE", "OCHO", "NUEVE", "BLANCO", "NEGRO", "GRIS", "FELIZ", "TRISTE",
    "ENOJO", "MIEDO", "CALMA", "GRITO", "LLANTO", "RISA", "LIBRO", "HOJA", "LETRA",
    "PLUMA", "TINTA", "COLOR", "VERDE", "MORADO", "NARANJA", "CAFE", "ROSADO", "DEDO",
    "BRAZO", "PIERNA", "PECHO", "ESPALDA", "HOMBRO", "LINEA", "PUNTO", "FORMA", "RUEDA",
    "MOTOR", "LUZ", "FARO", "ANCLA", "VELA", "REMO", "PILOTO", "LLAVE", "CLAVO",
    
    // 6 Letras
    "CABALLO", "JIRAFA", "ELEFANTE", "GALLINA", "OVEJA", "CONEJO", "TORTUGA", "DELFIN",
    "BALLENA", "ABEJA", "MOSCA", "ARAÑA", "HELADO", "GALLETA", "PASTEL", "DULCE",
    "COMIDA", "BEBIDA", "FRUTA", "VERDURA", "TOMATE", "CEBOLLA", "PATATA", "ZAPATO",
    "CAMISA", "GORRA", "FALDA", "GUANTE", "MEDIAS", "RELOJ", "ANILLO", "COLLAR",
    "ESCUELA", "MAESTRO", "ALUMNO", "PIZARRA", "TIJERA", "CUADERNO", "CRAYON", "PINTAR",
    "DIBUJAR", "CORTAR", "PEGAR", "LEER", "ESCRIBIR", "SUMAR", "RESTAR", "NUMERO",
    "GRANDE", "PEQUEÑO", "ALTO", "BAJO", "LARGO", "CORTO", "DURO", "SUAVE", "ABRIR",
    "CERRAR", "SUBIR", "BAJAR", "ENTRAR", "SALIR", "DORMIR", "COMER", "BEBER", "JUGAR",
    "CORRER", "SALTAR", "NADAR", "VOLAR", "CAMINAR", "SENTAR", "PARAR", "VERANO",
    "OTOÑO", "INVIERNO", "PRIMAVERA", "MAÑANA", "TARDE", "NOCHE", "SIEMPRE", "NUNCA",
    "AMARILLO", "AZULADO", "VERDOSO", "FAMILIA", "HERMANO", "HERMANA", "ABUELO", "ABUELA",
    "PADRE", "MADRE"
]

// --- 3. Mapeo a WordItem con SF Symbols como EJEMPLO ---
// Función para asignar un ícono de SF Symbol (o un placeholder)
// *** Aquí es donde cambiarías "sun.max.fill" por "miImagenDelSol" ***
func mapWordsToItems(_ words: [String]) -> [WordItem] {
    var items: [WordItem] = []
    let symbolMap: [String: String] = [
        "SOL": "sun.max.fill",
        "REY": "crown.fill",
        "LUZ": "lightbulb.fill",
        "MAR": "water.waves",
        "OJO": "eye.fill",
        "PIE": "figure.walk",
        "GATO": "pawprint.fill", // Placeholder
        "PERRO": "pawprint.fill", // Placeholder
        "CASA": "house.fill",
        "LUNA": "moon.fill",
        "MANO": "hand.raised.fill",
        "FLOR": "camera.macro", // Icono de flor
        "NUBE": "cloud.fill",
        "LLAVE": "key.fill",
        "LIBRO": "book.fill",
        "LAPIZ": "pencil",
        "CAMA": "bed.double.fill",
        "CARRO": "car.fill",
        "TREN": "train.side.front.car",
        "AVION": "airplane",
        "BARCO": "sailboat.fill",
        "ARBOL": "tree.fill",
        "GLOBO": "balloon.fill",
        "RADIO": "radio.fill",
        "MUSICA": "music.note",
        "JUEGO": "gamecontroller.fill",
        "PELOTA": "soccerball",
        "LLUVIA": "cloud.rain.fill",
        "NIEVE": "snowflake",
        "VIENTO": "wind",
        "TRONO": "cloud.bolt.fill",
        "FELIZ": "face.smiling.fill",
        "TRISTE": "face.dashed.fill",
        "PASTEL": "birthday.cake.fill",
        "CAMISA": "tshirt.fill",
        "GORRA": "graduationcap.fill",
        "RELOJ": "clock.fill",
        "TIJERA": "scissors",
        "PINTAR": "paintbrush.fill",
        "DIBUJAR": "pencil.and.outline",
        "LEER": "book.fill",
        "DORMIR": "bed.double.fill",
        "COMER": "fork.knife",
        "BEBER": "cup.and.saucer.fill",
        "CORRER": "figure.run",
        "NADAR": "figure.pool.swim",
        "VOLAR": "airplane",
        "FAMILIA": "person.3.fill"
    ]
    
    let placeholderIcon = "questionmark.diamond.fill" // Icono genérico

    for word in words {
        // Busca el ícono, si no existe, usa el placeholder
        let imageName = symbolMap[word, default: placeholderIcon]
        items.append(WordItem(word: word, imageName: imageName))
    }
    return items
}

// Variable global que usa la función
let wordItemList: [WordItem] = mapWordsToItems(simpleWordList)


// --- 4. Modelo para las Letras Desordenadas ---
struct ScrambledLetter: Identifiable {
    let id = UUID()
    let letter: String
    var isUsed = false // Para saber si ya fue tocada
}

// --- 5. Vista del Juego ---
struct BuildWordGameView: View {
    
    // --- Estado del Juego ---
    @State private var score = 0
    // CAMBIO: Ahora guarda el objeto WordItem completo
    @State private var currentWordItem: WordItem = wordItemList.randomElement()!
    
    // NUEVO: Estado para la lógica de "completar"
    @State private var currentWordChars: [String] = [] // La palabra como ["C", "A", "S", "A"]
    @State private var missingIndices: [Int] = [] // Índices que faltan, ej: [1, 3]
    
    @State private var scrambledLetters: [ScrambledLetter] = [] // Siempre 6 opciones
    @State private var playerInput: [String] = []
    
    // --- Estado del Feedback ---
    @State private var feedbackMessage = ""
    @State private var feedbackColor: Color = .clear
    @State private var isAnswered = false
    
    // --- Columnas para las letras ---
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 6)
    
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
                    
                    // --- NUEVO: Imagen de Apoyo ---
                    Image(systemName: currentWordItem.imageName)
                        .font(.system(size: 80))
                        // Si es el placeholder, se ve gris; si no, azul
                        .foregroundColor(currentWordItem.imageName == "questionmark.diamond.fill" ? .gray.opacity(0.5) : .blue)
                        .frame(height: 100)
                        .padding()
                        .scaleEffect(isAnswered ? 1.1 : 1.0)
                        .animation(.spring(), value: isAnswered)
                    
                    // --- Casillas para la Palabra ---
                    // Lógica actualizada para mostrar letras dadas y huecos
                    HStack(spacing: 10) {
                        ForEach(0..<currentWordChars.count, id: \.self) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white.opacity(0.9))
                                    .frame(width: 50, height: 60)
                                    .shadow(color: .black.opacity(0.1), radius: 3, y: 2)
                                
                                // Esta función decide qué mostrar (letra dada, letra del jugador, o nada)
                                let (text, color) = getLetterForBox(at: index)
                                
                                Text(text)
                                    .font(.system(.title, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundColor(color)
                            }
                        }
                    }
                    .padding()
                    .frame(height: 80) // Altura fija para que no salte
                    
                    // --- Mensaje de Feedback ---
                    if isAnswered {
                        Text(feedbackMessage)
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(feedbackColor)
                            .padding(10)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(10)
                            .transition(.scale.combined(with: .opacity))
                    } else {
                        Text("Toca las letras que faltan") // Mensaje actualizado
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(.black.opacity(0.7))
                            .padding(10)
                    }

                    // --- Letras Desordenadas (Siempre 6) ---
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(scrambledLetters.indices, id: \.self) { index in
                            Button(action: {
                                if !scrambledLetters[index].isUsed && !isAnswered {
                                    letterTapped(index: index)
                                }
                            }) {
                                Text(scrambledLetters[index].letter)
                                    .font(.system(.title2, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundColor(scrambledLetters[index].isUsed ? .gray.opacity(0.5) : .black.opacity(0.8))
                                    .frame(width: 50, height: 60)
                                    .background(Color.white.opacity(scrambledLetters[index].isUsed ? 0.3 : 0.85))
                                    .cornerRadius(15)
                                    .shadow(color: .black.opacity(0.1), radius: 5, y: 2)
                            }
                            .disabled(scrambledLetters[index].isUsed)
                        }
                    }
                    .padding(.horizontal)
                    .frame(minHeight: 150) // Espacio para las letras
                    
                    // --- Botones de Control ---
                    HStack(spacing: 20) {
                        // Botón Borrar
                        Button(action: {
                            if !isAnswered { clearInput() }
                        }) {
                            Image(systemName: "arrow.uturn.backward.circle.fill")
                                .font(.system(size: 24, weight: .bold))
                            Text("Borrar")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.bold)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.orange.opacity(0.9))
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        
                        // Botón Saltar
                        Button(action: {
                            if !isAnswered {
                                withAnimation {
                                    setupNewRound()
                                }
                            }
                        }) {
                            Text("Saltar")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.bold)
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue.opacity(0.8))
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    }
                    .padding(.bottom)
                }
            }
        }
        .navigationTitle("Construye la Palabra")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            setupNewRound()
        }
    }
    
    // --- 6. Lógica del Juego (Actualizada) ---
    
    // NUEVA: Función auxiliar para las casillas
    func getLetterForBox(at index: Int) -> (String, Color) {
        // 1. Si NO es un índice que falta, es una letra dada
        if !missingIndices.contains(index) {
            return (currentWordChars[index], .black.opacity(0.4)) // Color gris
        }
        
        // 2. Es un índice que falta. Vemos si el jugador ya lo llenó
        // Buscamos qué "turno" de llenado es (0, 1, 2...)
        if let inputPosition = missingIndices.firstIndex(of: index) {
            if inputPosition < playerInput.count {
                // Si el jugador ya puso una letra para este hueco
                return (playerInput[inputPosition], .black.opacity(0.9)) // Color normal
            }
        }
        
        // 3. Es un índice que falta, y está vacío
        return ("", .clear)
    }
    
    
    func setupNewRound() {
        isAnswered = false
        feedbackMessage = ""
        playerInput.removeAll()
        missingIndices.removeAll()
        scrambledLetters.removeAll()
        
        // 1. Elige un WordItem aleatorio
        currentWordItem = wordItemList.randomElement()!
        let correctWord = currentWordItem.word
        currentWordChars = correctWord.map { String($0) }
        let wordLength = currentWordChars.count
        
        // 2. Decide cuántas letras ocultar (1, 2, o 3)
        // Se asegura de no ocultar más letras de las que tiene la palabra
        let numToHide = Int.random(in: 1...min(3, wordLength))
        
        // 3. Elige qué índices ocultar y los guarda en orden
        missingIndices = Array(0..<wordLength).shuffled().prefix(numToHide).sorted()
        
        // 4. Obtiene las letras correctas que faltan
        let correctLetters = missingIndices.map { currentWordChars[$0] }
        
        // 5. Genera 6 opciones: las correctas + señuelos
        var options: [String] = correctLetters
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map { String($0) }
        let numDecoys = 6 - options.count
        
        while options.count < 6 {
            let randomLetter = alphabet.randomElement()!
            // Se asegura de no añadir un señuelo que ya esté en las opciones
            if !options.contains(randomLetter) {
                options.append(randomLetter)
            }
        }
        
        // 6. Baraja las 6 opciones y las prepara para los botones
        scrambledLetters = options.shuffled().map { ScrambledLetter(letter: $0) }
    }
    
    func letterTapped(index: Int) {
        // 1. Marca la letra como usada y la añade al input
        scrambledLetters[index].isUsed = true
        playerInput.append(scrambledLetters[index].letter)
        
        // 2. Comprueba si la palabra está completa (si ya llenó todos los huecos)
        if playerInput.count == missingIndices.count {
            checkAnswer()
        }
    }
    
    func checkAnswer() {
        isAnswered = true
        
        // Compara las letras del jugador (en orden) con las letras que faltaban (en orden)
        let correctMissingLetters = missingIndices.map { currentWordChars[$0] }
        
        if playerInput == correctMissingLetters {
            // --- Correcto ---
            feedbackMessage = "¡Excelente!"
            feedbackColor = .green
            score += 1
        } else {
            // --- Incorrecto ---
            let correctWord = currentWordChars.joined() // Muestra la palabra completa
            feedbackMessage = "¡Casi! La palabra era \(correctWord)"
            feedbackColor = .red
        }
        
        // Prepara la siguiente ronda
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                setupNewRound()
            }
        }
    }
    
    func clearInput() {
        playerInput.removeAll()
        // Reactiva todos los botones de letras
        for i in 0..<scrambledLetters.count {
            scrambledLetters[i].isUsed = false
        }
    }
}

// --- 7. Vista Previa (Para Xcode) ---
#Preview {
    NavigationStack {
        BuildWordGameView()
    }
}

