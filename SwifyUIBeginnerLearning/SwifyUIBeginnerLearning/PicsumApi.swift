//
//  PicsumApi.swift
//  SwifyUIBeginnerLearning
//
//  Created by navaneeth-pt4855 on 01/07/22.
//

import SwiftUI

struct PicsumApi: View {
    
    @State var models: [PicsumModel] = []
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                LazyVGrid(columns: [GridItem(.flexible(minimum: 20, maximum: 1544), spacing: 5, alignment: .center), GridItem(.flexible(minimum: 200, maximum: 1544), spacing: 10, alignment: .center)]) {
                    ForEach(models, id: \.self) { model in
                        NavigationLink {
                            PicsumView(model: model)
                        } label: {
                            ListRow(model: model)
                        }
                    }
                }
            }.onAppear {
                Task {
                    models = await DataManager.shared.getPicsumImages("https://picsum.photos/v2/list") ?? []
                }
            }
            .navigationTitle("Picsum Images")
        }
    }
}

struct PicsumView: View{
    
    let model: PicsumModel
    
    var body: some View{
        VStack{
            
            Text("Image Id: \(model.imageId)")
                .font(.subheadline.bold())
            CustomAsyncImage(url: model.imageUrl, width: +.infinity, height: +.infinity)
            
        }.navigationTitle(model.author)
    }
}

struct CustomAsyncImage: View{
    internal init(url: URL, width: CGFloat = 175, height: CGFloat = 175) {
        self.url = url
        self.width = width
        self.height = height
    }
    
    let url: URL
    let width: CGFloat
    let height: CGFloat
    
    
    
    var body: some View{
        AsyncImage(url: url) { phase in
            switch phase{
            case .empty:
                Color.purple.opacity(0.1)
            case.failure(let error):
                Image("error")
                    .resizable()
                    .scaledToFill()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            @unknown default:
                Image("error")
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(width: width, height: height, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

struct ListRow: View{
    
    let model: PicsumModel
    
    var body: some View{
        CustomAsyncImage(url: model.imageUrl)
    }
}

struct PicsumApi_Previews: PreviewProvider {
    
    static let previewModel = PicsumModel(imageId: "117", author: "Daniel Ebersole", imageUrl: URL(string: "https://picsum.photos/id/117/1544/1024")!, width: 1544, height: 1024)
    
    static var previews: some View {
        Group{
            ListRow(model: previewModel)
            PicsumApi()
            PicsumView(model: previewModel)

        }
    }
}

extension URL{
    func getImage() async -> Image{
        do{
        let (data, _) = try await URLSession.shared.data(from: self)
            return Image(uiImage: UIImage(data: data)!)
        }catch{
            return Image("naruto")
        }
    }
}
