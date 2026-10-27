import SwiftUI
import AVFoundation

final class SoundPlayer: ObservableObject {
    private var player: AVAudioPlayer?

    init() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playback, mode: .default, options: [])
        try? session.setActive(true)

        if let url = Bundle.main.url(forResource: "melody", withExtension: "m4a") {
            player = try? AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
        }
    }

    func play() {
        guard let player = player else { return }
        player.currentTime = 0
        player.play()
    }
}

struct ContentView: View {
    @StateObject private var sound = SoundPlayer()
    @State private var pressed = false

    private let cornerRadius: CGFloat = 28

    var body: some View {
        GeometryReader { geo in
            let buttonWidth = geo.size.width * 0.56
            let buttonHeight = buttonWidth * 1.2

            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()

                Color.black.opacity(0.45)

                VStack(spacing: 0) {
                    Text("cow naxuy")
                        .font(.system(size: 46, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.65), radius: 6, x: 0, y: 4)
                        .lineLimit(1)
                        .minimumScaleFactor(0.4)
                        .padding(.horizontal, 20)
                        .padding(.top, 70)

                    Spacer(minLength: 0)

                    cowButton(width: buttonWidth, height: buttonHeight)
                        .onTapGesture { tap() }

                    Spacer(minLength: 0)
                }
            }
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
        .statusBar(hidden: true)
    }

    private func cowButton(width: CGFloat, height: CGFloat) -> some View {
        Image("CowButton")
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(Color.white.opacity(0.95), lineWidth: 4)
            )
            .shadow(
                color: .black.opacity(pressed ? 0.30 : 0.55),
                radius: pressed ? 8 : 22,
                x: 0,
                y: pressed ? 3 : 14
            )
            .brightness(pressed ? -0.08 : 0)
            .scaleEffect(pressed ? 0.94 : 1.0)
            .animation(.easeInOut(duration: 0.12), value: pressed)
            .contentShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }

    private func tap() {
        guard !pressed else { return }
        pressed = true

        // звук стартует, когда кнопка уже "вдавлена"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
            sound.play()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.26) {
            pressed = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
