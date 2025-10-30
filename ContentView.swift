import SwiftUI

// --- 1. Modelo de Datos para cada Fila del Menú ---
struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let iconName: String // Usaremos íconos de SF Symbols
    let color: Color
}

// --- 2. Los Datos del Menú ---
let menuItems: [MenuItem] = [
    // Opci ones de juegos/actividades
    MenuItem(title: "Construye la Palabra", iconName: "character.textbox", color: .mint),
    MenuItem(title: "Cartas Emocionales", iconName: "heart.text.square.fill", color: .pink),
    MenuItem(title: "Juegos de Animales y Sonido", iconName: "pawprint.fill", color: .brown),
    MenuItem(title: "Juegos de Deportes y Movimiento", iconName: "sportscourt.fill", color: .cyan),
    MenuItem(title: "Colorea y Aprende", iconName: "paintbrush.fill", color: .yellow),
    
    // Opciones estándar de la app
    MenuItem(title: "Mi Perfil", iconName: "person.fill", color: .blue),
    MenuItem(title: "Favoritos", iconName: "star.fill", color: .orange),
    MenuItem(title: "Ajustes", iconName: "gearshape.fill", color: .gray),
    // Moví "Cerrar Sesión" a la pantalla de Ajustes
    // MenuItem(title: "Cerrar Sesión", iconName: "arrow.right.to.line", color: .purple)
]

// --- Vistas de Destino (Marcadores de posición) ---
// Dejamos este para que el primer botón funcione.
// 'EmotionalFacesGameView' y 'BuildWordGameView' deben 

// --- ¡NUEVA VISTA! ---
// Esta es la vista para el fondo de noche con estrellas
struct NightSkyView: View {
    var body: some View {
        ZStack {
            // 1. El fondo (gradiente de noche)
            LinearGradient(
                colors: [Color.black, Color(red: 0.0, green: 0.0, blue: 0.2), Color.black],
                startPoint: .top,
                endPoint: .bottom
            )
            
            // 2. Las estrellas (100 círculos blancos en posiciones aleatorias)
            GeometryReader { geo in
                ForEach(0..<100) { _ in
                    Circle()
                        // Color y opacidad aleatoria para las estrellas
                        .fill(Color.white.opacity(Double.random(in: 0.3...0.9)))
                        // Tamaño aleatorio
                        .frame(width: Double.random(in: 1...3), height: Double.random(in: 1...3))
                        .position(
                            // Posición X aleatoria
                            x: CGFloat.random(in: 0...geo.size.width),
                            // Posición Y aleatoria
                            y: CGFloat.random(in: 0...geo.size.height)
                        )
                }
            }
        }
    }
}


// --- 3. La Vista Principal de la Aplicación (Menú) ---
struct ContentView: View {
    
    // --- ¡CAMBIO 1! ---
    // Leemos la variable guardada. Si cambia en OpcionesView,
    // esta vista se enterará y se redibujará.
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        // NavigationStack es esencial para navegar entre vistas
        NavigationStack {
            ZStack {
                
                // --- ¡CAMBIO GRANDE! ---
                // Aquí decidimos qué fondo mostrar basado en 'isDarkMode'
                if isDarkMode {
                    NightSkyView()
                        .ignoresSafeArea()
                } else {
                    // --- FONDO (Alegre cielo a pasto) ---
                    LinearGradient(
                        colors: [Color(red: 0.6, green: 0.9, blue: 1.0), Color(red: 0.7, green: 1.0, blue: 0.7)], // Sky blue to grass green
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                }
                
                // --- CONTENIDO (El Menú Deslizable) ---
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(menuItems) { item in
                            // Decidimos qué vista cargar según el título del item
                            
                            // --- ¡CAMBIO 2! ---
                            // Modificamos el 'if/else' para incluir "Ajustes"
                            
                            if item.title == "Construye la Palabra" {
                                NavigationLink(destination: BuildWordGameView()) {
                                    MenuItemRow(item: item)
                                }
                                .buttonStyle(PlainButtonStyle())
                            } else if item.title == "Cartas Emocionales" {
                                NavigationLink(destination: EmotionalFacesGameView()) {
                                    MenuItemRow(item: item)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                            // ¡ESTA ES LA NUEVA PARTE!
                            } else if item.title == "Ajustes" {
                                NavigationLink(destination: OpcionesView()) {
                                    MenuItemRow(item: item)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                            } else {
                                // Para opciones que no son juegos (o juegos aún no implementados)
                                Button(action: {
                                    print("Has tocado \(item.title)")
                                }) {
                                    MenuItemRow(item: item)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding()
                    .padding(.top, 10)
                }
            }
            // --- Estilo de la Barra de Navegación (Título "Lecturio") ---
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Lecturio")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.heavy) // Bolder
                        .foregroundColor(.white.opacity(0.9)) // Soft white
                        .shadow(radius: 2) // Soft shadow for title
                }
            }
            
            // --- ¡CAMBIO EN EL TOOLBAR! ---
            // Ahora el fondo de la barra de navegación también cambia
            .toolbarBackground(
                isDarkMode ?
                    // Fondo oscuro para la barra
                    LinearGradient(colors: [.black.opacity(0.8), .blue.opacity(0.3)], startPoint: .top, endPoint: .bottom) :
                    // Fondo claro (el que tenías)
                    LinearGradient(colors: [Color(red: 0.6, green: 0.9, blue: 1.0), .cyan], startPoint: .top, endPoint: .bottom),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        // --- ¡CAMBIO 3! ---
        // Este modificador aplica el modo oscuro (o lo quita)
        // a *todo* el NavigationStack (toda la app).
        .preferredColorScheme(isDarkMode ? .dark : nil)
    }
}

// --- 4. Vista para cada Fila del Menú (Aparencia) ---
struct MenuItemRow: View {
    let item: MenuItem
    
    // Estado para la animación de balanceo
    @State private var isAnimating = false
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: item.iconName)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(item.color)
                .frame(width: 40)
                // Animación de balanceo
                .rotationEffect(.degrees(isAnimating ? -10 : 10))
            
            Text(item.title)
                .font(.system(.title2, design: .rounded))
                .fontWeight(.bold)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(.body, weight: .bold))
                .foregroundColor(.gray.opacity(0.4))
        }
        .padding(22)
        
        // --- ¡CAMBIO 4! ---
        // Colores adaptativos para el modo oscuro
        
        // Antes: .foregroundColor(.black.opacity(0.8))
        // Ahora: .primary se vuelve blanco en modo oscuro
        .foregroundColor(.primary.opacity(0.8))
        
        // Antes: .background(Color.white.opacity(0.85))
        // Ahora: Color(.systemBackground) se vuelve negro/gris oscuro en modo oscuro
        .background(Color(.systemBackground).opacity(0.85)) // Fondo "nube"
        
        .cornerRadius(25) // Esquinas muy redondeadas
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
        // Dispara la animación
        .onAppear {
            withAnimation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}


#Preview {
    ContentView()
}

