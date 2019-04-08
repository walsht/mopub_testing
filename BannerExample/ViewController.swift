//
//  Copyright (C) 2015 Google, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import GoogleMobileAds
import UIKit
import MoPub
import MoPubAdapter

class ViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var detail: UILabel!
    var totalRequest = 0
    var failedRequest = 0
    var successRequest = 0
    var dfpBannerView: DFPBannerView = {
        var validAdSizes = [CGSize]()
//        validAdSizes.append(CGSize(width: 300.0, height: 250.0))
        validAdSizes.append(CGSize(width: 320.0, height: 50.0))
//        validAdSizes.append(CGSize(width: 480.0, height: 32.0))
//        validAdSizes.append(CGSize(width: 728.0, height: 90.0))
//        validAdSizes.append(CGSize(width: 1024.0, height: 66.0))
//        validAdSizes.append(CGSize(width: 1024.0, height: 90.0))
        
        let dfpBannerView = DFPBannerView(adSize: GADAdSizeFromCGSize(validAdSizes.first!))
        dfpBannerView.validAdSizes = validAdSizes.map { NSValueFromGADAdSize(GADAdSizeFromCGSize($0)) }
        return dfpBannerView
    }()
    
    override func viewDidLoad() {
    super.viewDidLoad()
        print("\n\nGoogle Mobile Ads SDK version: \(GADRequest.sdkVersion()) - 'GoogleMobileAdsMediationMoPub', \(MoPub.sharedInstance().version())\n\n")
        view.addSubview(dfpBannerView)
        dfpBannerView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 9.0, *) {
            dfpBannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            dfpBannerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        
        setUpBanner(banner: dfpBannerView)
  }

    func setUpBanner(banner: DFPBannerView){
        
        banner.adUnitID = "/8264/appaw-tvguide/listings"
//        banner.adUnitID = "/8264/appaw-cbssports/hockey"
        banner.rootViewController = self
        banner.delegate = self
        let request = DFPRequest()
//        var targeting = [AnyHashable : Any]()
////        targeting["env"] = "production"
////        targeting["pname"] = "sports"
////        targeting["pos"] = "1"
////        targeting["provider"] = "Broadcast"
////        targeting["ptype"] = "sports"
////        targeting["session"] = "a"
////        targeting["subses"] = "4"
////        targeting["vguid"] = "98ae572e-2afb-4888-ab4a-df18b715733a"
//        request.customTargeting = targeting
        
//        let moPubExtras = GADMoPubNetworkExtras()
//        moPubExtras.privacyIconSize = 20
//        request.register(moPubExtras)
        dfpBannerView.alpha = 0.0
        setDetail()
        banner.load(request)
    }
    
    func setDetail(){
        detail.text = "Success(\(successRequest))\nFailed(\(failedRequest))\nTotal(\(totalRequest))"
    }
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        totalRequest = totalRequest + 1
        successRequest = successRequest + 1
        dfpBannerView.alpha = 1.0
        view.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        print("\n ***** GADBanner - Success(\(successRequest)) Failed(\(failedRequest)) Total(\(totalRequest)): SUCCESS = \(bannerView) - \(dfpBannerView)\n")
        setDetail()
    }
    
    @IBAction func refresh(_ sender: Any) {
        setUpBanner(banner: dfpBannerView)
    }
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        totalRequest = totalRequest + 1
        failedRequest = failedRequest + 1
        dfpBannerView.alpha = 0.0
        view.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        print("\n ***** GADBanner - Success(\(successRequest)) Failed(\(failedRequest)) Total(\(totalRequest)): FAILED = \(bannerView) - \(dfpBannerView) - \(error.localizedDescription)\n")
        setDetail()
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("GADBanner - adViewWillPresentScreen = \(bannerView)")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("GADBanner - adViewWillDismissScreen = \(bannerView)")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("GADBanner - adViewDidDismissScreen = \(bannerView)")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("GADBanner - adViewWillLeaveApplication = \(bannerView)")
    }
}
