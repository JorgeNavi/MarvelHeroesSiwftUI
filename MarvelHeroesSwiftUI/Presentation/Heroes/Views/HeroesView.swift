import SwiftUI

struct HeroesView: View {
    
    @Environment(HeroesViewModel.self) var viewModel
    
    @State private var searchText: String = ""
    
    
    // Configuración de la cuadrícula
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search hero...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .onChange(of: searchText) { oldValue, newValue in
                        viewModel.filterUI = newValue
                    }
                
                if viewModel.state == .loading {
                    ProgressView("Loading heroes...")
                        .padding()
                } else if case .error(let message) = viewModel.state {
                    Text("⚠️ \(message)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.heroesData) { hero in
                                NavigationLink(destination: HeroDetailView(viewModel: HeroDetailViewModel(hero: hero))) {
                                    HeroCardView(hero: hero)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Héroes")
        }
    }
}

// MARK: - Vista de Tarjeta de Héroe
struct HeroCardView: View {
    let hero: Hero
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: hero.photo)) { image in
                image.resizable()
                     .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(hero.name)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.top, 4)
        }
        .frame(width: 160, height: 200)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 4)
    }
}

// MARK: - Vista Previa
struct HeroesView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HeroesViewModel(useCaseHeroes: HeroesUseCaseMock())
        return HeroesView().environment(viewModel)
    }
}
