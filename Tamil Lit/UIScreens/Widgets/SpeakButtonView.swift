//
//  SpeakButtonView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 06/08/24.
//

import SwiftUI

struct SpeakButtonView: View {
    @StateObject private var speechSynthesizer = SpeechSynthesizer()
    
    @Binding var textContent: String
    @State var showAlert: Bool = false
    
    var body: some View {
        Button {
            if speechSynthesizer.isSpeaking {
                speechSynthesizer.stopSpeaking()
            } else {
                // if we dont find Tamil voice then instruct the user to enable the setting..
                speechSynthesizer.speak(text: textContent) { success in
                    if !success {
                        showAlert = true
                    }
                }
            }
        } label: {
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: "speaker.wave.2.fill")
                    .font(.caption)
                Text(speechSynthesizer.isSpeaking ? "நிறுத்து" : "வாசி")
            }
            .font(.subheadline)
            .foregroundStyle(Color("TextColor"))
        }
        .padding(.trailing, size10)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Tamil Voice Not Available"),
                message: Text("To enable Tamil text-to-speech, go to Settings > Accessibility > Spoken Content > Voices > Tamil and download the Tamil voice."),
                primaryButton: .default(Text("Open Settings"), action: {
                    openMainSettings()
                    
//                    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
//                        if UIApplication.shared.canOpenURL(settingsUrl) {
//                            UIApplication.shared.open(settingsUrl, completionHandler: { success in
//                                print("Settings opened: \(success)")
//                            })
//                        }
//                    }
                }),
                secondaryButton: .default(Text("OK"))
            )
        }
        .onDisappear {
            speechSynthesizer.stopSpeaking()
        }
    }
    
    func openMainSettings() {
        guard let url = URL(string: "App-Prefs:root=General") else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
