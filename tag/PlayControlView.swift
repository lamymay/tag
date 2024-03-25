import SwiftUI

struct PlayControlView: View {
    @Binding var selectedAudio: Audio?
    @State private var isPlaying: Bool = false

    var body: some View {
        HStack {
            Button(action: {
                // 上一曲操作
                // 这里可以调用播放器的上一曲方法
            }) {
                Image(systemName: "backward.fill")
            }
                    .disabled(true) // 在第一首音乐时禁用

            Button(action: {
                // 播放/暂停操作
                isPlaying.toggle()
                if isPlaying {
                    // 播放音乐
                    if let selectedAudio = selectedAudio {
                        MusicPlayer.shared.playAudio(selectedAudio)
                    }
                } else {
                    // 暂停音乐
                    MusicPlayer.shared.stopAudio()
                }
            }) {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
            }
                    .disabled(selectedAudio == nil) // 如果没有选择音乐，禁用播放/暂停按钮

            Button(action: {
                // 下一曲操作
                // 这里可以调用播放器的下一曲方法
            }) {
                Image(systemName: "forward.fill")
            }
                    .disabled(true) // 在最后一首音乐时禁用

            // 进度条
            Slider(value: .constant(0.5)) // 这里需要绑定到播放器的进度
        }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding()
    }
}

