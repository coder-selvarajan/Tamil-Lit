//
//  TextToSpeech.swift
//  Tamil Lit
//
//  Created by Selvarajan on 06/08/24.
//

import Foundation
import SwiftUI
import AVFoundation

class SpeechSynthesizer: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    @AppStorage("speechRate") var speechRate: Double = Double(AVSpeechUtteranceDefaultSpeechRate)
    
    private var synthesizer = AVSpeechSynthesizer()
    @Published var isSpeaking = false
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    func speak(text: String, language: String = "ta-IN", completion: @escaping (Bool) -> Void) {
        // Data cleaning
        let cleanText = text.replacingOccurrences(of: "#", with: "")
        
        print(text)
        
        if isVoiceAvailable(language: language) {
            let utterance = AVSpeechUtterance(string: cleanText)
            utterance.voice = AVSpeechSynthesisVoice(language: language)
//            utterance.rate = AVSpeechUtteranceDefaultSpeechRate
            
//            utterance.rate = Float(UserDefaults.standard.double(forKey: "speechRate"))
            utterance.rate = Float(speechRate)
            
            synthesizer.speak(utterance)
            isSpeaking = true
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func stopSpeaking() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
            isSpeaking = false
        }
    }
    
    private func isVoiceAvailable(language: String) -> Bool {
//        return false // For testing the 'voice not installed' alert
        return AVSpeechSynthesisVoice(language: language) != nil
    }
    
    // AVSpeechSynthesizerDelegate method
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
    }
}
