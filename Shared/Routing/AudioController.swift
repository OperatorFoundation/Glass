//
//  AudioController.swift
//  Glass
//
//  Created by Dr. Brandon Wiley on 8/22/21.
//

import Foundation
import AVFoundation

public class AudioController
{
    public static let instance = AudioController()

    let queue = DispatchQueue(label: "Glass.AudioController")

    let engine = AVAudioEngine()
    let mixer = AVAudioMixerNode()

    public init()
    {
    }

    public func startRouting() -> Bool
    {
        self.engine.attach(self.mixer)
        self.engine.prepare()

        let inputNode = self.engine.inputNode
        let inputFormat = inputNode.outputFormat(forBus: 0)
        self.engine.connect(inputNode, to: self.mixer, format: inputFormat)

        let mainMixerNode = self.engine.mainMixerNode
        let mixerFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: inputFormat.sampleRate, channels: 1, interleaved: false)
        self.engine.connect(self.mixer, to: mainMixerNode, format: mixerFormat)

        let tapNode: AVAudioNode = self.mixer
        let format = tapNode.outputFormat(forBus: 0)

        tapNode.installTap(onBus: 0, bufferSize: 4096, format: format)
        {
            (buffer: AVAudioPCMBuffer, time) in

            print("Tap!")
        }

        do
        {
            try self.engine.start()
        }
        catch
        {
            return false
        }

        self.queue.async
        {
            self.pumpMicrophoneToNetwork()
        }

        self.queue.async
        {
            self.pumpNetworkToSpeakers()
        }

        return true
    }

    static public func stopRouting()
    {
        instance.engine.stop()
    }

    private func setupAudioSession()
    {
        do
        {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord, options: [.defaultToSpeaker, .allowBluetooth])
            try session.setActive(true)
        }
        catch
        {
            fatalError("Failed to configure and activate session.")
        }
    }

    public func pumpMicrophoneToNetwork()
    {

    }

    public func pumpNetworkToSpeakers()
    {

    }
}
