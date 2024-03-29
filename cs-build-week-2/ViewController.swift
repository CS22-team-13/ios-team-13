//
//  ViewController.swift
//  cs-build-week-2
//
//  Created by Hector on 11/18/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var roomLabel: UILabel!
    @IBOutlet var StatusLabel: UILabel!
    
    @IBOutlet var roomTextView: UITextView!
    
    @IBOutlet var coolDownLabel: UILabel!
    @IBOutlet var statusTextView: UITextView!
    let networkController = NetworkController()
    
    var timer: Timer? = nil
    
    var status: Status? {
        didSet { setupStatus() }
    }
    
    var room: Room? {
        didSet { setupRoom() }
    }
    
    var roomExits: [String]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkController.currentStats { room, error in
            if let error = error {
                print(error)
            }
            
            guard let room = room else { return }
            
            DispatchQueue.main.async {
                self.room = room
            }
        }
        
        
        startCoolDown(5)
    }
    
    
    func setupStatus() {
        guard let status = status else { return }
        StatusLabel.text = status.name
        var items = ""
        let _ = status.inventory.map {
            items += $0
            items += ", "
        }
        statusTextView.text = "Cooldown: \(status.cooldown) \nEncumbrance: \(status.encumbrance) \nGold: \(status.gold) \nSpeed: \(status.speed) \nStrenght: \(status.strength) \nItems: \(items)"
            
        
    }
    
    func compactlist(_ arr: [String]) -> String {
        var str = ""
        let _ = arr.map {
            str += $0
            str += ", "
        }
        return str
    }
    
    func setupRoom() {
        guard let room = room else { return }
        roomExits = room.exits
        
        roomLabel.text = "\(room.room_id): \(room.title)"
        
        let errors = compactlist(room.errors)
        let exits = compactlist(room.exits)
        let items = compactlist(room.items)
        let messages = compactlist(room.items)
        
        roomTextView.text = "Exits: \(exits)\n\nItems: \(items)\n\nDescription: \(room.description)\n\n\nCoordinates: \(room.coordinates)\n\nElevation: \(room.elevation)\n\nErrors: \(errors)\n\nMessages: \(messages)"
    }
    
    

    @IBAction func nsweButtonPressed(_ sender: UIButton) {
        if timer != nil {
            return
        }
        
        let tag = sender.tag
        var direction = ""
        switch tag {
        case 0:
            direction = "n"
        case 1:
            direction = "s"
        case 2:
            direction = "w"
        case 3:
            direction = "e"
        default:
            direction = "none"
        }
        
        networkController.move(direction) { room, error in
            if let error = error {
                print(error)
            }
            
            guard let room = room else { return }
            
            DispatchQueue.main.async {
                self.room = room
                self.startCoolDown(room.cooldown)
            }
        }
    }
    
    func startCoolDown(_ coolDown: Double) {
        var count = 0
        coolDownLabel.text = "CoolDown: \(coolDown)"
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            if count == Int(coolDown) {
                self.coolDownLabel.text = "CoolDown: 0"
                timer.invalidate()

            }else {
                self.coolDownLabel.text = "CoolDown: \(Int(coolDown) - count)"
                count += 1
                
            }
        }
        
    }
    
    
    @IBAction func statusButtonPressed(_ sender: Any) {
        networkController.getStatus { status, error in
            if let error = error {
                print(error)
            }

            guard let status = status else { return }
            DispatchQueue.main.async {
                self.status = status
            }
        }
    }
}

