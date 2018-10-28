//
//  SingleBuildVC.swift
//  Hiking
//
//  Created by MOHAMED on 3/30/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON
import ImageSlideshow
import MapKit
class SingleBuildVC: UIViewController , UIScrollViewDelegate , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,MKMapViewDelegate, CLLocationManagerDelegate, UINavigationControllerDelegate {
    var locationmanager = CLLocationManager()
    var ImagesArray : [InputSource]!
    @IBOutlet weak var BuildingSlideShow: ImageSlideshow!
    
    @IBOutlet weak var TopBuildingNameText: UILabel!
    @IBOutlet weak var FacilityCollectionView: UICollectionView!
    
    @IBOutlet weak var BuildingLocationText: UILabel!
    @IBOutlet weak var BuildingNameText: UILabel!
    
    @IBOutlet weak var BuildingSocietyDetailsText: UITextView!
    
    @IBOutlet weak var LoadMoreButton: UIButton!
    
    //@IBOutlet weak var SuitableForText: UILabel!
    @IBOutlet weak var BuildingMap: MKMapView!
    
    
    @IBOutlet weak var SuitableText: UILabel!
    
    @IBOutlet weak var ConcilesMenText: UILabel!
    @IBOutlet weak var ConcilesWomanText: UILabel!
    
    @IBOutlet weak var MiddleOfWeekText: UILabel!
    
    @IBOutlet weak var FridayText: UILabel!
    
    @IBOutlet weak var SaturdayText: UILabel!
    
    
    @IBOutlet weak var ThursdayText: UILabel!
    
    @IBOutlet weak var PhoneText: UILabel!
    
    @IBOutlet weak var InstagramText: UILabel!
    
    @IBOutlet weak var TwitterText: UILabel!
    
    
    @IBOutlet weak var FacebookText: UILabel!
    
    @IBOutlet weak var FavIcon: UIButton!
    var IsSelected = false
    
    var Photo = [BuildFacilityModel]()
    
