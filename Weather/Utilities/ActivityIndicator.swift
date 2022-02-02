//
//  ActivityIndicator.swift
//  Weather
//
//  Created by Jan Hovland on 14/12/2021.
//

 
import SwiftUI

/// https://medium.com/swiftui-made-easy/activity-view-controller-in-swiftui-593fddadee79
/// https://www.hackingwithswift.com/articles/118/uiactivityviewcontroller-by-example

///
/// https://developer.apple.com/forums/thread/699332
///
/// SourcePackages/checkouts/SwiftUI-MediaPicker/SwiftUI.UIViewControllerRepresentable:7:24: Static method '_makeView(view:inputs:)' isolated to global actor 'MainActor' can not satisfy corresponding requirement from protocol 'View'
///
/// ** A big problem with Xcode13.3 and swiftui
///
/// After I updated xcode to 13.3 version, almost all mt spm project warns.
/// Ser ut til å være en feil med Version 13.3 beta (13E5086k)
///

struct ActivityIndicator: UIViewRepresentable {
    
    /// Plasser ActivityIndicator(isAnimating: $indicatorShowing, style: .medium, color: .gray)
    /// hvor det ikke kommer warning : Result of 'ActivityIndicator' initializer is unused
    /// Sett verdien av indicatorShowing til true for å starte ActivityIndicator
    /// Sett verdien av indicatorShowing til false for å avslutte ActivityIndicator

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    let color: UIColor

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView(style: style)
        indicatorView.color = color
        return indicatorView
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems,
                                 applicationActivities: applicationActivities)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ActivityView>) {}
}

