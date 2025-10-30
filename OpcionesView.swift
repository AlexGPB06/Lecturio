import SwiftUI

struct OpcionesView: View {
    // 1. Creamos una variable de estado que se guarda en UserDefaults.
    // "isDarkMode" es la "llave" donde se guarda.
    // Debe ser la misma llave que usaremos en ContentView.
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some View {
        // Usamos Form para darle un aspecto de lista de opciones
        Form {
            Section(header: Text("Apariencia")) {
                // 2. El Toggle se vincula ($) a nuestra variable.
                // Cuando el usuario lo activa, isDarkMode se vuelve 'true'.
                // Cuando lo desactiva, se vuelve 'false'.
                Toggle("Activar Modo Oscuro", isOn: $isDarkMode)
            }
        }
        .navigationTitle("Opciones") // Título para la barra de navegación
    }
}

#Preview {
    // Envolvemos en NavigationView para que el preview funcione
    NavigationView {
        OpcionesView()
    }
}//
//  OpcionesView.swift
//  Lecturio
//
//  Created by Alumno on 29/10/25.
//

