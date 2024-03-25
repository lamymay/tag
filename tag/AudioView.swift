import SwiftUI

struct AudioView: View {

    var audio: Audio

    var body: some View {
        VStack {
            Text("\(audio.filename)")
                .font(.title)
                    .padding(.bottom)
            Text("\(audio.artist)")
                    .padding(.bottom)
            Text("\(audio.album)")
                    .padding(.bottom)
            // 添加更多的音乐信息显示，根据需要自定义
            Spacer()
        }
    }
}

struct AudioView_Previews: PreviewProvider {
    static var previews: some View {
        // 创建一个示例音频对象
        EmptyView()
    }
}
