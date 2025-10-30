import SwiftUI

// --- 1. Definición de Modelos ---

/// Representa un solo cuento con su título y contenido.
struct Cuento: Identifiable, Hashable {
    let id = UUID()
    let titulo: String
    let texto: String
}

/// Representa una categoría de cuentos (un género).
struct CategoriaCuentos: Identifiable, Hashable {
    let id = UUID()
    let genero: String
    let imagenSimbolo: String // Icono para el menú
    let cuentos: [Cuento]
}

// --- 2. Contenido de los Cuentos ---

let listaDeCategorias: [CategoriaCuentos] = [
    
    // --- Categoría 1: Fábulas Clásicas ---
    CategoriaCuentos(
        genero: "Fábulas Clásicas",
        imagenSimbolo: "tortoise.fill", // Icono de tortuga
        cuentos: [
            Cuento(titulo: "La Liebre y la Tortuga",
                   texto: "Había una vez una liebre muy rápida que siempre se burlaba de una tortuga lenta. \"¿Quieres una carrera?\", preguntó la liebre riendo. La tortuga aceptó.\n\nLa liebre salió corriendo y, al ver que tenía tanta ventaja, decidió dormir una siesta. Mientras dormía, la tortuga siguió caminando, paso a pasito, sin detenerse.\n\nCuando la liebre despertó, vio que la tortuga estaba a punto de cruzar la meta. Corrió lo más rápido que pudo, pero ya era tarde. La tortuga ganó la carrera.\n\nMoraleja: Despacio y con constancia, se puede ganar la carrera."),
            Cuento(titulo: "El León y el Ratón",
                   texto: "Un león dormía en la selva cuando un pequeño ratón pasó corriendo sobre su nariz. El león se despertó enojado y atrapó al ratón con su garra.\n\n\"¡Perdóname!\", chilló el ratón. \"Si me dejas ir, algún día te devolveré el favor\". El león se rio tanto que le dio pena y lo soltó.\n\nDías después, unos cazadores atraparon al león con una red. El león rugió de frustración. El ratoncito escuchó el rugido, corrió hacia él y mordisqueó las cuerdas de la red hasta romperlas, liberando al león.\n\nMoraleja: Ningún acto de bondad, por pequeño que sea, es en vano."),
            Cuento(titulo: "El Pastor Mentiroso",
                   texto: "Un joven pastor cuidaba sus ovejas cerca del pueblo y se aburría mucho. Un día, decidió gastar una broma y gritó: \"¡Viene el lobo! ¡Auxilio!\".\n\nLos aldeanos corrieron a ayudarlo, pero al llegar, el pastor se reía. \"¡Era una broma!\".\n\nHizo lo mismo al día siguiente. Los aldeanos volvieron a correr, y el pastor volvió a reírse.\n\nUn día, un lobo de verdad apareció y empezó a atacar a las ovejas. El pastor gritó con todas sus fuerzas: \"¡EL LOBO! ¡ES VERDAD!\". Pero esta vez, nadie del pueblo le creyó y el lobo se comió todas sus ovejas.\n\nMoraleja: Nadie cree a un mentiroso, incluso cuando dice la verdad."),
            Cuento(titulo: "La Cigarra y la Hormiga",
                   texto: "Durante todo el verano, una cigarra cantaba y descansaba al sol. Mientras tanto, su vecina, una hormiga, trabajaba duro, guardando comida para el invierno.\n\n\"¡Deja de trabajar y ven a cantar conmigo!\", le decía la cigarra. \"No puedo\", respondía la hormiga, \"debo prepararme para el frío\".\n\nLlegó el invierno. La cigarra, temblando de frío y sin comida, fue a la casa de la hormiga. \"Tengo hambre, ¿me das algo?\".\n\nLa hormiga le dijo: \"Si cantaste todo el verano, ahora baila mientras yo como\".\n\nMoraleja: Primero trabaja y ahorra, y luego podrás descansar y jugar.")
        ]
    ),
    
    // --- Categoría 2: Cuentos Mágicos ---
    CategoriaCuentos(
        genero: "Cuentos Mágicos",
        imagenSimbolo: "wand.and.stars", // Icono de varita
        cuentos: [
            Cuento(titulo: "El Dragón Amistoso",
                   texto: "En un castillo en las nubes, vivía un dragón llamado Chispas. Chispas no echaba fuego; echaba burbujas de colores. Un día, una princesa llamada Lía escaló hasta el castillo. No tenía miedo.\n\n\"¿No vas a comerme?\", preguntó Lía. Chispas negó con la cabeza y sopló un montón de burbujas que hicieron reír a Lía. Se hicieron los mejores amigos y jugaban a reventar burbujas todo el día."),
            Cuento(titulo: "La Hada del Bosque",
                   texto: "Nina se perdió en el bosque. Estaba asustada, pero de pronto, una pequeña luz brillante apareció. Era un hada del tamaño de su pulgar. \"¿Estás perdida?\", preguntó el hada con voz de campanita.\n\nNina asintió. El hada sonrió y le dijo: \"Sigue el camino de las setas azules y encontrarás tu casa\". Nina le dio las gracias y, siguiendo las setas, llegó a su jardín justo para la cena."),
            Cuento(titulo: "El Espejo Mágico",
                   texto: "Tomás encontró un espejo viejo en el ático. No reflejaba su cara. Reflejaba un parque lleno de perros que hablaban. \"¡Hola, Tomás!\", ladró un perro salchicha. Tomás se asustó, pero el perro le dijo: \"Solo queríamos invitarte a jugar\". Tomás metió la mano en el espejo y sintió el pasto. Fue el mejor día de juegos de su vida."),
            Cuento(titulo: "El Gnomo del Jardín",
                   texto: "Cada noche, las verduras del jardín de Sara desaparecían. Una noche, Sara se quedó despierta y vio a un gnomo con un gorro rojo. \"¡Mi tomate!\", gritó Sara. El gnomo se asustó.\n\n\"Lo siento\", dijo el gnomo, \"es que tus verduras son las mejores\". Sara y el gnomo hicieron un trato: él cuidaría el jardín de las plagas, y a cambio, podría tomar una zanahoria cada martes.")
        ]
    ),
    
    // --- Categoría 3: Aventuras Espaciales ---
    CategoriaCuentos(
        genero: "Aventuras Espaciales",
        imagenSimbolo: "figure.spacesuit", // Icono de traje espacial
        cuentos: [
            Cuento(titulo: "El Robot Perdido",
                   texto: "En el año 3000, un niño llamado Leo tenía un robot mascota llamado Bolt. Un día, Bolt se perdió en un planeta de chatarra. Leo voló en su nave espacial para buscarlo.\n\n\"¡Bolt!\", gritaba Leo. Solo oía el eco. Finalmente, vio una pequeña luz roja parpadeando. ¡Era Bolt! Se había quedado sin batería jugando con unos marcianos verdes. Leo lo recargó y volvieron a casa juntos."),
            Cuento(titulo: "Viaje a la Luna de Queso",
                   texto: "Dos ratones astronautas, Tito y Roco, construyeron un cohete con latas de atún. Su misión: ¡comprobar si la luna era de queso! Aterrizaron y Roco dio un mordisco. \"¡Puaj!\", exclamó. \"¡No es queso, es piedra!\". Tito se rio. \"Bueno, ¡al menos trajimos queso en nuestra mochila!\". Y así, hicieron un picnic en la luna."),
            Cuento(titulo: "La Estrella Fugaz",
                   texto: "Zoe miraba por la ventana de su nave. Vio una estrella fugaz que caía en el Planeta Púrpura. Aterrizó para verla. No era una estrella, ¡era un perrito espacial brillante! El perrito estaba triste porque se había caído de su constelación.\n\nZoe usó su nave para llevar al perrito de vuelta al cielo, y desde esa noche, la constelación del \"Cachorro\" brilla más fuerte."),
            Cuento(titulo: "El Planeta de Dulces",
                   texto: "El Capitán Kiko estrelló su nave de gomita en un planeta desconocido. ¡El suelo era de chocolate! Los ríos eran de refresco de fresa y los árboles tenían paletas en lugar de hojas. \"¡Es el mejor planeta del universo!\", gritó Kiko.\n\nPero pronto, le dolió la panza de tanto dulce. Reparó su nave y decidió que era mejor comer dulces solo los sábados.")
        ]
    ),
    
    // --- Categoría 4: Misterios Divertidos ---
    CategoriaCuentos(
        genero: "Misterios Divertidos",
        imagenSimbolo: "magnifyingglass", // Icono de lupa
        cuentos: [
            Cuento(titulo: "El Caso del Juguete Roto",
                   texto: "La Detective Duna investigaba el caso del camión de bomberos roto. Había tres sospechosos: el Gato Pelusa, el Perro Max y su hermanito Lalo.\n\nInterrogó al gato, pero estaba dormido. Interrogó a Max, pero perseguía su cola. Finalmente, vio a Lalo con pintura roja en las manos, igual a la del camión. \"¡Caso resuelto!\", dijo Duna. \"¡El culpable fue Lalo!\". Lalo se rio y le dio un abrazo."),
            Cuento(titulo: "El Ladrón de Galletas",
                   texto: "Mamá había horneado 10 galletas. Ahora solo quedaban 5. \"¡Un ladrón de galletas!\", anunció el Inspector Pipo. Buscó pistas. Vio migas en el suelo que iban de la cocina... ¡a la casa del perro!\n\nAllí estaba Roco, dormido y con la panza llena. Pipo sonrió. \"Te atrapé, Roco\". Roco abrió un ojo y lamió una miga de su nariz. ¡Misterio resuelto!"),
            Cuento(titulo: "El Sombrero Volador",
                   texto: "El sombrero del Abuelo Pepe salió volando por la ventana. \"¡Síguelo!\", gritó el abuelo. El sombrero voló por el parque, giró en la fuente y subió a un árbol. \"¿Cómo bajamos eso?\", preguntó Pepe.\n\nDe pronto, una ardilla salió del sombrero, lo empujó, y el sombrero cayó. ¡La ardilla solo quería ver qué había dentro! Pepe se puso su sombrero y le dejó una nuez a la ardilla."),
            Cuento(titulo: "La Huella en el Lodo",
                   texto: "Llovía mucho. Cuando paró, Lola vio una huella gigante de lodo en la sala. ¡Pero la puerta estaba cerrada! ¿Cómo entró? Lola miró la huella. Tenía tres dedos grandes. Miró al gato (patas pequeñas). Miró al pez (sin patas). \n\nEntonces, vio a su papá, que se había quitado los zapatos. ¡Pero tenía un calcetín lleno de lodo! \"¡Papá!\", se rio Lola. \"¡Tú eres el monstruo de lodo!\".")
        ]
    )
]


