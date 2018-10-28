//
//  SearchVC.swift
//  Hiking
//
//  Created by MOHAMED on 3/30/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    var selecPlace :PlacesModel?
    var SelectArea : AreaModel?
    var SelectCity : CityModel?
    var SelectSection : SectionModel?
    
    @IBOutlet weak var SectionText: UILabel!
    @IBOutlet weak var SectionButton: UIButton!
// المدينة
    @IBOutlet weak var CityButton: UIButton!
    @IBOutlet weak var CityText: UILabel!
    //المنطقة
    @IBOutlet weak var AreaText: UILabel!
    @IBOutlet weak var AreaButton: UIButton!
    // الدولة
    @IBOutlet weak var CountryText: UILabel!
    @IBOutlet weak var SelectPlace: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AreaButton.isHidden = true
        self.AreaText.isHidden = true
        self.CityButton.isHidden = true
        self.CityText.isHidden = true
        self.SectionText.isHidden = true
        self.SectionButton.isHidden = true
    }

    @IBAction func SearchPlaceBu(_ sender: UIButton) {
        self.view.showActivityIndicator()
        let presenter = APIPlacesPresenter()
        presenter.showPlacesIn(vc: self, sender: sender) { (place) in
            self.selecPlace = place
            self.CountryText.text = place.title
            sender.setTitle(String(place.id), for: .normal)
            sender.titleLabel?.isHidden = true

            self.view.hideActivityIndicator()
            self.AreaButton.isHidden = false
            self.AreaText.isHidden = false
            
            
        }
    }
  
    @IBAction func SearchAreaBu(_ sender: UIButton) {
        self.view.showActivityIndicator()
        let presenter = APIAreaPresenter()
        if let id = Int((self.SelectPlace.titleLabel?.text!)!) {
        presenter.showAreaIn(id : id,vc: self, sender: sender) { (area) in
            self.SelectArea = area
            self.AreaText.text = area.title
            sender.setTitle(String(area.id), for: .normal)
            sender.titleLabel?.isHidden = true
            self.view.hideActivityIndicator()
            self.CityButton.isHidden = false
            self.CityText.isHidden = false
            
            }
        }
    }
    
    @IBAction func SearchCityBu(_ sender: UIButton) {
        self.view.showActivityIndicator()
        let presenter = APICityPresenter()
        if let id = Int((self.AreaButton.titleLabel?.text!)!) {
            presenter.showCityIn(id : id,vc: self, sender: sender) { (city) in
                self.SelectCity = city
                self.CityText.text = city.title
                sender.setTitle(String(city.id), for: .normal)
                sender.titleLabel?.isHidden = true

                self.view.hideActivityIndicator()
                self.SectionText.isHidden = false
                self.SectionButton.isHidden = false
                
            }
        }
    }
    
    @IBAction func SearchSectionBu(_ sender: UIButton) {
        self.view.showActivityIndicator()
        let presenter = APISectionPresenter()
        if let id = Int((self.CityButton.titleLabel?.text!)!) {
            presenter.showSectionIn(id : id,vc: self, sender: sender) { (section) in
                self.SelectSection = section
                self.SectionText.text = section.title
                sender.setTitle(String(section.id), for: .normal)
                sender.titleLabel?.isHidden = true
                self.view.hideActivityIndicator()
                
            }
        }
    }
    
    @IBAction func SearchBu(_ sender: UIButton) {
        performSegue(withIdentifier: "SearchResultSeque", sender: UIButton.self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dist = segue.destination as? SearchResultVC {
            
            dist.city_name = CityButton.titleLabel?.text
        
            
        }
        
    }
    @IBAction func MenuBu(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuVC
        self.present(vc, animated: true, completion: nil)
    }
}
