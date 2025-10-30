import SwiftUI

// --- 1. Modelos de Datos (ACTUALIZADO) ---

/// Representa una sola pregunta del juego
struct Pregunta: Identifiable {
    let id = UUID()
    let texto: String
    let opciones: [String]
    let respuestaCorrecta: String
    let imagenSimbolo: String // Un ícono de SF Symbols para apoyo visual
    let descripcion: String // NUEVO: Explicación de la respuesta
}

// --- 2. Colores del Tema (ACTUALIZADO) ---
let colorJunglaFondo = Color(red: 0.1, green: 0.4, blue: 0.25) // Verde jungla (ligeramente más claro)
let colorHojasFondo = Color(red: 0.05, green: 0.2, blue: 0.1) // NUEVO: Verde oscuro para hojas
let colorMadera = Color(red: 0.5, green: 0.35, blue: 0.2)      // Marrón
let colorMaderaOscura = Color(red: 0.3, green: 0.2, blue: 0.1) // Marrón oscuro


// --- 3. Lista de Preguntas (ACTUALIZADA CON PREGUNTAS DE MODALES) ---
let listaDePreguntas: [Pregunta] = [
    // --- Preguntas de Modales (Nuevas) ---
    Pregunta(texto: "Si alguien te da un regalo, ¿qué dices?", opciones: ["Gracias", "Hola", "Quiero más"], respuestaCorrecta: "Gracias", imagenSimbolo: "gift.fill", descripcion: "¡Muy bien! Decir 'Gracias' es muy amable."),
    Pregunta(texto: "Para pedir algo, ¿qué palabra mágica usas?", opciones: ["Por favor", "Rápido", "Dame"], respuestaCorrecta: "Por favor", imagenSimbolo: "hand.wave.fill", descripcion: "¡Excelente! 'Por favor' es una palabra mágica."),
    Pregunta(texto: "Cuando llegas a un lugar, ¿qué dices?", opciones: ["Hola", "Adiós", "Tengo hambre"], respuestaCorrecta: "Hola", imagenSimbolo: "sun.min.fill", descripcion: "¡Perfecto! Saludar con un 'Hola' es muy amigable."),
    
    // --- Preguntas Anteriores (sin las de colores) ---
    Pregunta(texto: "¿Los pájaros pueden volar?", opciones: ["Sí", "No"], respuestaCorrecta: "Sí", imagenSimbolo: "bird.fill", descripcion: "¡Correcto! Los pájaros usan sus alas para volar por el cielo."),
    Pregunta(texto: "¿Qué animal dice 'Guau'?", opciones: ["Perro", "Gato", "Pez"], respuestaCorrecta: "Perro", imagenSimbolo: "dog.fill", descripcion: "¡Muy bien! El perro es el mejor amigo del hombre."),
    Pregunta(texto: "¿Las estrellas salen de día?", opciones: ["No", "Sí"], respuestaCorrecta: "No", imagenSimbolo: "star.fill", descripcion: "¡Así es! Las estrellas brillan de noche, y el sol de día."),
    Pregunta(texto: "¿Cuántas ruedas tiene un carro?", opciones: ["4", "2", "10"], respuestaCorrecta: "4", imagenSimbolo: "car.fill", descripcion: "¡Perfecto! Los carros necesitan 4 ruedas para andar."),
    Pregunta(texto: "¿Los peces viven en el cielo?", opciones: ["No", "Sí"], respuestaCorrecta: "No", imagenSimbolo: "fish.fill", descripcion: "¡Claro que no! Los peces nadan y viven en el agua."),
    Pregunta(texto: "¿Qué forma es esta?", opciones: ["Círculo", "Cuadrado", "Casa"], respuestaCorrecta: "Círculo", imagenSimbolo: "circle.fill", descripcion: "¡Genial! Un círculo es redondo, como una pelota."),
    Pregunta(texto: "¿Qué animal es muy lento?", opciones: ["Tortuga", "Conejo", "Avión"], respuestaCorrecta: "Tortuga", imagenSimbolo: "tortoise.fill", descripcion: "¡Eso es! Las tortugas caminan muy despacito."),
    Pregunta(texto: "¿Qué animal dice 'Miau'?", opciones: ["Gato", "Perro", "Sol"], respuestaCorrecta: "Gato", imagenSimbolo: "cat.fill", descripcion: "¡Miau! ¡Correcto! A los gatos les encanta jugar."),
    Pregunta(texto: "¿Usamos paraguas cuando llueve?", opciones: ["Sí", "No"], respuestaCorrecta: "Sí", imagenSimbolo: "umbrella.fill", descripcion: "¡Buena respuesta! El paraguas nos protege de la lluvia."),
    Pregunta(texto: "¿Qué forma es esta?", opciones: ["Cuadrado", "Círculo", "Estrella"], respuestaCorrecta: "Cuadrado", imagenSimbolo: "square.fill", descripcion: "¡Excelente! Un cuadrado tiene cuatro lados iguales."),
    Pregunta(texto: "¿Qué animal hace 'Oinc'?", opciones: ["Cerdo", "Vaca", "Pato"], respuestaCorrecta: "Cerdo", imagenSimbolo: "nose.fill", descripcion: "¡Oinc, oinc! A los cerditos les gusta jugar en el lodo."),
    Pregunta(texto: "¿La luna sale de noche?", opciones: ["Sí", "No"], respuestaCorrecta: "Sí", imagenSimbolo: "moon.fill", descripcion: "¡Muy bien! La luna brilla en el cielo por la noche.")
]


