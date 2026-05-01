import UIKit
import AVFoundation

class VideoBackgroundView: UIView {

    // MARK: - Private Properties
    private var player: AVQueuePlayer?
    private var playerLayer: AVPlayerLayer?
    private var looper: AVPlayerLooper?

    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setupBackgroundVideo()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Internal Methods
    override func didMoveToWindow() {
        super.didMoveToWindow()
        /// Если окно не активно, то видео не играется
        if window != nil {
            player?.play()
        } else {
            player?.pause()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = self.bounds
    }

    // MARK: - Private Methods
    private func setupBackgroundVideo() {
        guard let videoURL = Bundle.main.url(forResource: "swaplyBackground", withExtension: "mp4") else { return }
        let playerItem = AVPlayerItem(url: videoURL)
        player = AVQueuePlayer()
        guard let player else { return }
        looper = AVPlayerLooper(player: player, templateItem: playerItem)
        player.isMuted = true
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill
        guard let playerLayer else { return }
        layer.insertSublayer(playerLayer, at: 0)
    }
}
