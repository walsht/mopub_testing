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
import MoPubAdapter

class ViewController: UIViewController, GADBannerViewDelegate {

    override func viewDidLoad() {
    super.viewDidLoad()
    print("\n\nGoogle Mobile Ads SDK version: \(GADRequest.sdkVersion()) - 'GoogleMobileAdsMediationMoPub', '4.16.0'\n\n")
//        setUpBanner(banner: bannerView)
//        setUpBanner(banner: bannerViewBig)
        var validAdSizes = [CGSize]()
        validAdSizes.append(CGSize(width: 300.0, height: 250.0))
        validAdSizes.append(CGSize(width: 320.0, height: 50.0))
        let tempBannerView = DFPBannerView(adSize: GADAdSizeFromCGSize(validAdSizes.first!))
        tempBannerView.validAdSizes = validAdSizes.map { NSValueFromGADAdSize(GADAdSizeFromCGSize($0)) }
        view.addSubview(tempBannerView)
        tempBannerView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 9.0, *) {
            tempBannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            tempBannerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        setUpBanner(banner: tempBannerView)
  }

    func setUpBanner(banner: GADBannerView){
        
        banner.adUnitID = "/8264/appaw-tvguide/listings"
        banner.rootViewController = self
        banner.delegate = self
        let request = DFPRequest()
        var targeting = [AnyHashable : Any]()
        targeting["env"] = "production"
        targeting["pname"] = "sports"
        targeting["pos"] = "1"
        targeting["provider"] = "Broadcast"
        targeting["ptype"] = "sports"
        targeting["session"] = "a"
        targeting["subses"] = "4"
        targeting["vguid"] = "98ae572e-2afb-4888-ab4a-df18b715733a"
        request.customTargeting = targeting
        
        let moPubExtras = GADMoPubNetworkExtras()
        moPubExtras.privacyIconSize = 20
        request.register(moPubExtras)
        
        banner.load(request)
    }
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("GADBanner - adViewDidReceiveAd = \(bannerView)")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("GADBanner - adView:didFailToReceiveAdWithError:\(bannerView) - \(error.localizedDescription)")
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
