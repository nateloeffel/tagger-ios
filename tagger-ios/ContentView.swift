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
        return "🔌"
    case "#bicycle":
        return "🚲"
    case "#car":
        return "🚗"
    case "#motorbike":
        return "🏍️"
    case "#aeroplane":
        return "✈️"
    case "#bus":
        return "🚌"
    case "#train":
        return "🚆"
    case "#truck":
        return "🚚"
    case "#boat":
        return "🛥️"
    case "#traffic_light":
        return "🚦"
    case "#fire_hydrant":
        return "🚒"
    case "#stop_sign":
        return "🛑"
    case "#parking_meter":
        return "🅿️"
    case "#bench":
        return "🪑"
    case "#backpack":
        return "🎒"
    case "#umbrella":
        return "☂️"
    case "#handbag":
        return "👜"
    case "#tie":
        return "👔"
    case "#suitcase":
        return "🧳"
    case "#frisbee":
        return "🥏"
    case "#skis":
        return "⛷️"
    case "#snowboard":
        return "🏂"
    case "#sports_ball":
        return "⚽"
    case "#kite":
        return "🪁"
    case "#baseball_bat":
        return "🏏"
    case "#baseball_glove":
        return "🥎"
    case "#skateboard":
        return "🛹"
    case "#surfboard":
        return "🏄"
    case "#tennis_racket":
        return "🎾"
    case "#bottle":
        return "🍾"
    case "#wine_glass":
        return "🍷"
    case "#cup":
        return "🍵"
    case "#fork":
        return "🍴"
    case "#knife":
        return "🔪"
    case "#spoon":
        return "🥄"
    case "#bowl":
        return "🥣"
    case "#banana":
        return "🍌"
    case "#apple":
        return "🍎"
    case "#sandwich":
        return "🥪"
    case "#orange":
        return "🍊"
    case "#broccoli":
        return "🥦"
    case "#carrot":
        return "🥕"
    case "#hot_dog":
        return "🌭"
    case "#pizza":
        return "🍕"
    case "#donut":
        return "🍩"
    case "#cake":
        return "🍰"
    case "#chair":
        return "🪑"
    case "#sofa":
        return "🛋️"
    case "#potted_plant":
        return "🪴"
    case "#bed":
        return "🛏️"
    case "#dining_table":
        return "🍽️"
    case "#toilet":
        return "🚽"
    case "#tv_monitor":
        return "📺"
    case "#laptop":
        return "💻"
    case "#mouse":
        return "🖱️"
    case "#remote":
        return "📺"
    case "#keyboard":
        return "⌨️"
    case "#cell_phone":
        return "📱"
    case "#microwave":
        return "🍲"
    case "#oven":
        return "🍳"
    case "#toaster":
        return "🍞"
    case "#sink":
        return "🚰"
    case "#refrigerator":
        return "🧊"
    case "#book":
        return "📚"
    case "#clock":
        return "🕰️"
    case "#vase":
        return "🏺"
    case "#scissors":
        return "✂️"
    case "#teddy_bear":
        return "🧸"
    case "#hair_drier":
        return "💇"
    case "#toothbrush":
        return "🪥"
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
//        speechUtterance.prefersAssistiveTechnologySettings = true 
        for voice in AVSpeechSynthesisVoice.speechVoices()
        {
            if voice.language == "en-US" {
                
                if voice.name == "Evan (Enhanced)" {
                    print("FOUND VOICE")
                    speechUtterance.voice = voice
                }
            }
            
            
        }
        
        
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
