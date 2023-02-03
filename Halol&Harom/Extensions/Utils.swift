//
//  Utils.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 27/01/23.
//

import UIKit
import AVFoundation
import AudioToolbox

public class Utils {
    static var audioPlayer = AVAudioPlayer()
    static func delay(seconds: Double, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
    
   static func lightVibrate() {
       AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    static func open(url: String) {
        if let newUrl = URL(string: url.trimmed) {
            if UIApplication.shared.canOpenURL(newUrl) {
                UIApplication.shared.open(newUrl, completionHandler: nil)
            }
        }
    }
    
    static func callNumber(phoneNumber:String) {
      if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
    
    static func updateVersion(urlString: String){
        if let updateVerURL = URL(string: urlString.trimmed) {
            if UIApplication.shared.canOpenURL(updateVerURL) {
                UIApplication.shared.open(updateVerURL, completionHandler: nil)
            }
        }
    }
    
   static func playCarOpenSound() {
        let path = Bundle.main.path(forResource: "carSound.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error {
            print("Sound Play Error -> \(error)")
        }
        
    }
    
    static func toggleFlash() {
        if let device = AVCaptureDevice.default(for: AVMediaType.video) {
            if device.hasTorch {
                do {
                    try device.lockForConfiguration()
                    if device.torchMode == AVCaptureDevice.TorchMode.on {
                        device.torchMode = AVCaptureDevice.TorchMode.off
                    } else {
                        do {
                            try device.setTorchModeOn(level: 1.0)
                        } catch {
                            // do nothing
                        }
                    }
                    device.unlockForConfiguration()
                } catch {
                    // do nothing
                }
            }
        }
    }
    
}
