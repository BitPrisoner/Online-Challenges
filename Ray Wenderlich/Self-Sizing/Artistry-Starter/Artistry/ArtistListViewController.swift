/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class ArtistListViewController: UIViewController {
  
  let artists = Artist.artistsFromBundle()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 140
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // alert()
        if let destination = segue.destination as? ArtistDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedArtist = artists[indexPath.row]
        }
    }
    
    func alert() {
        print("Hello World")
        let alert = UIAlertController(title: "Token", message: "Enter code", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Enter", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ArtistListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return artists.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // dequeue a cell
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArtistTableViewCell
    
    let artist = artists[indexPath.row]
    
    // Set information
    cell.bioLabel.text = artist.bio
    
    // Set text color
    cell.bioLabel.textColor = UIColor(white: 114/255, alpha: 1)
    
    return cell
  }
}

