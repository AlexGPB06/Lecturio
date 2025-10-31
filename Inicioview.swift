import SwiftUI

// --- Vista para una Estrella Individual ---
struct StarView: View {
    // Variables de estado para la animación de cada estrella
    @State private var opacity: Double = Double.random(in: 0.1...0.5)
    let size: CGFloat = Double.random(in: 1...3)
    let position: CGPoint
    let animationDuration: Double = Double.random(in: 1.5...3)

    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: size, height: size)
            .position(position)
            .opacity(opacity)
            .onAppear {
                // Animación de parpadeo infinito
                withAnimation(.easeInOut(duration: animationDuration).repeatForever(autoreverses: true)) {
                    opacity = Double.random(in: 0.5...1.0)
                }
            }
    }
}

// --- Vista para el Fondo de Estrellas ---
struct StarsBackgroundView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // 1. Color de fondo azul marino sólido (navy)
                Color(red: 0, green: 0, blue: 0.2).ignoresSafeArea()
                
                // 2. Genera 150 estrellas en posiciones aleatorias
                ForEach(0..<150) { _ in
                    StarView(position: .init(x: CGFloat.random(in: 0...geo.size.width),
                                             y: CGFloat.random(in: 0...geo.size.height)))
                }
            }
        }
    }
}


// --- VISTA DE INICIO PRINCIPAL ---
struct inicioview: View {
    
    // Estados para la navegación y animaciones
    @State private var irAlMenuPrincipal = false
    @State private var logoScale: CGFloat = 0.8
    @State private var logoOpacity: Double = 0.0
    @State private var fingerprintScale: CGFloat = 0.8
    @State private var fingerprintOpacity: Double = 0.0
    @State private var welcomeText: String = ""
    private let fullWelcomeText = "Bienvenido a Lecturio"
    
    // --- NUEVOS ESTADOS PARA LA TRANSICIÓN ---
    @State private var transitionScale: CGFloat = 1.0
    @State private var transitionOpacity: Double = 1.0
    
    var body: some View {
        NavigationStack {
            ZStack {
                // --- 1. Fondo de Estrellas Animadas ---
                StarsBackgroundView().ignoresSafeArea()
                    .opacity(transitionOpacity) // Se desvanece en la transición
                
                // --- 2. Brillo Sutil Azul (sobre las estrellas) ---
                RadialGradient(colors: [Color.blue.opacity(0.4), Color.clear],
                               center: .center,
                               startRadius: 50,
                               endRadius: 600) // Gradiente más amplio
                    .ignoresSafeArea()
                    .opacity(0.5 * transitionOpacity) // Se desvanece en la transición
                
                // --- 3. Contenido Adaptable (Vertical/Horizontal) ---
                // GeometryReader nos da el tamaño de la pantalla
                GeometryReader { geometry in
                    // ViewThatFits elegirá la primera vista que quepa.
                    // Priorizamos la vertical.
                    ViewThatFits {
                        
                        // --- VISTA VERTICAL (iPhone Vertical, iPad) ---
                        // 'geo' se pasa a la vista hija
                        PortraitView(geo: geometry)
                        
                        // --- VISTA HORIZONTAL (iPhone Horizontal) ---
                        // 'geo' se pasa a la vista hija
                        LandscapeView(geo: geometry)
                    }
                }
                .padding(30) // Un padding general para todo el contenido
                .onAppear {
                    // Dispara las animaciones de entrada
                    animateIn()
                    // Efecto de escritura
                    startTypingEffect()
                }
            }
            .statusBarHidden(true) // Oculta la barra de estado
            .onDisappear {
                // Reinicia la animación si el usuario sale de la vista
                transitionScale = 1.0
                transitionOpacity = 1.0
            }
            // Navegación al menú principal
            .navigationDestination(isPresented: $irAlMenuPrincipal) {
                // Llama a tu vista principal 'contenttview'
                // que está definida en el otro archivo
                contenttview()
            }
        }
    }

