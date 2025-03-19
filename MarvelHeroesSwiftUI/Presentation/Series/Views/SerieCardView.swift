import SwiftUI


//MARK: View of simple serie card
struct SerieCardView: View {
    
    let serie: SerieResult
    
    var body: some View {
        VStack(alignment: .leading) {
            //Image first
            AsyncImage(url: URL(string: "\(serie.thumbnail.path).\(serie.thumbnail.thumbnailExtension)")) { image in
                image.resizable()
                    .scaledToFill()
                //if image is missing or has not loaded:
            } placeholder: {
                ProgressView()
                    .id("serie_image_loading_\(serie.id)") //id for testting
            }
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .id("serie_image_\(serie.id)") //id for testting
            
            //Serie Title
            Text(serie.title)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 4)
                .id("serie_title_\(serie.id)")
            
            //Serie description if there is any
            Text(serie.description ?? "No description available.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .id("serie_description_\(serie.id)") //id for testting
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 4)
        .id("serie_card_\(serie.id)") //id for testting
    }
}

#Preview {
    let mockSerie = SerieResult(
        id: 1,
        title: "The Incredible Hulk",
        description: "Una de las series más icónicas de Marvel.",
        resourceURI: "http://gateway.marvel.com/v1/public/series/1",
        thumbnail: SerieThumbnail(
            path: "https://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
            thumbnailExtension: "jpg"
        )
    )

    SerieCardView(serie: mockSerie)
}
