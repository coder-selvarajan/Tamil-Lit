//
//  TextToSpeech.swift
//  Tamil Lit
//
//  Created by Selvarajan on 06/08/24.
//

import Foundation
import SwiftUI
import AVFoundation

class SpeechSynthesizer: ObservableObject {
    private var synthesizer = AVSpeechSynthesizer()
    
    func speak(text: String, language: String = "ta-IN", completion: @escaping (Bool) -> Void) {
        // Data cleaning
        let cleanText = text.replacingOccurrences(of: "#", with: "")
        
        if isVoiceAvailable(language: language) {
            let utterance = AVSpeechUtterance(string: cleanText)
            utterance.voice = AVSpeechSynthesisVoice(language: language)
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate
            synthesizer.speak(utterance)
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func stopSpeaking() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
    }
    
    private func isVoiceAvailable(language: String) -> Bool {
        return AVSpeechSynthesisVoice(language: language) != nil
    }
    
//    func speak(text: String, language: String = "ta-IN") {
//        // Data cleaning
//        let cleanText = text.replacingOccurrences(of: "#", with: "")
//        
//        let utterance = AVSpeechUtterance(string: cleanText)
//        if let voice = AVSpeechSynthesisVoice(language: language) {
//            utterance.voice = voice
//        } else {
//            print("Voice for \(language) not found")
//        }
//        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
//        synthesizer.speak(utterance)
//    }
    
//    func stopSpeaking() {
//        if synthesizer.isSpeaking {
//            synthesizer.stopSpeaking(at: .immediate)
//        }
//    }
}
