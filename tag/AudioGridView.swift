import SwiftUI

struct AudioGridView: View {
    var audio: Audio

    var body: some View {
        VStack {
            Text(audio.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
        }
    }
}

struct AudioGridView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
