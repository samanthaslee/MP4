//
//  FlightStatusViewController.swift
//  LufthansaMP4Skeleton
//
//  Created by Sam Lee on 3/4/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class FlightStatusViewController: UIViewController {
    
    var inputFlightNumberTextField : UITextField!
    @IBOutlet var inputFlightDateTextField : UITextField!
    
    let datePicker = UIDatePicker()
    
    var findFlightButton : UIButton!
    
    var initialLabel: UILabel!
    
    var flightNumberToPass: String!
    var flightDateToPass: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        view.backgroundColor = .white
        
        setUpFlightStatusVC()
        createDatePicker()

       
        // Do any additional setup after loading the view.
    }
    
    private func setUpFlightStatusVC() {
        initialLabel = UILabel(frame: CGRect(x: 80, y: 400, width: 260, height: 30 ))
        initialLabel.text = "Looking for a flight?"
        initialLabel.textAlignment = .center
        view.addSubview(initialLabel)
        
        inputFlightNumberTextField = UITextField(frame: CGRect(x: 80, y: view.frame.height / 2, width: 260, height: 30 ))
        inputFlightNumberTextField.placeholder = "Input flight number"
        inputFlightNumberTextField.text = nil
        inputFlightNumberTextField.borderStyle = .roundedRect
        view.addSubview(inputFlightNumberTextField)
        
        inputFlightDateTextField = UITextField(frame: CGRect(x: 80, y: view.frame.height / 2 + 40, width: 260, height: 30 ))
        inputFlightDateTextField.placeholder = "Input flight date"
        inputFlightDateTextField.borderStyle = .roundedRect
        view.addSubview(inputFlightDateTextField)
        
        findFlightButton = UIButton(frame: CGRect(x: 80, y: view.frame.height / 2 + 80, width: 260, height: 40))
        findFlightButton.setTitle("Find Flight!", for: .normal)
        findFlightButton.backgroundColor = UIColor(red:0.24, green:0.28, blue:0.45, alpha:1.0)
        findFlightButton.layer.cornerRadius = 5
        findFlightButton.addTarget(self, action: #selector(findFlightClicked), for: .touchUpInside)
        view.addSubview(findFlightButton)
    }
    func createDatePicker() {
        inputFlightDateTextField.inputView = datePicker
        //format the date the display of our datepicker
        datePicker.datePickerMode = .date
        //create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //add a button to this tool bar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([doneButton], animated: true)
        
        inputFlightDateTextField.inputAccessoryView = toolbar
    }
    @objc func doneClicked() {
        //format the date display in textfield
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        inputFlightDateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func findFlightClicked() {
        guard inputFlightNumberTextField.text != "" && inputFlightDateTextField.text != "" else {
            return createAlert(title: "Error in finding flight!", message: "Missing both flight number and flight date.")
        }
        guard inputFlightNumberTextField.text != "" else{
            return createAlert(title: "Error in finding flight!", message: "Missing flight number.")}
        guard inputFlightDateTextField.text != "" else{
            return createAlert(title: "Error in finding flight!", message: "Missing flight date.")}
        
        performSegue(withIdentifier: "toFlightInfo", sender: self.navigationController)
        
    }
    
//    @objc func getCustomerInfo() {
//
//        //Gets new auth token and then gets flight status once that is successful
//        LufthansaAPIClient.getAuthToken() {
//            LufthansaAPIClient.getFlightStatus(flightNum: "LH5771", date: "2019-03-02") { flt in
//                self.label.text = flt.timeStatus
//                self.animateImage()
//            }
//        }
//    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FlightInformationViewController {
            vc.flightNumber = inputFlightNumberTextField.text
            vc.flightDate = inputFlightDateTextField.text 

        }
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
