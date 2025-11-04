import SwiftUI

// MARK: - Vista Principal
struct MiPerfilView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ZStack {
            // 1. Color de maleta en TODA la pantalla
            Color(red: 0.5, green: 0.35, blue: 0.25)
                .edgesIgnoringSafeArea(.all)
            
            // 2. Contenido (Layouts)
            ScrollView(.vertical, showsIndicators: false) { // Hacemos scroll por si el contenido no cabe
                if horizontalSizeClass == .compact {
                    // MODO COMPACTO (Teléfono Vertical)
                    PerfilVerticalLayout()
                        .padding(.top, 70) // Espacio para el asa
                        .padding(.horizontal)
                        .padding(.bottom, 60) // Espacio para los remaches
                } else {
                    // MODO REGULAR (iPad, Teléfono Horizontal)
                    PerfilHorizontalLayout()
                        .padding(.top, 70) // Espacio para el asa
                        .padding(.horizontal, 40)
                        .padding(.bottom, 60)
                }
            }
            .edgesIgnoringSafeArea(.top) // El scroll empieza desde arriba

            
            // 3. Elementos fijos de la maleta (Asa y Remaches)
            VStack {
                HandleView()
                    .padding(.top, 20)
                Spacer()
            }
            .padding(.top, 20) // Ajuste para la barra de estado
            .edgesIgnoringSafeArea(.top)
            
            RivetsView() // Los remaches en las esquinas
        }
        .foregroundColor(.white)
    }
}

// MARK: - Layout Vertical (Compact)
struct PerfilVerticalLayout: View {
    var body: some View {
        VStack(spacing: 30) { // Más espacio
            PhotoView(size: 130)
            
            InfoSectionView()
            
            // --- NUEVA SECCIÓN ---
            MedallasSectionView()
            
            Spacer(minLength: 30) // Un poco de espacio antes de los stickers
            
            TravelStickersView()
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

// MARK: - Layout Horizontal (Regular)
struct PerfilHorizontalLayout: View {
    var body: some View {
        HStack(alignment: .top, spacing: 30) {
            
            // Columna Izquierda: Foto y Stickers
            VStack(spacing: 40) {
                PhotoView(size: 160)
                TravelStickersView()
                Spacer()
            }
            .frame(minWidth: 200, maxWidth: 300)
            .padding([.leading, .vertical])
            
            // Columna Derecha: Información
            VStack(alignment: .leading, spacing: 30) {
                InfoSectionView()
                
                // --- NUEVA SECCIÓN ---
                MedallasSectionView()
                
                Spacer() // Empuja todo hacia arriba
            }
            .padding([.trailing, .vertical])
        }
        .padding(.top, 20) // Espacio bajo el asa
    }
}


// MARK: - Componentes Reutilizables

struct RivetsView: View {
    var body: some View {
        VStack {
            HStack {
                Circle().fill(.gray.opacity(0.7)).frame(width: 15, height: 15)
                Spacer()
                Circle().fill(.gray.opacity(0.7)).frame(width: 15, height: 15)
            }
            Spacer()
            HStack {
                Circle().fill(.gray.opacity(0.7)).frame(width: 15, height: 15)
                Spacer()
                Circle().fill(.gray.opacity(0.7)).frame(width: 15, height: 15)
            }
        }
        .padding(25)
        .edgesIgnoringSafeArea(.all)
    }
}

struct HandleView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.black.opacity(0.7))
            .frame(width: 130, height: 35)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 2)
            )
    }
}

struct PhotoView: View {
    let size: CGFloat

    var body: some View {
        Image(systemName: "person.crop.circle.fill") // Placeholder
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(color: .black.opacity(0.3), radius: 5)
            .padding(.top)
    }
}

struct InfoSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            FilaInfoView(icono: "person.text.rectangle.fill", etiqueta: "Nombre", valor: "Ana López")
            FilaInfoView(icono: "mappin.and.ellipse", etiqueta: "Comida", valor: "Uvas")
            FilaInfoView(icono: "paintpalette.fill", etiqueta: "Color Favorito", valor: "Verde Esmeralda")
        }
        .padding(30)
        .background(Color.white.opacity(0.1))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.4), style: StrokeStyle(lineWidth: 2, dash: [5]))
        )
    }
}

// --- CAMBIO: TEXTO MÁS GRANDE ---
struct FilaInfoView: View {
    let icono: String
    let etiqueta: String
    let valor: String

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: icono)
                .font(.title) // Icono grande
                .foregroundColor(.white.opacity(0.8))
                .frame(width: 40)

            VStack(alignment: .leading, spacing: 2) {
                Text(etiqueta.uppercased())
                    .font(.headline) // <-- MÁS GRANDE
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.7))
                
                Text(valor)
                    .font(.system(.largeTitle, design: .rounded)) // <-- MUCHO MÁS GRANDE
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.7) // Permite que se encoja si no cabe
                    .lineLimit(1)
            }
            Spacer()
        }
    }
}

// --- NUEVO COMPONENTE: MEDALLAS ---
struct MedallasSectionView: View {
    
    // Define las columnas para la cuadrícula
    // Se adaptarán automáticamente al ancho
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 50))
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Medallas")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.leading, 5)

            // Cuadrícula de 10 círculos
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(0..<10, id: \.self) { _ in
                    // Símbolo de círculo vacío
                    Image(systemName: "circle")
                        .font(.system(size: 35))
                        .foregroundColor(.white.opacity(0.4))
                }
            }
        }
        .padding(30)
        .background(Color.white.opacity(0.1))
        .cornerRadius(20)
        .overlay(
            // Efecto de costura
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.4), style: StrokeStyle(lineWidth: 2, dash: [5]))
        )
    }
}

// --- Componente de Stickers ---
struct TravelStickersView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ZStack {
                Circle().fill(Color.blue.opacity(0.9)).frame(width: 70, height: 70)
                Image(systemName: "airplane")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            .rotationEffect(.degrees(15))
            .padding(.leading, 20)
            
            ZStack {
                Circle().fill(Color.yellow).frame(width: 60, height: 60)
                Text("MX")
                    .font(.system(size: 24, weight: .black))
                    .foregroundColor(.black)
            }
            .rotationEffect(.degrees(-10))
            
            ZStack {
                Circle().fill(Color.green.opacity(0.8)).frame(width: 65, height: 65)
                Image(systemName: "globe.americas.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            .rotationEffect(.degrees(8))
            .padding(.leading, 30)
        }
        .shadow(color: .black.opacity(0.2), radius: 5, y: 3)
    }
}

// MARK: - Preview
struct MiPerfilView_Previews: PreviewProvider {
    static var previews: some View {
        MiPerfilView()
            .previewDevice("iPhone 14 Pro")
            .previewDisplayName("iPhone 14 Pro (Vertical)")
        
        MiPerfilView()
            .previewDevice("iPad Pro (11-inch) (4th generation)")
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDisplayName("iPad Pro 11\" (Horizontal)")
    }
}
