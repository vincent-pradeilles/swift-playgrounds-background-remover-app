import SwiftUI

struct ImageRow: View {
    
    let model: ImageRowModel
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack {
                Image(uiImage: model.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                
                Text("Before")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            VStack {
                resultView(for: model)
                
                Text("After")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 100.0)
    }
    
    @ViewBuilder func resultView(for model: ImageRowModel) -> some View {
        switch model.result {
        case let .progress(progress):
            ProgressView(value: progress)
                .padding(.horizontal)
                .frame(width: 150)
                .frame(maxHeight: .infinity)
        case let .result(resultImage):
            NavigationLink {
                ImageDetailView(model: ImageDetailModel(orginal: model.original, result: resultImage))
            } label: {
                Image(uiImage: resultImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
            }
        case .error:
            Image(systemName: "xmark.octagon.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .foregroundColor(.red)
        }
    }
}
