//
//  playlistViewController.swift
//  task5_app
//
//  Created by Nazlıcan Çay on 4.09.2023.
//

import UIKit
import MediaPlayer

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var playlists: [MPMediaItemCollection] = []
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        let query = MPMediaQuery.playlists()
        if let playlistCollections = query.collections {
            self.playlists = playlistCollections
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath)
        let playlist = playlists[indexPath.row]

        cell.textLabel?.textColor = .white
        cell.textLabel?.text = playlist.value(forProperty: MPMediaPlaylistPropertyName) as? String
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlaylist = playlists[indexPath.row]
        // Do something with the selected playlist
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


