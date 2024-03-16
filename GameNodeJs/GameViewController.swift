//
//  GameViewController.swift
//  GameNodeJs
//
//  Created by Ehab on 09/03/2024.
//

import UIKit

class GameViewController: UIViewController {
    
    var mSocket = SocketHandler.sharedInstance.getSocket()
    
    @IBOutlet weak var selfNameLabel: UILabel!
    @IBOutlet weak var otherNameLabel: UILabel!
    @IBOutlet weak var selfScoreLabel: UILabel!
    @IBOutlet weak var otherScoreLabel: UILabel!
    @IBOutlet weak var ledStatusLabel: UILabel!
    
    var username: String?
    var myScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        selfNameLabel.text = username
        selfScoreLabel.text = "\(myScore)"
        
        SocketHandler.sharedInstance.establishConnection()
        
        mSocket.on("broadcast") { [self] (dataArray, ack) -> Void in
            let dataReceived = dataArray[0] as! String
            
            let decoder = JSONDecoder()
            do {
                let other = try decoder.decode(Score.self, from: dataReceived.data(using: .utf8)!)
                
                if (other.username == username) {
                    selfScoreLabel.text = "\(other.score)"
                } else {
                    otherNameLabel.text = other.username
                    otherScoreLabel.text = "\(other.score)"
                }
                
                selfNameLabel.textColor = .black
                selfScoreLabel.textColor = .black
                otherNameLabel.textColor = .black
                otherScoreLabel.textColor = .black
                
            } catch {
                print("Error decoding object")
            }
        }
        
        mSocket.on("broadcast2") { [self] (dataArray, ack) -> Void in
            let dataReceived = dataArray[0] as! String
            
            let decoder = JSONDecoder()
            do {
                let other = try decoder.decode(Score.self, from: dataReceived.data(using: .utf8)!)
                
                if (other.username == username) {
                    selfScoreLabel.text = "\(other.score)"
                } else {
                    otherNameLabel.text = other.username
                    otherScoreLabel.text = "\(other.score)"
                }
                
                selfNameLabel.textColor = .blue
                selfScoreLabel.textColor = .blue
                otherNameLabel.textColor = .blue
                otherScoreLabel.textColor = .blue
                
            } catch {
                print("Error decoding object")
            }
        }
        
        mSocket.on("led_status") { [self] (dataArray, ack) -> Void in
            let dataReceived = dataArray[0] as! String
            
            let decoder = JSONDecoder()
            do {
                let ledStatus = try decoder.decode(LedStatus.self, from: dataReceived.data(using: .utf8)!)
                
                if (ledStatus.ledOff) {
                    ledStatusLabel.text = "LED Off"
                } else {
                    ledStatusLabel.text = "LED On"
                }
                
            } catch {
                print("Error decoding object")
            }
        }
    }

    @IBAction func didTabScoreButton(_ sender: Any) {
        myScore += 1
        let score = Score(username: username!, score: myScore)
        
//        let json = "{\"score\":\(score.score),\"username\":\"\(score.username)\"}"
//        mSocket.emit("new_message", json)
        
        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
        do {
            // convert score object to json
            let data = try encoder.encode(score)
            let json = String(decoding: data, as: UTF8.self)

            // send score to server
            mSocket.emit("new_message", json)
        } catch {
            print("Error encoding object")
        }
    }
    
    @IBAction func didTabScore2Button(_ sender: Any) {
        myScore += 3
        let score = Score(username: username!, score: myScore)
        
        let encoder = JSONEncoder()
        do {
            // convert score object to json
            let data = try encoder.encode(score)
            let json = String(decoding: data, as: UTF8.self)

            // send score to server
            mSocket.emit("new_message2", json)
        } catch {
            print("Error encoding object")
        }
    }
    
}

