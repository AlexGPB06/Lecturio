import SwiftUI

// 1. TU VISTA DE INICIO
// Tal como pediste, la estructura se llama 'inicioview'
struct inicioview: View {
    
    // Esta variable controla si debemos navegar al menú principal o no
    @State private var irAlMenuPrincipal = false
    
    var body: some View {
        // NavigationStack es necesario para manejar la transición a la siguiente vista
        NavigationStack {
            VStack(spacing: 40) {
                
                Spacer() // Empuja el contenido hacia el centro
                
                // --- 1. Logo Provisional ---
                // Usamos un 'SF Symbol' de Apple como logo base.
                // Puedes cambiar "app.badge.fill" por cualquier otro ícono.
                Image(systemName: "app.badge.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.blue) // Color provisional
                
                Text("Nombre de tu App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer() // Otro espaciador
                
                // --- 2. Botón de Huella ---
                // Este es el botón que activa la navegación
                Button(action: {
                    // Al hacer tap, activamos la variable de estado
                    self.irAlMenuPrincipal = true
                }) {
                    // Usamos el ícono 'touchid' de SF Symbols para la huella
                    Image(systemName: "touchid")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.primary) // Color primario (se adapta a modo oscuro/claro)
                }
                .padding(.bottom, 60) // Un poco de espacio en la parte inferior

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Ocupa toda la pantalla
            .background(Color(.systemBackground)) // Fondo del sistema
            
            // --- 3. Lógica de Navegación ---
            // Esto "escucha" cuando 'irAlMenuPrincipal' cambia a 'true'
            // y automáticamente navega a 'contenttview()'
            .navigationDestination(isPresented: $irAlMenuPrincipal) {
                contenttview() // Aquí llamas a tu vista principal
            }
        }
    }
}

// Esto es para previsualizar tu 'inicioview' en Xcode
struct inicioview_Previews: PreviewProvider {
    static var previews: some View {
        inicioview()
    }
}
