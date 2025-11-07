import SwiftUI
import Combine

// --- 1. Modelos de Datos (Sin cambios) ---

/// Representa un objeto sencillo para dibujar
struct ElementoDibujo: Identifiable {
    let id = UUID()
    let nombre: String
}

/// Define una sola línea dibujada por el usuario (MODIFICADO el color default)
struct Linea: Identifiable {
    let id = UUID()
    var puntos: [CGPoint]
    // Cambiado de .white (tiza) a .kirbyBorder (crayón)
    var color: Color = .kirbyBorder
    var grosor: CGFloat = 6.0 // Un poco más grueso para el crayón
}

// --- 2. Colores del Tema "Kirby's Dream Land 3" (NUEVO) ---

extension Color {
    // Colores pastel para fondos y rellenos
    static let kirbyPink = Color(red: 0.98, green: 0.85, blue: 0.87) // Rosa pálido
    static let kirbyBlue = Color(red: 0.85, green: 0.95, blue: 0.98) // Azul cielo suave
    static let kirbyGreen = Color(red: 0.88, green: 0.98, blue: 0.90) // Verde menta claro
    static let kirbyYellow = Color(red: 0.98, green: 0.97, blue: 0.85) // Amarillo muy pálido
    
    // Color para el "trazo" del crayón (bordes y texto)
    static let kirbyBorder = Color(red: 0.4, green: 0.3, blue: 0.3)   // Marrón suave
    
    // Color de fondo que simula papel
    static let kirbyBackground = Color(red: 0.95, green: 0.98, blue: 0.96) // Fondo tipo papel
}

// --- 3. Lista de Dibujos (Sin cambios) ---
let listaDeDibujos: [ElementoDibujo] = [
    ElementoDibujo(nombre: "Gato"),
    ElementoDibujo(nombre: "Perro"),
    ElementoDibujo(nombre: "Sol"),
    ElementoDibujo(nombre: "Casa"),
    ElementoDibujo(nombre: "Flor"),
    ElementoDibujo(nombre: "Árbol"),
    ElementoDibujo(nombre: "Pez"),
    ElementoDibujo(nombre: "Pájaro"),
    ElementoDibujo(nombre: "Estrella"),
    ElementoDibujo(nombre: "Luna"),
    ElementoDibujo(nombre: "Corazón"),
    ElementoDibujo(nombre: "Barco"),
    ElementoDibujo(nombre: "Carro"),
    ElementoDibujo(nombre: "Pelota"),
    ElementoDibujo(nombre: "Mariposa")
]

// --- 4. Helpers de Estilo Kirby (NUEVO) ---

/// Fuente personalizada para el estilo crayón
func kirbyFont(size: CGFloat) -> Font {
    // Intenta usar Chalkduster, si no, usa una de sistema redondeada
    return .custom("Chalkduster", size: size)
}

/// Forma de borde irregular (Sketchy) para simular crayón
struct SketchyBorderedShape<Content: Shape>: View {
    let content: Content
    let borderColor: Color
    let borderWidth: CGFloat
    let sketchiness: CGFloat

    init(content: Content, borderColor: Color = .kirbyBorder, borderWidth: CGFloat = 4, sketchiness: CGFloat = 2) {
        self.content = content
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.sketchiness = sketchiness
    }

    var body: some View {
        ZStack {
            ForEach(0..<Int(sketchiness * 3), id: \.self) { i in
                content
                    .stroke(borderColor.opacity(0.3 / Double(i + 1)), lineWidth: borderWidth)
                    .offset(x: CGFloat.random(in: -sketchiness...sketchiness),
                            y: CGFloat.random(in: -sketchiness...sketchiness))
            }
            content
                .stroke(borderColor, lineWidth: borderWidth)
        }
    }
}

/// Botón estilizado de Kirby (reemplaza el botón estándar)
struct KirbyButton: View {
    let text: String
    let fillColor: Color
    let action: () -> Void // <-- Correcto: ahora es el último
    
    var body: some View {
        Button(action: action) { // Esta parte no cambia
            Text(text)
                .font(kirbyFont(size: 24))
                .foregroundColor(.kirbyBorder)
                .padding(.vertical, 15)
                .padding(.horizontal, 30)
                .background(
                    Capsule()
                        .fill(fillColor)
                        .overlay(
                            SketchyBorderedShape(content: Capsule(), borderColor: .kirbyBorder, borderWidth: 5, sketchiness: 3)
                        )
                        .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
                )
        }
    }
}


// --- 5. Vista Principal del Juego (MODIFICADA CON ESTILO KIRBY) ---
struct DibujoMatematicoView: View {

    // --- Variables de Estado del Juego (Sin cambios) ---
    @State private var dibujosBarajados = listaDeDibujos.shuffled()
    @State private var dibujoActualIndex = 0
    @State private var tiempoRestante = 60
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timerActivo = true
    @State private var lineas: [Linea] = []
    
    // Modificado para usar el color de crayón por defecto
    @State private var lineaActual = Linea(puntos: [], color: .kirbyBorder, grosor: 6.0)
    
    @State private var feedbackMensaje = ""
    @State private var colorFeedback = Color.clear

    // *** 1. ESTA ES LA VARIABLE AÑADIDA PARA LA CORRECCIÓN ***
    private var timerColor: Color {
        tiempoRestante > 10 ? .kirbyGreen : .kirbyPink
    }
    
    private var dibujoActual: ElementoDibujo {
        dibujosBarajados[dibujoActualIndex]
    }

