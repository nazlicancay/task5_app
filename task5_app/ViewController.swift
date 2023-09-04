//
//  ViewController.swift
//  task5_app
//
//  Created by Nazlıcan Çay on 4.09.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!

    var soundViewController: UIViewController!
    var playlistViewController: UIViewController!
    var songsViewController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        soundViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SoundViewController") as! SoundViewController
        playlistViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlaylistViewController") as! PlaylistViewController
        songsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SongsViewController") as! SongsViewController

        // Set the titles on your segmented control
        segmentedControl.setTitle("Sound", forSegmentAt: 0)
        segmentedControl.setTitle("Playlist", forSegmentAt: 1)
        segmentedControl.setTitle("Songs", forSegmentAt: 2)

        // Initially add one of them as a child view controller
        addChild(soundViewController)
        soundViewController.view.frame = containerView.bounds
        containerView.addSubview(soundViewController.view)
        soundViewController.didMove(toParent: self)
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        // Remove the current child view
        for view in containerView.subviews {
            view.removeFromSuperview()
        }
        for child in children {
            child.removeFromParent()
        }

        // Add the new child view based on the segmented control's selected index
        var newChildViewController: UIViewController!
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            newChildViewController = soundViewController
        case 1:
            newChildViewController = playlistViewController
        case 2:
            newChildViewController = songsViewController
        default:
            break
        }

        addChild(newChildViewController)
        newChildViewController.view.frame = containerView.bounds
        containerView.addSubview(newChildViewController.view)
        newChildViewController.didMove(toParent: self)
    }
}


