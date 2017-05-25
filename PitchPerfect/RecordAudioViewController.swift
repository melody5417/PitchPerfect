//
//  RecordAudioViewController.swift
//  PitchPerfect
//
//  Created by melody5417 on 25/05/2017.
//  Copyright © 2017 melody5417. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingIndicatorLabel: UILabel!
    @IBOutlet weak var recordAudioButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // Define text to show the users what to do:
    let recordStartText = "Tap to record"
    let recordRecodingText = "Recording..."
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    var isRecording = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        print("record view did load")
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("record view will appear")
        
        super.viewWillAppear(true)
        
        // Configue UI Elements
        recordingIndicatorLabel.text = recordStartText
        stopButton.isEnabled = false
    }
    
    // MARK: - Actions
    
    @IBAction func recordAudio(_ sender: UIButton) {
        recordingIndicatorLabel.text = recordRecodingText
        
        stopButton.isEnabled = true
        recordAudioButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: UIButton) {
        recordingIndicatorLabel.text = recordStartText
        
        recordAudioButton.isEnabled = true
        stopButton.isEnabled = false
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    // MARK: - AVAudioRecorderDelegate
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("recording was not successful")
        }
    }

}