    var body: some View {
        ZStack {
            // Fondo de "papel"
            Color.kirbyBackground.ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                // --- 1. Encabezado (Timer) - Estilo Kirby ---
                HStack {
                    Spacer()
                    ZStack {
                        // Borde "sketchy" para el timer
                        SketchyBorderedShape(content: Circle(), borderColor: .kirbyBorder.opacity(0.4), borderWidth: 6, sketchiness: 2)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(tiempoRestante) / 60.0)
                            // *** 2. AQUÍ SE USA LA VARIABLE CORREGIDA ***
                            .stroke(timerColor, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .animation(.linear(duration: 1.0), value: tiempoRestante)
                        
                        Text("\(tiempoRestante)")
                            .font(kirbyFont(size: 24))
                            .foregroundColor(.kirbyBorder) // Color de texto de crayón
                    }
                    .frame(width: 60, height: 60)
                    .padding(.trailing)
                }
                .padding(.horizontal)

                // --- 2. Pregunta - Estilo Kirby ---
                Text("¡Dibuja un: \(dibujoActual.nombre)!")
                    .font(kirbyFont(size: 32))
                    .foregroundColor(.kirbyBorder) // Color de texto de crayón
                    .padding(.top, 10)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)

                // --- 3. Lienzo de Dibujo - Estilo Kirby ---
                ZStack {
                    Canvas { context, size in
                        for linea in lineas {
                            var path = Path()
                            path.addLines(linea.puntos)
                            context.stroke(path, with: .color(linea.color), style: StrokeStyle(lineWidth: linea.grosor, lineCap: .round, lineJoin: .round))
                        }
                        var pathActual = Path()
                        pathActual.addLines(lineaActual.puntos)
                        context.stroke(pathActual, with: .color(lineaActual.color), style: StrokeStyle(lineWidth: lineaActual.grosor, lineCap: .round, lineJoin: .round))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    // Fondo del lienzo (como una hoja blanca)
                    .background(Color.white)
                    .cornerRadius(10)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { valor in
                                lineaActual.puntos.append(valor.location)
                            }
                            .onEnded { valor in
                                lineas.append(lineaActual)
                                // Resetea al color de crayón por defecto
                                lineaActual = Linea(puntos: [], color: .kirbyBorder, grosor: 6.0)
                            }
                    )
                    
                    // Botón de Borrador - Estilo Kirby
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: borrarLienzo) {
                                Image(systemName: "eraser.fill")
                                    .font(.title)
                                    .foregroundColor(.kirbyPink) // Color pastel
                                    .padding()
                                    .background(
                                        // Fondo de "papel" amarillo
                                        Circle().fill(Color.kirbyYellow)
                                            .overlay(
                                                // Borde sketchy
                                                SketchyBorderedShape(content: Circle(), borderWidth: 4, sketchiness: 2)
                                            )
                                    )
                            }
                            .padding(15)
                        }
                    }
                }
                .padding(.horizontal, 20)
                // Marco del lienzo con color pastel
                .background(Color.kirbyBlue)
                .cornerRadius(15)
                .overlay(
                    // Borde sketchy para el marco
                    SketchyBorderedShape(content: RoundedRectangle(cornerRadius: 15), borderWidth: 6, sketchiness: 3)
                        .padding(.horizontal, 20)
                )
                .padding(.horizontal, 20)
                
                // --- 4. Mensaje de Feedback - Estilo Kirby ---
                Text(feedbackMensaje)
                    .font(kirbyFont(size: 24))
                    .foregroundColor(colorFeedback) // Usará kirbyGreen o kirbyPink
                    .frame(height: 30)
                    .transition(.scale)

                // --- 5. Botón de Siguiente - Estilo Kirby ---
                KirbyButton(text: "Listo / Siguiente", fillColor: .kirbyGreen) {
                    siguienteDibujo(forzado: true) // El usuario decide pasar
                }
                .padding(.bottom)
            }
        }
        .onAppear(perform: iniciarJuego)
        .onReceive(timer) { _ in
            guard timerActivo else { return }
            
            if tiempoRestante > 0 {
                tiempoRestante -= 1
            } else {
                tiempoAgotado()
            }
        }
    }
    
    // --- 6. Lógica del Juego (MODIFICADA para colores Kirby) ---
    
    func iniciarJuego() {
        dibujosBarajados.shuffle()
        generarDibujo()
    }
    
    func generarDibujo() {
        dibujoActualIndex = (dibujoActualIndex + 1) % dibujosBarajados.count
        borrarLienzo()
        feedbackMensaje = ""
        tiempoRestante = 60
        timerActivo = true
        detenerTimer()
        iniciarTimer()
    }
    
    func borrarLienzo() {
        lineas.removeAll()
        lineaActual = Linea(puntos: [], color: .kirbyBorder, grosor: 6.0)
    }
    
    func siguienteDibujo(forzado: Bool) {
        detenerTimer()
        
        if forzado {
            withAnimation {
                feedbackMensaje = "¡Buen dibujo!"
                colorFeedback = .kirbyGreen // Color pastel
            }
        } else {
            withAnimation {
                feedbackMensaje = "¡Tiempo!"
                colorFeedback = .kirbyPink // Color pastel
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                generarDibujo()
            }
        }
    }
    
    func tiempoAgotado() {
        siguienteDibujo(forzado: false)
    }
    
    func detenerTimer() {
        timer.upstream.connect().cancel()
        timerActivo = false
    }
    
    func iniciarTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        timerActivo = true
    }
}

// --- 7. Vista Previa ---
#Preview {
    DibujoMatematicoView()
}
