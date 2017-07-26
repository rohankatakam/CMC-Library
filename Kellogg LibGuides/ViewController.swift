//
//  ViewController.swift
//  Kellogg LibGuides
//
//  Created by Student on 6/28/17.
//  Copyright © 2017 Rohan Katakam. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var webView: UIWebView!
    
    
    var data : [String] = []
    
    var urls : [String] = []
    
    var logos : [String] = []
    
    
    var descriptions : [String] = []
    
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    // don't forget to hook this up from the storyboard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseJSON(urlValue: "https://lgapi-us.libapps.com/1.1/assets?site_id=1956&key=ec14c106e1d7ce59e73675de000184d9&asset_types=10&expand=permitted_uses,az_types,az_props")

        
        tableView.layer.cornerRadius = view.frame.width/28.0
        tableView.clipsToBounds = true
        tableView.backgroundColor = UIColor.lightText
        
        
        webView = UIWebView(frame: UIScreen.main.bounds)
        webView.delegate = self
        
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = UIColor.lightText
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        cell.textLabel?.text = self.data[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row).")
        
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    
    func parseJSON(urlValue: String) {
        let urlString = urlValue
        
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
                    
                    
                    
                    var guideNames : [String] = []
                    
                    for element in parsedData {
                        guideNames.append(element["name"]! as! String)
                    }
                    
                    var guideDescriptions : [String] = []
                    
                    for element in parsedData {
                        var html = element["description"]! as! String
                        
                        var str = html.replacingOccurrences(of: "<[^>]+>\r\n", with: "", options: .regularExpression, range: nil)
                        
                        str = str.plainTextFromHTML()!
                        
                        guideDescriptions.append(str)
                    }
                    
                    var guideLogos : [String] = []
                    
                    for element in parsedData {
                        var meta = element["meta"] as! [String:Any]!
                        
                        var logo : String = "http:\(meta?["tn_url"] as! String)"
                        
                        if logo == "http:"{
                            logo = "blank"
                        }
                        
                        
                        guideLogos.append(logo)
                    }
                    
                    
                    var guideURLs : [String] = []
                    
                    for element in parsedData {
                        guideURLs.append(element["url"]! as! String)
                    }
                    
                   
                    
                    display(arr: guideNames)
                    print(guideNames.count)
                    print("---------------------")
                    
                    
                    display(arr: guideURLs)
                    print(guideURLs.count)
                    print("---------------------")

                    
                    display(arr: guideLogos)
                    print(guideLogos.count)
                    print("---------------------")

                    
                    display(arr: guideDescriptions)
                    print(guideDescriptions.count)
                    
                    
                    print("---------------------")
                    
                    
                    print("Deleted Set")
                    
                    //Remove Capital IQ
                    let capitalIQ = getIndex(arr: guideNames, filter: "Capital IQ")
                    
                    guideNames.remove(at: capitalIQ)
                    guideURLs.remove(at: capitalIQ)
                    guideLogos.remove(at: capitalIQ)
                    guideDescriptions.remove(at: capitalIQ)
                    
                    
                    
                    //Remove Thomson Investext
                    
                    let thomson = getIndex(arr: guideNames, filter: "Thomson Investext")
                     
                    guideNames.remove(at: thomson)
                    guideURLs.remove(at: thomson)
                    guideLogos.remove(at: thomson)
                    guideDescriptions.remove(at: thomson)
                    
                    
                    
                    //Remove Emerging Markets Information Service (EMIS)
                     
                    let emis = getIndex(arr: guideNames, filter: "Emerging Markets Information Service (EMIS)")
                     
                    guideNames.remove(at: emis)
                    guideURLs.remove(at: emis)
                    guideLogos.remove(at: emis)
                    guideDescriptions.remove(at: emis)
                    
                    
                    
                    //Remove Associations unlimited
                    let associations = getIndex(arr: guideNames, filter: "Associations Unlimited")
                    
                    guideNames.remove(at: associations)
                    guideURLs.remove(at: associations)
                    guideLogos.remove(at: associations)
                    guideDescriptions.remove(at: associations)
                    
                    //Remove Datastream
                    let datastream = getIndex(arr: guideNames, filter: "Datastream")
                    
                    guideNames.remove(at: datastream)
                    guideURLs.remove(at: datastream)
                    guideLogos.remove(at: datastream)
                    guideDescriptions.remove(at: datastream)
                    
                    //Remove FactSet
                    let factset = getIndex(arr: guideNames, filter: "FactSet")
                    
                    guideNames.remove(at: factset)
                    guideURLs.remove(at: factset)
                    guideLogos.remove(at: factset)
                    guideDescriptions.remove(at: factset)
                    
                    //Remove Financial Times
                    let finanacialTimes = getIndex(arr: guideNames, filter: "Financial Times")
                    
                    guideNames.remove(at: finanacialTimes)
                    guideURLs.remove(at: finanacialTimes)
                    guideLogos.remove(at: finanacialTimes)
                    guideDescriptions.remove(at: finanacialTimes)
                    
                    //Remove Gale CaseBase: Case Studies in Global Business
                    let gale = getIndex(arr: guideNames, filter: "Gale CaseBase: Case Studies in Global Business")
                    
                    guideNames.remove(at: gale)
                    guideURLs.remove(at: gale)
                    guideLogos.remove(at: gale)
                    guideDescriptions.remove(at: gale)
                    
                    //Remove RCA: Real Capital Analytics
                    let rca = getIndex(arr: guideNames, filter: "RCA: Real Capital Analytics")
                    
                    guideNames.remove(at: rca)
                    guideURLs.remove(at: rca)
                    guideLogos.remove(at: rca)
                    guideDescriptions.remove(at: rca)
                    
                    //Remove BoardEx
                    let board = getIndex(arr: guideNames, filter: "BoardEx")
                    
                    guideNames.remove(at: board)
                    guideURLs.remove(at: board)
                    guideLogos.remove(at: board)
                    guideDescriptions.remove(at: board)
                    
                    //Remove SNL
                    let snl = getIndex(arr: guideNames, filter: "SNL")
                    
                    guideNames.remove(at: snl)
                    guideURLs.remove(at: snl)
                    guideLogos.remove(at: snl)
                    guideDescriptions.remove(at: snl)
                    
                    //Remove International Directory of Company Histories
                    let international = getIndex(arr: guideNames, filter: "International Directory of Company Histories")
                    
                    guideNames.remove(at: international)
                    guideURLs.remove(at: international)
                    guideLogos.remove(at: international)
                    guideDescriptions.remove(at: international)
                    
                    //Remove TechNavio Global Market Assessment Reports (EMIS)
                    let techNavioGlobal = getIndex(arr: guideNames, filter: "TechNavio Global Market Assessment Reports (EMIS)")
                    
                    guideNames.remove(at: techNavioGlobal)
                    guideURLs.remove(at: techNavioGlobal)
                    guideLogos.remove(at: techNavioGlobal)
                    guideDescriptions.remove(at: techNavioGlobal)
                    
                    //Remove TechNavio Market Assessment Country Reports (EMIS)
                    let techNavioMarket = getIndex(arr: guideNames, filter: "TechNavio Market Assessment Country Reports (EMIS)")
                    
                    guideNames.remove(at: techNavioMarket)
                    guideURLs.remove(at: techNavioMarket)
                    guideLogos.remove(at: techNavioMarket)
                    guideDescriptions.remove(at: techNavioMarket)
                    
                    //Remove TechNavio Regional Market Assessment Reports (EMIS)
                    let techNavioRegional = getIndex(arr: guideNames, filter: "TechNavio Regional Market Assessment Reports (EMIS)")
                    
                    guideNames.remove(at: techNavioRegional)
                    guideURLs.remove(at: techNavioRegional)
                    guideLogos.remove(at: techNavioRegional)
                    guideDescriptions.remove(at: techNavioRegional)
                     
                    //Remove Smart Research - Local Market Research (EMIS)
                    let smartResearch = getIndex(arr: guideNames, filter: "Smart Research - Local Market Research (EMIS)")
                    
                    guideNames.remove(at: smartResearch)
                    guideURLs.remove(at: smartResearch)
                    guideLogos.remove(at: smartResearch)
                    guideDescriptions.remove(at: smartResearch)
                    
                    //Remove Smart Research - Company Profiles (EMIS)
                    let smartResearchCompany = getIndex(arr: guideNames, filter: "Smart Research - Company Profiles (EMIS)")
                    
                    guideNames.remove(at: smartResearchCompany)
                    guideURLs.remove(at: smartResearchCompany)
                    guideLogos.remove(at: smartResearchCompany)
                    guideDescriptions.remove(at: smartResearchCompany)
                    
                    //Remove Smart Research - Global Market Research Reports (EMIS)
                    let smartResearchGlobal = getIndex(arr: guideNames, filter: "Smart Research - Global Market Research Reports (EMIS)")
                    
                    guideNames.remove(at: smartResearchGlobal)
                    guideURLs.remove(at: smartResearchGlobal)
                    guideLogos.remove(at: smartResearchGlobal)
                    guideDescriptions.remove(at: smartResearchGlobal)
                    
                    //Remove Parallaxis Consulting Sector Reports (EMIS)
                    let parallaxis = getIndex(arr: guideNames, filter: "Parallaxis Consulting Sector Reports (EMIS)")
                    
                    guideNames.remove(at: parallaxis)
                    guideURLs.remove(at: parallaxis)
                    guideLogos.remove(at: parallaxis)
                    guideDescriptions.remove(at: parallaxis)
                    
                    //Remove ACM Sector Reports (EMIS)
                    let acm = getIndex(arr: guideNames, filter: "ACM Sector Reports (EMIS)")
                    
                    guideNames.remove(at: acm)
                    guideURLs.remove(at: acm)
                    guideLogos.remove(at: acm)
                    guideDescriptions.remove(at: acm)
                    
                    
                    //Remove Fitch Ratings Special Reports (EMIS)
                    let fitchRatings = getIndex(arr: guideNames, filter: "Fitch Ratings Special Reports (EMIS)")
                    
                    guideNames.remove(at: fitchRatings)
                    guideURLs.remove(at: fitchRatings)
                    guideLogos.remove(at: fitchRatings)
                    guideDescriptions.remove(at: fitchRatings)
                    
                    //Remove Global Data- Industry Snapshots (EMIS)
                    let globalData = getIndex(arr: guideNames, filter: "Global Data- Industry Snapshots (EMIS)")
                    
                    guideNames.remove(at: globalData)
                    guideURLs.remove(at: globalData)
                    guideLogos.remove(at: globalData)
                    guideDescriptions.remove(at: globalData)
                    
                    //Remove Euromonitor Sector Capsules (EMIS)
                    let euromonitorSector = getIndex(arr: guideNames, filter: "Euromonitor Sector Capsules (EMIS)")
                    
                    guideNames.remove(at: euromonitorSector)
                    guideURLs.remove(at: euromonitorSector)
                    guideLogos.remove(at: euromonitorSector)
                    guideDescriptions.remove(at: euromonitorSector)
                    
                    //Remove Euromonitor- Industry Capsules (EMIS)
                    let euromonitorIndustry = getIndex(arr: guideNames, filter: "Euromonitor- Industry Capsules (EMIS)")
                    
                    guideNames.remove(at: euromonitorIndustry)
                    guideURLs.remove(at: euromonitorIndustry)
                    guideLogos.remove(at: euromonitorIndustry)
                    guideDescriptions.remove(at: euromonitorIndustry)
                    
                    //Remove BMI Research - Industry Reports (EMIS)
                    let bmi = getIndex(arr: guideNames, filter: "BMI Research - Industry Reports (EMIS)")
                    
                    guideNames.remove(at: bmi)
                    guideURLs.remove(at: bmi)
                    guideLogos.remove(at: bmi)
                    guideDescriptions.remove(at: bmi)
                    
                    //Remove GRDS Industry Reports (EMIS)
                    let grds = getIndex(arr: guideNames, filter: "GRDS Industry Reports (EMIS)")
                    
                    guideNames.remove(at: grds)
                    guideURLs.remove(at: grds)
                    guideLogos.remove(at: grds)
                    guideDescriptions.remove(at: grds)
                    
                    //Remove Prequin
                    let prequin = getIndex(arr: guideNames, filter: "Preqin")
                    
                    guideNames.remove(at: prequin)
                    guideURLs.remove(at: prequin)
                    guideLogos.remove(at: prequin)
                    guideDescriptions.remove(at: prequin)
                    
                    //Remove IPREO
                    let ipreo = getIndex(arr: guideNames, filter: "IPREO Bigdough")
                    
                    guideNames.remove(at: ipreo)
                    guideURLs.remove(at: ipreo)
                    guideLogos.remove(at: ipreo)
                    guideDescriptions.remove(at: ipreo)
                    
                    
                    DispatchQueue.main.sync {
                        self.data = guideNames
                        display(arr: guideNames)
                        print(guideNames.count)
                        print("---------------------")
                        self.urls = guideURLs
                        display(arr: guideURLs)
                        print(guideURLs.count)
                        print("---------------------")
                        self.logos = guideLogos
                        display(arr: guideLogos)
                        print(guideLogos.count)
                        print("---------------------")
                        self.descriptions = guideDescriptions
                        display(arr: guideDescriptions)
                        print(guideDescriptions.count)
                        self.tableView.reloadData()
                    }
                    
                    
                    
                    
                    //print(guideURLs)
                    //Figure out how to return guideName and guideURLs
                    
                    
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDetail") {
            let nav = segue.destination as! UINavigationController
            
            let dvc = nav.topViewController as! DetailViewController
            
            if let indexPath = tableView.indexPathForSelectedRow?.row {
                dvc.name = data[indexPath]
                dvc.urlString = urls[indexPath]
                dvc.logo = logos[indexPath]
                dvc.descriptionString = descriptions[indexPath]
            }
        } else {
        }
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToVC1", sender: nil)
    }
    
}

func getIndex(arr: [String], filter: String) -> Int {
    var i = 0
    
    var returnVal = 0
    
    for element in arr {
        if element == filter {
            returnVal = i
        }
        
        i += 1
    }
    
    return returnVal
}

func display(arr: [String]){
    for element in arr {
        print(element + "\n")
    }
}

extension String {
    func plainTextFromHTML() -> String? {
        let regexPattern = "<.*?>"
        do {
            let stripHTMLRegex = try NSRegularExpression(pattern: regexPattern, options: NSRegularExpression.Options.caseInsensitive)
            let plainText = stripHTMLRegex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, self.characters.count), withTemplate: "")
            return plainText
        } catch {
            print("Warning: failed to create regular expression from pattern: \(regexPattern)")
            return nil
        }
    }
}

