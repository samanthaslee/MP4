//
//  FavoritesViewController.swift
//  LufthansaMP4Skeleton
//
//  Created by Sam Lee on 3/4/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var favTableView : UITableView!
    
    var favoritedFlights : [String] = []
    
    var idToPass: String!
    var dateToPass: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpmyTableView()

        view.backgroundColor = .blue
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath)
            as! FavCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        cell.favLabel.text = Constants.favorites[indexPath.row].fullID
        cell.favDateLabel.text = Constants.favorites[indexPath.row].departureDate
        cell.favLabel.textColor = .black
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = favTableView.indexPathForSelectedRow;

        let currentCell = favTableView.cellForRow(at: indexPath!) as! FavCell

        idToPass = currentCell.favLabel.text
        dateToPass = currentCell.favDateLabel.text
        print("pressed yo")
        performSegue(withIdentifier: "toFavDetail", sender: self)
    }

    
    func setUpmyTableView() {
        view.backgroundColor = .white
        favTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        favTableView.backgroundColor = .white
        favTableView.dataSource = self
        favTableView.delegate = self
        favTableView.layoutMargins = UIEdgeInsets.zero
        favTableView.separatorInset = UIEdgeInsets.zero
        favTableView.register(FavCell.self, forCellReuseIdentifier: "FavCell")
        
        view.addSubview(favTableView)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FlightInformationViewController {
            vc.flightNumber = idToPass
            vc.flightDate = dateToPass
            
        }
    }
    

    
    

    /*
    // MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }
    */

}
