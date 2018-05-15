//
//  SaveClass.swift
//  Chnen
//
//  Created by User on 07/07/17.
//  Copyright © 2017 navjot_sharma. All rights reserved.
//

import UIKit

class SaveClass: NSObject {
    
    //MARK: Shared Instance
    static let sharedInstance : SaveClass = {
        let instance = SaveClass()
        return instance
    }()
    
    //MARK:- Variables
    var id = String()
    var refresh_token = String()
    var session_token = String()
    var active_jobs = Int()
    var average_rating = Int()
    var jobs_completed = Int()
    var total_income = Int()
    var review = String()
    var feedback = String()
    var rating = Float()
    var central_address = String()
    var company_name = String()
    var email = String()
    var is_leavz = Bool()
    var is_mowz = Bool()
    var is_plowz = Bool()
    var phone_number = String()
    var photo_url = String()
    var radius = Int()
    var worker_name = String()
    var zip = String()
    var address_city = String()
    var city_image_url = String()
    var isWorkerAPICalled = Bool()
    var SavedArrApplyFilters = [Product]()
    
    //MARK:- Save Methods
    func saveId(str:String){
        id = str
        defaults.set(id, forKey: "id")
    }
    
    func saveRefreshToken(str:String){
        refresh_token = str
        defaults.set(refresh_token, forKey: "refresh_token")
    }
    
    func saveSessionToken(str:String){
        session_token = str
        defaults.set(session_token, forKey: "session_token")
    }
    
    func saveCentralAddress(str:String){
        central_address = str
        defaults.set(central_address, forKey: "central_address")
    }
    
    func saveCompanyName(str:String){
        company_name = str
        defaults.set(company_name, forKey: "company_name")
    }
    
    func saveEmail(str:String){
        email = str
        defaults.set(email, forKey: "email")
    }
    
    func savePhoneNumber(str:String){
        phone_number = str
        defaults.set(phone_number, forKey: "phone_number")
    }
    
    func savePhotoUrl(str:String){
        photo_url = str
        defaults.set(photo_url, forKey: "photo_url")
    }
    
    func saveRadius(str:Int){
        radius = str
        defaults.set(radius, forKey: "radius")
    }
    
    func saveWorkerName(str:String){
        worker_name = str
        defaults.set(worker_name, forKey: "worker_name")
    }
    
    func saveZip(str:String){
        zip = str
        defaults.set(zip, forKey: "zip")
    }
    
    func saveaddress_city(str:String){
        address_city = str
        defaults.set(address_city, forKey: "address_city")
    }
    
    func saveCityImage(str:String){
        city_image_url = str
        defaults.set(city_image_url, forKey: "city_image_url")
    }
    
    func saveIsLeavz(str:Bool){
        is_leavz = str
        defaults.set(is_leavz, forKey: "is_leavz")
    }
    
    func saveIsMowz(str:Bool){
        is_mowz = str
        defaults.set(is_mowz, forKey: "is_mowz")
    }
    
    func saveIsPlowz(str:Bool){
        is_plowz = str
        defaults.set(is_plowz, forKey: "is_plowz")
    }
    
    //MARK:- Get Methods
    func getId() -> String{
        return id == "" ? defaults.string(forKey: "id")! : id
    }
    
    func getRefreshToken() -> String{
        return refresh_token == "" ? defaults.string(forKey: "refresh_token")! : refresh_token
    }
    
    func getSessionToken() -> String{
        return defaults.string(forKey: "session_token") == "" ? defaults.string(forKey: "session_token")! : session_token
    }
    
    func getCentralAddress() -> String{
        return central_address == "" ? defaults.string(forKey: "central_address")! : central_address
    }
    
    func getCompanyName() -> String{
        return company_name == "" ? defaults.string(forKey: "company_name")! : company_name
    }
    
    func getEmail() -> String{
        return email == "" ? defaults.string(forKey: "email")! : email
    }
    func getisleavz() -> Bool{
        return defaults.bool(forKey: "is_leavz")
    }
    
    func getismowz() -> Bool{
        
        return defaults.bool(forKey: "is_mowz")
    }
    
    func getisplowz() -> Bool{
        return  defaults.bool(forKey: "is_plowz")
    }
    func getPhoneNumber() -> String{
        return phone_number == "" ? defaults.string(forKey: "phone_number")! : phone_number
    }
    
    func getPhotoUrl() -> String{
        return photo_url == "" ? defaults.string(forKey: "photo_url")! : photo_url
    }
    
    func getRadius() -> Int{
        return radius == 0 ? defaults.integer(forKey: "radius") : radius
    }
    
    func getWorkerName() -> String{
        return worker_name == "" ? defaults.string(forKey: "worker_name")! : worker_name
    }
    func getZip() -> String{
        return zip == "" ? defaults.string(forKey: "zip")! : zip
    }
    func getAddressCity() -> String{
        return address_city == "" ? defaults.string(forKey: "address_city")! : address_city
    }
    
    func getCityImage() -> String{
        return city_image_url == "" ? defaults.string(forKey: "city_image_url")! : city_image_url
    }
    
}

