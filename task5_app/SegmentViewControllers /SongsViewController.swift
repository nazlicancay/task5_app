//
//  songsViewController.swift
//  task5_app
//
//  Created by Nazlıcan Çay on 4.09.2023.
//

import UIKit
import MediaPlayer
import AVFoundation


class SongsViewController: UIViewController, MPMediaPickerControllerDelegate {

    weak var delegate: SongSelectionDelegate?


    var selectedSongs: [MPMediaItem] = []
    @IBOutlet weak var tableView: UITableView!
    var musicPlayer: MPMusicPlayerController!

    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        musicPlayer = MPMusicPlayerController.systemMusicPlayer
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addSongButtonTapped(_ sender: Any) {
        let picker = MPMediaPickerController(mediaTypes: .music)
        picker.delegate = self
        picker.prompt = "Choose a song"
        picker.allowsPickingMultipleItems = false  // set to true if you want to pick multiple songs
        present(picker, animated: true, completion: nil)
    }

    // MPMediaPickerControllerDelegate methods

    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        let items = mediaItemCollection.items
        for item in items {
            selectedSongs.append(item)
        }
        if let firstItem = mediaItemCollection.items.first,
               let title = firstItem.title {
                delegate?.songDidSelect(name: title)
             
            }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }



    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            // Stop the music when the view disappears
            musicPlayer.stop()
        }
        
    


}

extension SongsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedSongs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        let song = selectedSongs[indexPath.row]

        cell.textLabel?.textColor = .white
        cell.textLabel?.text = song.title ?? "Unknown"
        cell.detailTextLabel?.text = song.artist ?? "Unknown Artist"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get the selected song
        let selectedSong = selectedSongs[indexPath.row]
        
        // Create a collection from the selected song and set it as the queue
        let songCollection = MPMediaItemCollection(items: [selectedSong])
        musicPlayer.setQueue(with: songCollection)
        
        // Play the song
        musicPlayer.play()
    }

}


