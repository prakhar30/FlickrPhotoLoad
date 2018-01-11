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
    var numberOfRows = 10
    var expandedCells = [Int]()
    var dataArray = [[String]]()
    var imgList = [ImageList]()
    var images = [UIImage]()
    var lastButtonPressed:UIButton = UIButton()
    let flickrURL = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=3aabe25e48b4768af1a7e303672fed00&per_page=10&page=1&format=json&nojsoncallback=1"
    var buttonTapped = 0 // 1 for left, 2 for right
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dataArray.append(["index 0 \n left", "index 0 \n right"])
        dataArray.append(["index 1 \n left", "index 1 \n right"])
        dataArray.append(["index 2 \n left", "index 2 \n right"])
        dataArray.append(["index 3 \n left", "index 3 \n right"])
        dataArray.append(["index 0 \n left", "index 0 \n right"])
        dataArray.append(["index 1 \n left", "index 1 \n right"])
        dataArray.append(["index 2 \n left", "index 2 \n right"])
        dataArray.append(["index 3 \n left", "index 3 \n right"])
        dataArray.append(["index 2 \n left", "index 2 \n right"])
        dataArray.append(["index 3 \n left", "index 3 \n right"])
        tableView.separatorStyle = .none
        getdata()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.leftImageView.image = UIImage(named: "doctor")
        cell.rightImageView.image = UIImage(named: "doctor")
//        cell.leftImageView.image = images[indexPath.row]
//        cell.rightImageView.image = images[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.leftImageButton.tag = indexPath.row
        cell.rightImageButton.tag = indexPath.row
        cell.leftImageButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        cell.rightImageButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        cell.infoLabel.tag = indexPath.row + 100

        return cell
    }
    
    func returnCellForIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        return self.tableView.cellForRow(at: indexPath)! as UITableViewCell
    }
    
    func returnInfoLabel(r: Int) -> UILabel {
        return self.returnCellForIndexPath(IndexPath(row: r, section: 0)).viewWithTag(r + 100) as! UILabel
    }
    
    func leftButtonAction(sender: UIButton!) {
        print("Left Button tapped \(sender.tag)")
        buttonTapped = 1
        if expandedCells.contains(sender.tag) {
            if (!expandedCells.isEmpty && expandedCells[0] == sender.tag){
                returnInfoLabel(r: sender.tag).text = dataArray[sender.tag][0]
            }
            if (!expandedCells.isEmpty && expandedCells[0] == sender.tag && buttonTapped == 1){
                returnInfoLabel(r: sender.tag).text = dataArray[sender.tag][1]
            }
        }
        else {
            expandedCells.removeAll()
            expandedCells.append(sender.tag)
        }
        lastButtonPressed.layer.borderColor = UIColor.clear.cgColor
        let but = sender.viewWithTag(sender.tag) as! UIButton
        but.layer.borderWidth = 2.0
        but.layer.borderColor = UIColor.blue.cgColor
        if(lastButtonPressed == but){
            but.layer.borderColor = UIColor.clear.cgColor
            expandedCells.removeAll()
        }
        lastButtonPressed = but
        tableView.reloadData()
        print(expandedCells)
        returnInfoLabel(r: sender.tag).text = dataArray[sender.tag][0]
    }
    
    func rightButtonAction(sender: UIButton!) {
        print("Right Button tapped \(sender.tag)")
        buttonTapped = 2
        if expandedCells.contains(sender.tag) {
            if (!expandedCells.isEmpty && expandedCells[0] == sender.tag){
                returnInfoLabel(r: sender.tag).text = dataArray[sender.tag][1]
            }
            if (!expandedCells.isEmpty && expandedCells[0] == sender.tag && buttonTapped == 2){
                returnInfoLabel(r: sender.tag).text = dataArray[sender.tag][1]

            }
        }
        else {
            expandedCells.removeAll()
            expandedCells.append(sender.tag)
        }
        lastButtonPressed.layer.borderColor = UIColor.clear.cgColor
        let but = sender.viewWithTag(sender.tag) as! UIButton
        but.layer.borderWidth = 2.0
        but.layer.borderColor = UIColor.blue.cgColor
        if(lastButtonPressed == but){
            but.layer.borderColor = UIColor.clear.cgColor
            expandedCells.removeAll()
        }
        lastButtonPressed = but
        tableView.reloadData()
        print(expandedCells)
        returnInfoLabel(r: sender.tag).text = dataArray[sender.tag][1]
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
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                    let photos = json!["photos"] as! NSDictionary
                    let photo = photos["photo"] as! NSArray
                    for i in 0..<photo.count{
                        let img = photo[i] as! [String:Any]
                        let obj:ImageList = ImageList(f: "\(img["farm"]!)", ser: "\(img["server"]!)", i: "\(img["id"]!)", sec: "\(img["secret"]!)")
                        self.imgList.append(obj)
                    }
                }
            })
            task.resume()
        }
    }
    
    func getImage(){
        for i in 0..<imgList.count{
            if let url = URL(string: "https://farm\(imgList[i].farm).staticflickr.com/\(imgList[i].server)/\(imgList[i].id)_\(imgList[i].secret)_m.jpg") {
            }
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

