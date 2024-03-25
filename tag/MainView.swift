import SwiftUI
import AppKit
import Foundation

struct MainView: View {

    @State private var selectedFolders: [URL] = []
    @State private var audioFiles: [Audio] = []
    @State private var isScanning: Bool = false
    @State private var isPlaying: Bool = false // 播放状态标志

    @State private var selectedAudio: Audio? = nil

    var body: some View {
        VStack {
            Text("欢迎使用本地音乐播放器")
            Button(action: {
                openFolderSelection()
            }, label: {
                Text("选择目录以扫描本地音乐")
            })

            PlayControlView(selectedAudio: $selectedAudio)

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], alignment: .leading, spacing: 10) {
                    ForEach(audioFiles, id: \.id) { audio in
                        AudioGridView(audio: audio)
                                .onTapGesture {
                                    selectedAudio = audio
                                    MusicPlayer.shared.playAudio(audio)
                                }
                    }
                }
                        .padding()
            }
        }
    }
    private func openFolderSelection() {
        let openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = true
        openPanel.canChooseFiles = false
        openPanel.allowsMultipleSelection = true
        openPanel.begin { response in
            if response == .OK {
                for url in openPanel.urls {
                    print("用户选择的目录：\(url.path.removingPercentEncoding ?? "")")
                    
                    // 开始扫描，显示进度条
                    self.isScanning = true
                    
                    // 扫描、过滤、转换为 Audio 对象列表
                    if let audioFiles = FileTool.scanFilterAndConvertToAudios(url) {
                        // 扫描结束，隐藏进度条，并更新音乐文件列表
                        self.isScanning = false
                        self.audioFiles = audioFiles
                    } else {
                        print("无法扫描、过滤或转换音乐文件")
                    }
                }
            }
        }
    }
}
