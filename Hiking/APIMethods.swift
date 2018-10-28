//
//  APIMethods.swift
//  Hiking
//
//  Created by MOHAMED on 3/19/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftValidator

class APIMethods {
    // Register Function
    class func Register(username:String , password: String , email: String, mobile : String, password_confirmation:String , compltion : @escaping (_ status: Int , _ message :String,_ activationtype:String)->Void) {
        let url = URL(string: RegisterUrl)!
        let parameters = [
            "name" : username,
            "password" : password,
            "email"     : email ,
            "mobile"   : mobile,
            "password_confirmation" : password_confirmation
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
                
                if let json = JSON(value).dictionary {
                    if let user = json["user"]?.dictionary {
                        if let active = user["active"]?.int {
                            compltion(active,"انت تحتاج إلى تفعيل حسابك" ,"")
                            if let activationtype = json["type"]?.string{
                                if let message = json["message"]?.string{
                                    compltion(active, message, activationtype)
                                }
                            }
                        }
                        
                    }
                    
                }
                
                
                
                // compltion("success",active!)
                return
            case .failure(let error):
                let json = JSON(error)
                let message = json["message"].string
                compltion(2, message!,"")
                return
            }
        }
    }
    
    // Login Function
    
    class func Login (email : String , password : String ,compltion : @escaping (_ status: Int,_ message:String, _ activationType : String)->Void) {
        let url = URL(string: LoginUrl)!
        let parameters = [
            "email" : email,
            "password" : password
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
                
                if let json = JSON(value).dictionary {
                    if let user = json["user"]?.dictionary {
                        
                        if let active = user["active"]?.int {
                            compltion(active,"انت تحتاج إلى تفعيل حسابك" ,"")
                            if active == 1 {
                                if let api_token = user["api_token"]?.string{
                                    ApiToken.setApiToken(Token: api_token)
                                }
                            }
                            if let activationtype = json["type"]?.string{
                                if let message = json["message"]?.string{
                                    compltion(active, message, activationtype)
                                }
                            }
                        }
                        
                    }
                    
                }
                
                // compltion("success",active!)
                return
            case .failure(let error):
                
                if let json = JSON(error).dictionary {
                    if let mymessage = json["message"]?.string {
                        compltion (0, mymessage,"")
                    }
                    
                    
                    
                    
                }
                print(error)
                // compltion("failed",message)
                return
            }
        }
        
    }
    // Know Activation Type
    class func Activation( compltion : @escaping (_ activationType : String)->Void){
        let url = URL(string: AccountActivationType)
        Alamofire.request(url!, method: .get, parameters:nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let type = json["type_active"].string {
                    compltion(type)
                }
                return
            case .failure(let error):
                compltion("")
                
                print(error)
            }
            
        }
    }
    
    // Sms Activation Function
    class func SmsActivation(Code:Int){
        let url = URL(string: SmsUrl)!
        let parametes = [
            "code" : Code
        ]
        
        Alamofire.request(url, method: .post, parameters: parametes, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    // Get Special Building
    class func getBuilding(page : Int = 1,compltion : @escaping (_ error:Error?,_ builds: [BuildModel]? , _ last_page : Int)->Void) {
        let url = URL(string: SpecialBuildingUrl)!
        let parameters = [
            "page" : page
            ] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case.failure(let error) :
                compltion(error, nil, page)
                print(error)
            case.success(let value):
                let json = JSON(value)
                var builds = [BuildModel]()
                if let build = json["build"].dictionary {
                    if let data = build["data"]?.array{
                        for obj in data {
                            if let obj = obj.dictionary {
                                let build = BuildModel(BuildDect: obj)
                                builds.append(build)
                            }
                        }
                    }
                    
                }
                
                
                let last_page = json["last_page"].int ?? page
                compltion(nil, builds, last_page)
                break
            }
            
        }
        
        
        
    }
    
    // Closest Building
    class func ClosestBuilding(latlng : String  ,page : Int = 1,compltion : @escaping (_ error:Error?,_ builds: [BuildModel]? , _ last_page : Int)->Void){
        let url = URL(string: ClosestBuildingUrl)!
        let parameters = [
            "page" : page,
            "latlng" : latlng
            ] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case.failure(let error) :
                compltion(error, nil, page)
                print(error)
            case.success(let value):
                let json = JSON(value)
                var builds = [BuildModel]()
                if let build = json["build"].dictionary {
                    if let data = build["data"]?.array{
                        for obj in data {
                            if let obj = obj.dictionary {
                                let build = BuildModel(BuildDect: obj)
                                builds.append(build)
                            }
                        }
                    }
                    
                }
                
                
                let last_page = json["last_page"].int ?? page
                compltion(nil, builds, last_page)
                break
            }
            
        }
        
        
        
        
    }
    
    // Newtest Building
    class func NewestBuilding(page : Int = 1,compltion : @escaping (_ error:Error?,_ builds: [BuildModel]? , _ last_page : Int)->Void){
        let url = URL(string: NewestBuildingUrl)!
        let parameters = [
            "page" : page
            ] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case.failure(let error) :
                compltion(error, nil, page)
                print(error)
            case.success(let value):
                let json = JSON(value)
                var builds = [BuildModel]()
                if let build = json["build"].dictionary {
                    if let data = build["data"]?.array{
                        for obj in data {
                            if let obj = obj.dictionary {
                                let build = BuildModel(BuildDect: obj)
                                builds.append(build)
                            }
                        }
                    }
                    
                }
                
                
                let last_page = json["last_page"].int ?? page
                compltion(nil, builds, last_page)
                break
            }
            
        }
        
        
        
    }
    
    // Contact Us
    class func ContactUs(name : String , mail :String , title : String , details : String){
        let url = URL(string: ContactUsUrl)!
        
        let parameters = [
            "name" : name,
            "email" :mail ,
            "title" : title ,
            "content" : details
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
    /// Get All Places
    class func getAllPlaces(compltion : @escaping (_ error:Error?,_ places: [PlacesModel]?)->Void){
        let url = URL(string: PlacesUrl)!
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                compltion(error, nil)
                print(error)
                return
            case .success(let value):
                let json = JSON(value)
                var places = [PlacesModel]()
                if  let countries = json["countries"].array {
                    for obj in countries {
                        if let obj = obj.dictionary{
                            let place = PlacesModel(Places: obj)
                            places.append(place)
                        }
                        
                    }
                    
                }
                compltion(nil, places)
                return
                
            }
        }
    }
    
    // Gat All Areas
    
    class func getAllAreas(id:Int,compltion : @escaping (_ error:Error?,_ areas: [AreaModel]?)->Void){
        let url = URL(string: AreaUrl)!
        let parametes = [
            
            "country_id" : id
        ]
        
        Alamofire.request(url, method: .get, parameters: parametes, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                compltion(error, nil)
                print(error)
                return
            case .success(let value):
                let json = JSON(value)
                var areas = [AreaModel]()
                if  let areadata = json["area"].array {
                    for obj in areadata {
                        if let obj = obj.dictionary{
                            let area = AreaModel(Area: obj)
                            areas.append(area)
                        }
                        
                    }
                    
                }
                compltion(nil, areas)
                return
                
            }
        }
        
    }
    
    //Get All Cities
    
    class func getAllCities(id:Int,compltion : @escaping (_ error:Error?,_ cities: [CityModel]?)->Void){
        let url = URL(string: CityUrl)!
        let parametes = [
            
            "area_id" : id
        ]
        
        Alamofire.request(url, method: .get, parameters: parametes, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                compltion(error, nil)
                print(error)
                return
            case .success(let value):
                let json = JSON(value)
                var cities = [CityModel]()
                if  let citydata = json["cities"].array {
                    for obj in citydata {
                        if let obj = obj.dictionary{
                            let city = CityModel(city: obj)
                            cities.append(city)
                        }
                        
                    }
                    
                }
                compltion(nil, cities)
                return
                
            }
        }
        
    }
    
    
    //Get All Sections
    
    class func getAllSections(id:Int,compltion : @escaping (_ error:Error?,_ sections: [SectionModel]?)->Void){
        let url = URL(string: SectionUrl)!
        let parametes = [
            
            "city_id" : id
        ]
        
        Alamofire.request(url, method: .get, parameters: parametes, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                compltion(error, nil)
                print(error)
                return
            case .success(let value):
                let json = JSON(value)
                var sections = [SectionModel]()
                if  let sectiondata = json["sections"].array {
                    for obj in sectiondata {
                        if let obj = obj.dictionary{
                            let section = SectionModel(section: obj)
                            sections.append(section)
                        }
                        
                    }
                    
                }
                compltion(nil, sections)
                return
                
            }
        }
        
    }
    
    // Search Method
    
    
    
    
    class func BuildingSearch(city:String,page : Int = 1,compltion : @escaping (_ error:Error?,_ builds: [BuildModel]? , _ last_page : Int)->Void){
        let url = URL(string: SearchUrl)!
        let parameters = [
            "city_id" : city
            ] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case.failure(let error) :
                compltion(error, nil, page)
                print(error)
            case.success(let value):
                let json = JSON(value)
                var builds = [BuildModel]()
                if let builddata = json["builds"].array {
                    for obj in builddata {
                        if let obj = obj.dictionary {
                            let build = BuildModel(BuildDect: obj)
                            builds.append(build)
                        }
                    }
                }
                let last_page = json["last_page"].int ?? page
                compltion(nil, builds, last_page)
                break
            }
            
            
            
        }
        
    }
    
    
    // Add To Favourite
    
    class func AddToFavourite (Id : Int , api_token : String) {
        let url = URL(string: AddToFavouritUrl)!
        let parameter = [
            "api_token": api_token,
            "fav_id" : Id
            ] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                print(value)
            }
        }
    }
    // User Favourit Icon
    class func UserFavourit (page : Int = 1, api_token : String,compltion : @escaping (_ error:Error?,_ builds: [BuildModel]? , _ last_page : Int)->Void){
        let url = URL(string: UserFavouriteUrl)!
        let parameters = [
            "page" : page,
            "api_token" : api_token
            ] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case.failure(let error) :
                compltion(error, nil, page)
                print(error)
            case.success(let value):
                let json = JSON(value)
                var builds = [BuildModel]()
                if let build = json["build"].dictionary {
                    if let data = build["data"]?.array{
                        for obj in data {
                            if let obj = obj.dictionary {
                                let build = BuildModel(BuildDect: obj)
                                builds.append(build)
                            }
                        }
                    }
                    
                }
                
                
                let last_page = json["last_page"].int ?? page
                compltion(nil, builds, last_page)
                break
            }
            
        }
        
        
        
    }
    
    
    // Remove From Fav
    class func RemoVeFromFav(Id : Int , api_token : String) {
        let url = URL(string: RemoveFromFavUrl)!
        let parameter = [
            "api_token": api_token,
            "fav_id" : Id
            ] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                print(value)
            }
        }
    }
    
    // Get User Data
    class func UserData(api_token : String,compltion : @escaping (_ error:Error?, _ name : String? , _ email : String? , _ mobile : String? )->Void){
        let url = URL(string: UserDataUrl)!
        let parameters = [
            "api_token" : api_token
        ]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                compltion(error, nil, nil, nil)
                print(error)
                return
            case .success(let value):
                let json = JSON(value)
                let user = json["user"]
                 let name = user["name"].string
                let email = user["email"].string
                let mobile = user["mobile"].string
                compltion(nil, name, email, mobile)
                return
                
                
            }
        }
    }
    
    // Edit User Account 
    class func EditUserData (api_token : String , name : String , mobile : String , email : String , password : String) {
        let url = URL(string: EditUserUrl)!
        let parametes = [
            "api_token" : api_token,
            "name" : name,
            "mobile" : mobile,
            "email" : email ,
            "password" : password
        ]
        
        Alamofire.request(url, method: .post, parameters: parametes, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
                
            case .failure(let error):
                print(error)
            case .success(let value) :
                print(value)
            }
        }
    }
    
    class func UserResrvations(api_token : String , page : Int = 1,compltion : @escaping (_ error:Error?,_ reserves: [ReseveModel]? , _ last_page : Int)->Void){
        let url = URL(string: ReserveUrl)!
        
        let parameters = [
            "page" : page,
            "api_token" : api_token
            ] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case.failure(let error) :
                compltion(error, nil, page)
                print(error)
            case.success(let value):
                let json = JSON(value)
                var reserves = [ReseveModel]()
                if let build = json["reservations"].dictionary {
                    if let data = build["data"]?.array{
                        for obj in data {
                            if let obj = obj.dictionary {
                                let reserve = ReseveModel(ReserveDict: obj)
                                reserves.append(reserve)
                            }
                        }
                    }
                    
                }
                
                
                let last_page = json["last_page"].int ?? page
                compltion(nil, reserves, last_page)
                break
            }
            
        }
    }
    
    class func ReportBuilding(Id:Int , api_token : String, title:String, content:String) {
        let url = URL(string: AlertBuildingUrl)!
        let parameters = [
            "api_token" : api_token,
            "build_id" : Id,
            "title" : title,
            "content" : content
        ] as [String : Any]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error) :
                print(error)
            case.success(let value):
                print(value)
                
            }
        }
    }
}