    // --- Vista Hija para el modo Vertical ---
    @ViewBuilder
    private func PortraitView(geo: GeometryProxy) -> some View {
        VStack(spacing: 0) { // Reducido el espaciado
            Spacer()
            
            logoView
                // Usa un 30% de la altura de la pantalla
                .frame(height: geo.size.height * 0.3)
                .opacity(transitionOpacity) // Se desvanece
            
            welcomeTextView
                .padding(.vertical, 30)
                .opacity(transitionOpacity) // Se desvanece

            Spacer()
            
            fingerprintButton
                // Usa un 25% de la altura de la pantalla
                .frame(height: geo.size.height * 0.25)
                .scaleEffect(transitionScale) // Crecerá en la transición
                .zIndex(1) // Se asegura de estar por encima de otros elementos
            
            // Un 10% de espacio inferior
            Spacer(minLength: geo.size.height * 0.1)
        }
        .frame(width: geo.size.width) // Ocupa todo el ancho
    }

    // --- Vista Hija para el modo Horizontal ---
    @ViewBuilder
    private func LandscapeView(geo: GeometryProxy) -> some View {
        HStack(spacing: 40) {
            // Lado Izquierdo (Logo y Texto)
            VStack {
                Spacer()
                logoView
                    // Usa un 40% de la altura (en horizontal)
                    .frame(height: geo.size.height * 0.4)
                welcomeTextView
                Spacer()
            }
            .opacity(transitionOpacity) // Se desvanece todo el V-Stack izquierdo
            // Ocupa un 45% del ancho
            .frame(width: geo.size.width * 0.45)
            
            // Lado Derecho (Huella)
            VStack {
                Spacer()
                fingerprintButton
                    // Usa un 50% de la altura
                    .frame(height: geo.size.height * 0.5)
                    .scaleEffect(transitionScale) // Crecerá en la transición
                    .zIndex(1) // Se asegura de estar por encima
                Spacer()
            }
            // Ocupa un 45% del ancho
            .frame(width: geo.size.width * 0.45)
        }
        .frame(width: geo.size.width) // Ocupa todo el ancho
    }

    // --- Componentes Reutilizables ---
    // (Extraídos para no repetir código)
    
    private var logoView: some View {
        Image(systemName: "electron")
            .resizable()
            .scaledToFit()
            .foregroundColor(.cyan)
            .shadow(color: .cyan.opacity(0.7), radius: 20, x: 0, y: 0)
            .scaleEffect(logoScale)
            .opacity(logoOpacity)
    }

    private var welcomeTextView: some View {
        Text(welcomeText)
            .font(.custom("AvenirNext-Bold", size: 36))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .shadow(color: .white.opacity(0.5), radius: 10, x: 0, y: 0)
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.5) // Permite que el texto se haga más pequeño si no cabe
    }

    private var fingerprintButton: some View {
        Button(action: {
            // --- CAMBIO: Llama a la función de transición ---
            performTransition()
        }) {
            Image(systemName: "touchid")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .shadow(color: .white.opacity(0.6), radius: 15, x: 0, y: 0)
                .scaleEffect(fingerprintScale)
                .opacity(fingerprintOpacity)
        }
        .buttonStyle(PlainButtonStyle()) // Evita el tinte azul por defecto
    }

    // --- Funciones de Animación ---
    private func animateIn() {
        // Animación del logo
        withAnimation(.easeOut(duration: 1.5)) {
            logoScale = 1.0
            logoOpacity = 1.0
        }
        // Animación de la huella (con retraso)
        withAnimation(.easeOut(duration: 1.5).delay(0.5)) {
            fingerprintScale = 1.0
            fingerprintOpacity = 1.0
        }
    }
    
    // --- NUEVA FUNCIÓN DE TRANSICIÓN ---
    private func performTransition() {
        // 1. Inicia la animación de "zoom" y "fade out"
        withAnimation(.easeIn(duration: 0.8)) {
            transitionScale = 50.0 // Hace crecer la huella masivamente
            transitionOpacity = 0.0 // Desvanece todo lo demás
        }
        
        // 2. Navega justo antes de que termine la animación
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.irAlMenuPrincipal = true
        }
    }

    private func startTypingEffect() {
        // Reinicia el texto por si acaso
        welcomeText = ""
        var charIndex = 0.0
        for char in fullWelcomeText {
            // Añade cada letra con un pequeño retraso
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.08 * charIndex) {
                welcomeText.append(char)
            }
            charIndex += 1
        }
    }
}

#Preview {
        inicioview()
    }