    @IBOutlet weak var DepartmentLabel: UILabel!
    @IBOutlet weak var DepartmentImage: UIImageView!
    var Sliders = [Dictionary<String,String>]()
    var SingleItem : BuildModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FacilityCollectionView.delegate = self
        FacilityCollectionView.dataSource = self
        locationmanager.delegate = self
        print("Sig Id :" + String(describing: SingleItem?.id))
        SetSingleBuild(Id: (SingleItem)!)
        FacilityCollectionView.register(UINib.init(nibName: "BuildingCell", bundle: nil), forCellWithReuseIdentifier: "BuildingCell")
        
        
    }
    
    @IBAction func MenuBu(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuVC
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    func SetSingleBuild(Id : BuildModel){
        let url = URL(string: SingleBuildUrl + String(Id.id))!
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                
                let json = JSON(value)
                // Slider Images
                var ImagesArray : [InputSource] = []
                for (index, obj) in json["files"]{
                    
                    if let imagePath = obj["path"].string {
                        if let imageFile = obj["file"].string {
                            let ImageRoot =   KingfisherSource(urlString: FileRoote + imagePath + imageFile)
                            
                            ImagesArray.append(ImageRoot!)
                        }
                        
                    }
                    
                    
                }
                self.BuildingSlideShow.setImageInputs(ImagesArray)
                // End Of Slider Images
                // Department
                let department = json["department"]
                let dep_name = department["name"].string
                self.DepartmentLabel.text = dep_name
                let dep_icon = department["icon_path"].string
                let url = URL(string: FileRoote + dep_icon!)
                self.DepartmentImage.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                let build = json["build"]
                
                // BuildName
                let BuidName = build["name"].string
                self.BuildingNameText.text = BuidName
                self.TopBuildingNameText.text = BuidName
                // City ANd Area [Building Location]
                let area = build["location_rest_area"].string
                let city = build["location_rest_city"].string
                self.BuildingLocationText.text = area! + " " + city!
                // Facilities Icons
                
                
                // End Of Facilities Icons
                // Suitable For
                let suitable_for = build["suitable_for"].string
                self.SuitableText.text = suitable_for!
                // end Suitable For
                // councils_men
                let councils_men = build["councils_men"].int
                self.ConcilesMenText.text = String(describing: councils_men!)
                // councils_women
                let councils_women = build["councils_women"].int
                self.ConcilesWomanText.text = String(describing: councils_women!)
                // Middle Week
                let middleWeek = build["middle_week"].string
                self.MiddleOfWeekText.text = middleWeek! + "ريال"
                //saturday
                let saturday = build["saturday"].string
                self.SaturdayText.text = saturday! + "ريال"
                // friday
                let friday = build["friday"].string
                self.FridayText.text = friday! + "ريال"
                // thursday
                let thursday = build["thursday"].string
                self.ThursdayText.text = thursday! + "ريال"
                //eid_al_fitr
                let eid_al_fitr = build["eid_al_fitr"].string
                //eid_al_adha
                let eid_al_adha = build["eid_al_adha"].string
                // mobile
                let mobile = build["first_mobile"].string
                self.PhoneText.text = mobile
                // Instagram
                let instagram = build["instagram"].string
                self.InstagramText.text = instagram
                //twitter
                let twitter = build["twitter"].string
                self.TwitterText.text = twitter
                // facebook
                let facebook = build["facebook"].string
                self.FacebookText.text = facebook
                // Location Map
                let longitude = build["location_rest_longitude"].string
                let latitude = build["location_rest_latitude"].string
                let lat = Double(latitude!)
                let lan = Double(longitude!)
                let latDelta : CLLocationDegrees = 0.05
                let LongDelte :CLLocationDegrees = 0.05
                let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: LongDelte)
                let cordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lan!)
                
                let region = MKCoordinateRegion(center: cordinate, span: span)
                self.BuildingMap.setRegion(region, animated: true)
                
                // End Of Location Map
                // Build Description
                if  let content = build["content"].string{
                    self.BuildingSocietyDetailsText.text = content
                }
                // End Of Description
                
                let Facilities = json["f_and_s"]
                for (i , facility ) in Facilities{
                    if let facility = facility.dictionary{
                        let fa = BuildFacilityModel(Facil: facility )
                        self.Photo.append(fa)
                        self.FacilityCollectionView.reloadData()
                    }
                    
                    
                }
            }
        }
        
    }
    
    @IBAction func AddToFavouritBu(_ sender: UIButton) {
        if self.IsSelected == false {
            sender.setImage(#imageLiteral(resourceName: "Fav"), for: .normal)
            if let api_token = ApiToken.getApiToken() {
                APIMethods.AddToFavourite(Id: (SingleItem?.id!)! , api_token: api_token)
            }else{
                let title  = "خطأ"
                let message = "أنت تحتاج إلى تسجيل الدخول أولا"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "إلغاء", style: UIAlertActionStyle.cancel, handler:nil))
                alert.addAction(UIAlertAction(title: "تسجيل الدخول", style: UIAlertActionStyle.default, handler:{ (actionSheetController) -> Void in
                    self.LoginScreen()
                }))
                self.present(alert, animated: true, completion: nil)
                
                
                
            }
            
        }else{
            
            sender.setImage(#imageLiteral(resourceName: "UnFav"), for: .normal)
            if let api_token = ApiToken.getApiToken() {
                APIMethods.RemoVeFromFav(Id: (SingleItem?.id!)!, api_token: api_token)
            }else{
                let title  = "خطأ"
                let message = "أنت تحتاج إلى تسجيل الدخول أولا"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "إلغاء", style: UIAlertActionStyle.cancel, handler:nil))
                alert.addAction(UIAlertAction(title: "تسجيل الدخول", style: UIAlertActionStyle.default, handler:{ (actionSheetController) -> Void in
                    self.LoginScreen()
                }))
                self.present(alert, animated: true, completion: nil)
                
                
                
            }
            
        }
        self.IsSelected = !self.IsSelected
    }
    
    // View Login Screen
    func LoginScreen(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginScreen")
        
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func ShareBu(_ sender: UIButton) {
        let activityVc = UIActivityViewController(activityItems: [SharingAppUrl], applicationActivities: nil)
        activityVc.popoverPresentationController?.sourceView = self.view
        self.present(activityVc, animated: true, completion: nil)
    }
    
    // Reserve
    
    @IBAction func ReserveBuildingBu(_ sender: UIButton) {
        if let api_toke = ApiToken.getApiToken(){
            let id = String(describing: SingleItem!)
            let url = URL(string: ReserveUrl + api_toke + id)!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                //If you want handle the completion block than
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                    print("Open url : \(success)")
                })
            }
            
        }
    }
    
    /// Number Of Items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(Photo.count)
        return Photo.count
    }
    // Cell For Item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BuildingCell", for: indexPath) as? BuildingCell else {return UICollectionViewCell()}
        let photo = Photo[indexPath.item]
        cell.ConfigureCell(build: photo)
        return cell
        
    }
    
    @IBAction func ReserveBuildBu(_ sender: UIButton) {
        performSegue(withIdentifier: "ReserveBuilding", sender:AnyObject.self)
    }
 
   
    @IBAction func ReportBuildingBu(_ sender: UIButton) {
        performSegue(withIdentifier: "AlertSegue", sender:AnyObject.self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "ReserveBuilding" {
            if let dist = segue.destination as? ReserveBuildingVC {
                
                dist.Build_id = SingleItem?.id
                
                
            }
        } else if segue.identifier == "AlertSegue" {
            
            if let dist = segue.destination as? AlertBuildingVC {
                
                dist.Build_id = SingleItem?.id
            }
        }
        
        
    }
}


