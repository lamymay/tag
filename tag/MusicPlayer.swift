import AVFoundation

class MusicPlayer {

    static let shared = MusicPlayer()

    var player: AVAudioPlayer?

    func playAudio(_ audio: Audio) {
        let url = URL(fileURLWithPath: audio.path)

        guard let player = try? AVAudioPlayer(contentsOf: url) else {
            print("Failed to create AVAudioPlayer")
            return
        }

        self.player = player
        player.prepareToPlay()
        player.play()
    }

    func stopAudio() {
        player?.stop()
        player = nil
    }
}
