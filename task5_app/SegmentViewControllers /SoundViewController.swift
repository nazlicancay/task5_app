//
//  soundViewController.swift
//  task5_app
//
//  Created by Nazlıcan Çay on 4.09.2023.
//

import UIKit
import AVFoundation
class SoundViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: SongSelectionDelegate?

    var audioPlayer: AVAudioPlayer?
    var soundFiles = ["DeepFutureGarage", "InsideYou", "TheBestJazzClubinNewOrleans"]
        
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
       
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return soundFiles.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "soundCell", for: indexPath)
            cell.textLabel?.textColor = .white
            cell.textLabel?.text = soundFiles[indexPath.row]
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            playSound(named: soundFiles[indexPath.row])
            delegate?.songDidSelect(name: soundFiles[indexPath.row])
        }
    
    func playSound(named soundName: String) {
        if let path = Bundle.main.path(forResource: soundName, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing sound")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioPlayer?.stop()
    }
    
    
}


    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


