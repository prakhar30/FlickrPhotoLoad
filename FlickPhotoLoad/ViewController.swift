//
//  ViewController.swift
//  FlickPhotoLoad
//
//  Created by Prakhar Tripathi on 10/01/18.
//  Copyright © 2018 Prakhar Tripathi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var numberOfRows = 4
    var expandedCells = [Int]()
    let flickrURL = "https://api.flickr.com/services/rest/?method=flickr.test.echo&name=value"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.leftImageView.image = UIImage(named: "doctor")
        cell.rightImageView.image = UIImage(named: "doctor")
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.leftImageButton.tag = indexPath.row
        cell.rightImageButton.tag = indexPath.row
        cell.leftImageButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        cell.rightImageButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)

        return cell
    }
    
    func leftButtonAction(sender: UIButton!) {
        print("Left Button tapped \(sender.tag)")
        if expandedCells.contains(sender.tag) {
            expandedCells = expandedCells.filter({ $0 != sender.tag})
        }
        else {
            expandedCells.removeAll()
            expandedCells.append(sender.tag)
        }
        tableView.reloadData()
        print(expandedCells)
    }
    
    func rightButtonAction(sender: UIButton!) {
        print("Right Button tapped \(sender.tag)")
        if expandedCells.contains(sender.tag) {
            expandedCells = expandedCells.filter({ $0 != sender.tag})
        }
        else {
            expandedCells.removeAll()
            expandedCells.append(sender.tag)
        }
        tableView.reloadData()
        print(expandedCells)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if expandedCells.contains(indexPath.row) {
            return 290
        } else {
            return 170
        }
    }
    
    func getdata(){
        let url = URL(string: flickrURL)
        if let usableUrl = url {
            let request = URLRequest(url: usableUrl)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {              // check for fundamental networking error
                        self.alertBox(msg: "Network Error.")
                        return
                    }
                }
            })
            task.resume()
        }
    }
    
    func alertBox(msg: String) {
        let refreshAlert = UIAlertController(title: "Error", message: "\(msg)", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction!) in
            refreshAlert .dismiss(animated: true, completion: nil)
        }))
        present(refreshAlert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