// --- 4. Vista Principal del Juego ---
struct PreguntasRetadorasView: View {
    
    // Estado del juego
    @State private var preguntasBarajadas = listaDePreguntas.shuffled()
    @State private var preguntaActualIndex = 0
    @State private var puntuacion = 0
    @State private var feedbackMensaje = ""
    @State private var colorFeedback = Color.clear
    @State private var botonesDesactivados = false // Evita doble tap

    // Variable computada para la pregunta actual
    private var preguntaActual: Pregunta {
        preguntasBarajadas[preguntaActualIndex]
    }
    
    var body: some View {
        ZStack {
            // Fondo de jungla
            colorJunglaFondo.ignoresSafeArea()
            
            // --- NUEVO: Capa de Hojas de Fondo ---
            ZStack {
                Image(systemName: "leaf.fill")
                    .font(.system(size: 150))
                    .foregroundColor(colorHojasFondo)
                    .opacity(0.3)
                    .rotationEffect(.degrees(-30))
                    .offset(x: -120, y: -200)

                Image(systemName: "leaf.fill")
                    .font(.system(size: 200))
                    .foregroundColor(colorHojasFondo)
                    .opacity(0.2)
                    .rotationEffect(.degrees(40))
                    .offset(x: 100, y: 150)
                
                Image(systemName: "leaf.fill")
                    .font(.system(size: 120))
                    .foregroundColor(colorHojasFondo)
                    .opacity(0.25)
                    .rotationEffect(.degrees(10))
                    .offset(x: 130, y: -250)
                    
                Image(systemName: "leaf.fill")
                    .font(.system(size: 180))
                    .foregroundColor(colorHojasFondo)
                    .opacity(0.2)
                    .rotationEffect(.degrees(120))
                    .offset(x: -100, y: 300)
            }
            .ignoresSafeArea()
            // --- FIN DE Capa de Hojas ---
            
            VStack(spacing: 20) {
                
                // --- 1. Puntuación (Estilo madera) ---
                Text("Puntos: \(puntuacion)")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(colorMadera.opacity(0.8))
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(colorMaderaOscura, lineWidth: 3)
                    )
                    .shadow(color: .black.opacity(0.3), radius: 5, y: 3)
                    .padding(.top, 20)
                
                // --- 2. Tarjeta de Pregunta (Estilo papiro) ---
                VStack {
                    Image(systemName: preguntaActual.imagenSimbolo)
                        .font(.system(size: 80))
                        .foregroundColor(colorMadera)
                        .padding()
                    
                    Text(preguntaActual.texto)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(colorTinta)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity)
                .background(colorPapiro)
                .cornerRadius(20)
                .overlay( // Borde de madera
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(colorMaderaOscura, lineWidth: 8)
                )
                .padding(.horizontal, 20)
                .shadow(color: .black.opacity(0.4), radius: 10, y: 10)

                // --- 3. Mensaje de Feedback (ACTUALIZADO) ---
                Text(feedbackMensaje)
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundColor(colorFeedback)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 20) // Añadido para descripciones largas
                    .multilineTextAlignment(.center) // Añadido
                    .transition(.scale)
                    .frame(minHeight: 40) // Cambiado de height a minHeight
                
                // --- 4. Botones de Respuesta (Estilo madera) ---
                VStack(spacing: 15) {
                    ForEach(preguntaActual.opciones, id: \.self) { opcion in
                        Button(action: {
                            if !botonesDesactivados {
                                verificarRespuesta(opcion)
                            }
                        }) {
                            BotonRespuesta(texto: opcion)
                        }
                    }
                }
                .padding(.horizontal, 30)
                .disabled(botonesDesactivados) // Desactiva botones al responder
                
                Spacer() // Empuja todo hacia arriba
            }
        }
        .onAppear {
            // (Baraja las preguntas al entrar)
            preguntasBarajadas.shuffle()
        }
    }
    
    // --- 5. Lógica del Juego (ACTUALIZADA) ---
    
    func verificarRespuesta(_ opcionSeleccionada: String) {
        botonesDesactivados = true // Bloquea los botones
        
        withAnimation {
            if opcionSeleccionada == preguntaActual.respuestaCorrecta {
                // --- RESPUESTA CORRECTA ---
                feedbackMensaje = preguntaActual.descripcion // Muestra la descripción
                colorFeedback = .green
                puntuacion += 10
                
                // Espera más tiempo para dar chance de leer y pasa a la siguiente
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    siguientePregunta()
                }
            } else {
                // --- RESPUESTA INCORRECTA ---
                feedbackMensaje = "¡Intenta otra vez!"
                colorFeedback = .red
                
                // Espera un segundo, borra el mensaje y reactiva los botones
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    withAnimation {
                        feedbackMensaje = ""
                    }
                    botonesDesactivados = false // Permite intentarlo de nuevo
                }
            }
        }
    }
    
    // Esta función ahora SÓLO se llama cuando la respuesta es correcta
    func siguientePregunta() {
        withAnimation {
            // Avanza al índice. Si llega al final, % vuelve al inicio (juego infinito)
            preguntaActualIndex = (preguntaActualIndex + 1) % preguntasBarajadas.count
            
            // Si vuelve al inicio, baraja de nuevo
            if preguntaActualIndex == 0 {
                preguntasBarajadas.shuffle()
            }
            
            feedbackMensaje = ""
            botonesDesactivados = false // Reactiva los botones
        }
    }
}

// --- 6. Vista Personalizada para el Botón ---
struct BotonRespuesta: View {
    let texto: String
    
    var body: some View {
        Text(texto)
            .font(.system(size: 24, weight: .bold, design: .rounded))
            .foregroundColor(.white) // Texto blanco
            .frame(maxWidth: .infinity)
            .padding(15)
            .background(colorMadera) // Fondo marrón
            .cornerRadius(15)
            .shadow(color: colorMaderaOscura.opacity(0.7), radius: 3, y: 5) // Sombra 3D
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(colorMaderaOscura, lineWidth: 3) // Borde
            )
    }
}


// --- 7. Vista Previa ---
#Preview {
    PreguntasRetadorasView()
}

