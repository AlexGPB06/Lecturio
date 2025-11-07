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
    // Opciones de juegos/actividades
    MenuItem(title: "Cuento", iconName: "book.fill", color: .mint),
    MenuItem(title: "Construye la Palabra", iconName: "character.textbox", color: .mint),
    MenuItem(title: "Cartas Emocionales", iconName: "heart.text.square.fill", color: .pink),
    MenuItem(title: "Preguntas Retadoras", iconName: "star.fill", color: .brown),
    MenuItem(title: "Colorea y Aprende", iconName: "paintbrush.fill", color: .yellow),
    MenuItem(title: "Mi Perfil", iconName: "person.fill", color: .blue),
    MenuItem(title: "Ajustes", iconName: "gearshape.fill", color: .gray),
]



// --- FIN DE VISTAS DE RELLENO ---

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
struct contenttview: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    // --- ¡CAMBIO 1: DEFINICIÓN DE LA CUADRÍCULA (GRID)! ---
    // Esto crea columnas flexibles.
    // En iPhone: 1 columna.
    // En iPad: 2, 3 o 4 columnas, dependiendo del espacio.
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 280))
    ]
    
    var body: some View {
        ZStack {
            
            // --- Fondo (Modo Claro/Oscuro) ---
            if isDarkMode {
                NightSkyView()
                    .ignoresSafeArea()
            } else {
                LinearGradient(
                    colors: [Color(red: 0.6, green: 0.9, blue: 1.0), Color(red: 0.7, green: 1.0, blue: 0.7)], // Sky blue to grass green
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            }
            
            // --- ¡CAMBIO 2: De VStack a LazyVGrid! ---
            ScrollView {
                // Usamos LazyVGrid en lugar de VStack
                LazyVGrid(columns: columns, spacing: 25) { // Más espaciado entre tarjetas
                    ForEach(menuItems) { item in
                        
                        // La lógica de navegación sigue igual
                        if item.title == "Construye la Palabra" {
                            NavigationLink(destination: BuildWordGameView()) {
                                // ¡CAMBIO 3: Usamos la nueva tarjeta!
                                MenuItemCard(item: item)
                            }
                            .buttonStyle(PlainButtonStyle())
                        } else if item.title == "Cartas Emocionales" {
                            NavigationLink(destination: EmotionalFacesGameView()) {
                                MenuItemCard(item: item)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                        } else if item.title == "Ajustes" {
                            NavigationLink(destination: OpcionesView()) {
                                MenuItemCard(item: item)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                        } else {
                            Button(action: {
                                print("Has tocado \(item.title)")
                            }) {
                                MenuItemCard(item: item)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(25) // Padding general para la cuadrícula
                .padding(.top, 10)
            }
        }
        // --- Estilos de la Barra de Navegación (sin cambios) ---
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Lecturio")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.heavy) // Bolder
                    .foregroundColor(.white.opacity(0.9)) // Soft white
                    .shadow(radius: 2) // Soft shadow for title
            }
        }
        .toolbarBackground(
            isDarkMode ?
                // Fondo oscuro para la barra
                LinearGradient(colors: [.black.opacity(0.8), .blue.opacity(0.3)], startPoint: .top, endPoint: .bottom) :
                // Fondo claro (el que tenías)
                LinearGradient(colors: [Color(red: 0.6, green: 0.9, blue: 1.0), .cyan], startPoint: .top, endPoint: .bottom),
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .preferredColorScheme(isDarkMode ? .dark : nil)
        .navigationBarBackButtonHidden(true)
    }
}

// --- ¡CAMBIO 4: De "Fila" (Row) a "Tarjeta" (Card)! ---
struct MenuItemCard: View { // Renombrado de MenuItemRow
    let item: MenuItem
    
    // Estado para la animación de balanceo
    @State private var isAnimating = false
    
    var body: some View {
        // --- ¡CAMBIO 5: De HStack a VStack! ---
        // El contenido ahora es vertical (icono arriba, texto abajo)
        VStack(spacing: 20) {
            Spacer() // Empuja el contenido hacia el centro
            
            Image(systemName: item.iconName)
                // --- ¡CAMBIO 6: Icono mucho más grande! ---
                .font(.system(size: 60, weight: .bold)) // Mucho más grande
                .foregroundColor(item.color)
                .frame(height: 65) // Altura fija para alinear
                // Animación de balanceo
                .rotationEffect(.degrees(isAnimating ? -8 : 8)) // Un poco menos de rotación
            
            Spacer()
            
            Text(item.title)
                // --- ¡CAMBIO 7: Texto más grande y centrado! ---
                .font(.system(.title, design: .rounded)) // Más grande
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(2) // Permite hasta 2 líneas
                .frame(height: 60) // Altura fija para alinear texto
            
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity) // Ocupa el ancho de la columna
        .frame(height: 220) // Altura fija para todas las tarjetas
        .padding(15) // Padding interno
        .foregroundColor(.primary.opacity(0.8))
        .background(Color(.systemBackground).opacity(0.85)) // Fondo "nube"
        .cornerRadius(30) // Esquinas más redondeadas
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
        .onAppear {
            // Animación
            withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}
#Preview {
    NavigationStack {
        contenttview()
    }

}


