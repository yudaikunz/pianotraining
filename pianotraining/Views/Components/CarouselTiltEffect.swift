import SwiftUI

extension View {
    /// 縦スクロールのリストで、画面中央から離れたカードを少しずつ傾けて
    /// 「カードがくるくる回りながら流れていく」ようなカルーセル風の見た目にする。
    func carouselTiltEffect() -> some View {
        scrollTransition(.interactive, axis: .vertical) { content, phase in
            content
                .rotation3DEffect(
                    .degrees(phase.value * 20),
                    axis: (x: 1, y: 0, z: 0),
                    anchor: .center,
                    perspective: 0.4
                )
                .scaleEffect(1 - abs(phase.value) * 0.08)
                .opacity(1 - abs(phase.value) * 0.35)
        }
    }
}
