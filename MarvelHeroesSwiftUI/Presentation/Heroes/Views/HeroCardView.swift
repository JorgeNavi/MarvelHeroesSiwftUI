

import SwiftUI


struct HeroCardView: View {
    let hero: HeroResult
    
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



#Preview {
    let mockHero = HeroResult(
        id: 1011334,
        name: "Spider-Man",
        description: "El icónico héroe de Marvel con habilidades arácnidas.",
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
    
    HeroCardView(hero: mockHero)
}
 
