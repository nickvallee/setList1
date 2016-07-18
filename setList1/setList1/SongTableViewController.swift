//
//  SongTableViewController.swift
//  setList1
//
//  Created by Nicolaas Vallee on 2016-06-12.
//  Copyright © 2016 Nicolaas Vallee. All rights reserved.
//

import UIKit

class SongTableViewController: UITableViewController {
    
    // MARK: Properties

    
    var songs = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved meals, otherwise load sample data.
        if let savedSongs = loadSongs() {
            songs += savedSongs
        } else {
            // Load the sample data.
            
                    loadSampleSongs()
            
            }
        
        
 

    }

    func loadSampleSongs() {
        let song1 = Song(name: "Wreck it", note: "butt", rating: 2)!
        
        let song2 = Song(name: "Awake", note: "child's beard", rating: 1)!

        let song3 = Song(name: "Duisburg", note: "sadness", rating: 4)!
        
        songs += [song1, song2, song3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return songs.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "SongTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SongTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let song = songs[indexPath.row]
            
        //song.name
        cell.nameLabel.text = song.name
        cell.noteLabel.text = song.note
        cell.songOrder.text = "\(indexPath.row + 1)"
        cell.ratingControl.rating = song.rating
        
        return cell
    }
    

    @IBAction func unwindToSongList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? SongViewController, song = sourceViewController.song {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing song.
                songs[selectedIndexPath.row] = song
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {

            
                // Add a new song.
                let newIndexPath = NSIndexPath(forRow: songs.count, inSection: 0)
            
                songs.append(song)
                
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            
            // Save the songs.
            saveSongs()
         
        }


    }
    

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            songs.removeAtIndex(indexPath.row)
            //saveSongs()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let songDetailViewController = segue.destinationViewController as! SongViewController
            
            // Get the cell that generated this segue.
            if let selectedSongCell = sender as? SongTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedSongCell)!
                let selectedSong = songs[indexPath.row]
                songDetailViewController.song = selectedSong
            }
            

        }
        else if segue.identifier == "AddItem" {
            print("Adding new song.")
        }
    }
    
// MARK: NSCoding
    
    func saveSongs() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(songs, toFile: Song.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save songs...")
        }
    }
    
    func loadSongs() -> [Song]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Song.ArchiveURL.path!) as? [Song]
    }

}
