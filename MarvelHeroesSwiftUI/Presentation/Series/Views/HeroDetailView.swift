import SwiftUI

struct HeroDetailView: View {
    @Bindable var viewModel: HeroDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: viewModel.hero.photo)) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 5)
                
                Text(viewModel.hero.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 8)
                
                Text((viewModel.hero.description.isEmpty ? "No description available." : viewModel.hero.description))
                    .font(.body)
                    .padding(.top, 4)
                
                Divider()
                
                Text("Series en las que aparece:")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 8)
                
                if viewModel.state == .loading {
                    ProgressView("Cargando series...")
                        .padding()
                } else if case .error(let message) = viewModel.state {
                    Text("⚠️ \(message)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    LazyVStack {
                        ForEach(viewModel.series, id: \.id) { serie in
                            SerieCardView(serie: serie)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.hero.name)
    }
}


#Preview {
    let mockHero = HeroResult(
        id: 1011334,
        name: "Hulk",
        description: "El gigante esmeralda más fuerte del universo Marvel.",
        modified: Date(),
        thumbnail: HeroThumbnail(
            path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
            thumbnailExtension: .jpg
        ),
        resourceURI: "http://gateway.marvel.com/v1/public/characters/1011334",
        comics: HeroComics(available: 12, collectionURI: "", items: [], returned: 12),
        series: HeroComics(available: 3, collectionURI: "", items: [], returned: 3),
        stories: HeroStories(available: 21, collectionURI: "", items: [], returned: 20),
        events: HeroComics(available: 1, collectionURI: "", items: [], returned: 1),
        urls: []
    )
    
    let viewModel = HeroDetailViewModel(hero: mockHero, useCaseSeries: SeriesUseCaseMock())
    return HeroDetailView(viewModel: viewModel)
}

