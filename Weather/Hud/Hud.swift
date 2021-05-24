//
//  HudView.swift
//  PersonalOverView
//
//  Created by Jan Hovland on 03/05/2021.
//

import SwiftUI

struct Hud: View {
    var hudMessage: String
    @ViewBuilder var body: some View {
        Label(hudMessage, systemImage: "xmark.octagon.fill") /// <------------------ må ha systemImage som variabel
            .foregroundColor(Color("ForegroundColor"))
            .background(
                Blur(style: .systemMaterial)
                    .clipShape(Capsule())
            )
            .padding(.horizontal, 10)
            .padding(14)
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

