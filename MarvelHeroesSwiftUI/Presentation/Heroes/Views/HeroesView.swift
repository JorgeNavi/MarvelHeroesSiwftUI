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




#Preview {
    let viewModel = HeroesViewModel(useCaseHeroes: HeroesUseCaseMock())
    return HeroesView().environment(viewModel)
}
