//
//  ViewController.swift
//  HolidaysApp
//
//  Created by Saranya Kalyanasundaram on 5/27/20.
//  Copyright © 2020 Saranya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var holidaysTableView: UITableView!
    var listOfHolidays = [HolidayDetail](){
        didSet{
            DispatchQueue.main.async {
                self.holidaysTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchBar.delegate = self
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfHolidays.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HolidaysCell", for: indexPath)
        let holiday = listOfHolidays[indexPath.row]
        cell.textLabel?.text = holiday.name
        cell.detailTextLabel?.text = holiday.date.iso
        return cell
    }

}

extension ViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else{return }
        let holidayRequest = HolidayRequest(countryCode: searchText)
        holidayRequest.getHolidays(completion: {[weak self] result in
            
            switch result{
                
            case .failure(let error):
                print(error)
                
            case .success(let data):
                self?.listOfHolidays = data
            }
        })
    }
    
}
