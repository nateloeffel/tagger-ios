//
//  ContentView.swift
//  tagger_ios
//
//  Created by Nate Loeffel on 6/19/24.
//

import SwiftUI
import Speech
import AVKit
import OpenAIKit

//tts
import AVFoundation


struct ContentView: View {
    
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
    //tts
    @State private var speechSynthesizer: AVSpeechSynthesizer?
    
    // keys,door,window,trash_can,light_bulb,phone,marker,charger
    func handleResponse(_ value: String) -> String {
        switch value {
        case "#keys":
            return "🔑"
        case "#door":
            return "🚪"
        case "#window":
            return "🪟"
        case "#trash_can":
            return "🗑️"
        case "#light_bulb":
            return "💡"
        case "#phone":
            return "📱"
        case "#marker":
            return "🖊️"
        case "#charger":
            return "🧑🏿‍🍳"
        // Add more cases as needed
        default:
            return "❓" // Default emoji if no match is found
        }
    }
    
    func speak(_ words: String) {
            
            let audioSession = AVAudioSession() // 2) handle audio session first, before trying to read the text
            do {
                try audioSession.setCategory(.playback, mode: .default, options: .duckOthers)
                try audioSession.setActive(false)
            } catch let error {
                print("❓", error.localizedDescription)
            }
            
            speechSynthesizer = AVSpeechSynthesizer()
            
            let speechUtterance = AVSpeechUtterance(string: words)
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            
            speechSynthesizer?.speak(speechUtterance)
        }
    
        
        var body: some View {
            VStack {
                Text(handleResponse(speechRecognizer.gptResponse))
                    .padding()
                
                Button(action: {
                               if !isRecording {
                                   speechRecognizer.transcribe()
                               } else {
                                   speechRecognizer.stopTranscribing()
                               }
                               
                               isRecording.toggle()
                           }) {
                               Text(isRecording ? "Stop" : "Record")
                                   .font(.largeTitle)
                                   .foregroundColor(.white)
                                   .padding()
                                   .frame(width: 300, height: 100)
                                   .background(isRecording ? Color.red : Color.blue)
                                   .cornerRadius(20)
                           }
                           
                           Button(action: {
                               speak("This is an example of text to speech.")
                           }) {
                               Text("Speak")
                                   .font(.largeTitle)
                                   .foregroundColor(.white)
                                   .padding()
                                   .frame(width: 300, height: 100)
                                   .background(Color.green)
                                   .cornerRadius(20)
                           }
            }
        }
}

#Preview {
    ContentView()
}