// --- 3. Colores y Fuentes del Tema ---
let colorPapiro = Color(red: 0.96, green: 0.94, blue: 0.88) // Fondo
let colorTinta = Color(red: 0.3, green: 0.2, blue: 0.1) // Texto


// --- 4. Vista Principal (La Biblioteca de Géneros) ---
struct CuentosView: View {
    
    var body: some View {
        // La navegación es necesaria para los menús
        NavigationStack {
            ZStack {
                // Fondo color papiro
                colorPapiro.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        
                        // Título de la Biblioteca
                        Text("Biblioteca de Cuentos")
                            .font(.system(size: 36, weight: .bold, design: .serif))
                            .foregroundColor(colorTinta)
                            .padding(.horizontal)
                            .padding(.top, 20)

                        // Cuadrícula de categorías
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(listaDeCategorias) { categoria in
                                // El enlace lleva a la lista de cuentos de esa categoría
                                NavigationLink(value: categoria) {
                                    CategoriaRowView(categoria: categoria)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            // Define a dónde va cada tipo de enlace
            .navigationDestination(for: CategoriaCuentos.self) { categoria in
                ListaCuentosView(categoria: categoria)
            }
            .navigationDestination(for: Cuento.self) { cuento in
                DetalleCuentoView(cuento: cuento)
            }
            .navigationTitle("Biblioteca")
            .navigationBarHidden(true) // Ocultamos la barra para usar nuestro título
        }
    }
}

// --- 5. Vistas de Apoyo y Menús ---

/// La tarjeta para cada Categoría en el menú principal
struct CategoriaRowView: View {
    let categoria: CategoriaCuentos
    
    var body: some View {
        VStack {
            Image(systemName: categoria.imagenSimbolo)
                .font(.system(size: 50))
                .foregroundColor(.white)
            
            Text(categoria.genero)
                .font(.system(size: 16, weight: .bold, design: .serif))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(minWidth: 150, minHeight: 150)
        .padding(10)
        .background(Color.brown.opacity(0.8)) // Fondo como portada de libro
        .cornerRadius(15)
        .shadow(color: colorTinta.opacity(0.3), radius: 5, y: 5)
    }
}


/// La vista del Sub-Menú (lista de cuentos de un género)
struct ListaCuentosView: View {
    let categoria: CategoriaCuentos
    
    var body: some View {
        ZStack {
            colorPapiro.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    // Muestra el ícono del género en grande
                    Image(systemName: categoria.imagenSimbolo)
                        .font(.system(size: 60))
                        .foregroundColor(colorTinta.opacity(0.6))
                        .padding(.top, 20)
                    
                    // Lista de cuentos
                    ForEach(categoria.cuentos) { cuento in
                        NavigationLink(value: cuento) {
                            CuentoRowView(titulo: cuento.titulo)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(categoria.genero)
        .navigationBarTitleDisplayMode(.inline)
        // Estilo de la barra de navegación para que combine
        .toolbarBackground(Color.brown.opacity(0.8), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar) // Texto de la barra en blanco
    }
}

/// La fila para cada Cuento en el sub-menú
struct CuentoRowView: View {
    let titulo: String
    
    var body: some View {
        HStack {
            Text(titulo)
                .font(.system(size: 20, weight: .medium, design: .serif))
                .foregroundColor(colorTinta)
                .padding()
            Spacer()
            Image(systemName: "book.fill")
                .foregroundColor(colorTinta.opacity(0.5))
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.5))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(colorTinta.opacity(0.2), lineWidth: 1)
        )
    }
}


/// La vista final donde se lee el cuento
struct DetalleCuentoView: View {
    let cuento: Cuento
    
    var body: some View {
        ZStack {
            colorPapiro.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    
                    // Título del Cuento
                    Text(cuento.titulo)
                        .font(.system(size: 34, weight: .bold, design: .serif))
                        .foregroundColor(colorTinta)
                        .padding(.top, 20)
                    
                    // Separador decorativo
                    Text("~ * ~")
                        .font(.system(size: 24, design: .serif))
                        .foregroundColor(colorTinta.opacity(0.6))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    // Texto del Cuento
                    Text(cuento.texto)
                        .font(.system(size: 20, weight: .regular, design: .serif))
                        .foregroundColor(colorTinta.opacity(0.9))
                        .lineSpacing(8) // Espacio entre líneas, como en un libro
                        .padding(.bottom, 30)
                    
                }
                .padding(.horizontal, 25)
            }
        }
        .navigationTitle(cuento.titulo)
        .navigationBarTitleDisplayMode(.inline)
        // Estilo de la barra de navegación
        .toolbarBackground(Color.brown.opacity(0.8), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}


// --- 6. Vista Previa ---
#Preview {
    // Se previsualiza la vista principal
    CuentosView()
}
//
//  CuentoView.swift
//  Lecturio
//
//  Created by Alumno on 28/10/25.
//

