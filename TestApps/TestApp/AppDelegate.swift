/*
 Copyright 2022 Adobe. All rights reserved.
 This file is licensed to you under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License. You may obtain a copy
 of the License at http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software distributed under
 the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
 OF ANY KIND, either express or implied. See the License for the specific language
 governing permissions and limitations under the License.
 */

import AEPCore
import AEPEdge
import AEPEdgeIdentity
import AEPEdgeMedia
import AEPServices
import UIKit

// MARK: TODO remove this once Assurance has tvOS support.
#if os(iOS)
import AEPAssurance
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // TODO: Set up the preferred Environment File ID from your mobile property configured in Data Collection UI
    private let ENVIRONMENT_FILE_ID = ""

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        MobileCore.setLogLevel(.trace)
        var extensions: [NSObject.Type] = [Media.self]

        // MARK: TODO remove this once Assurance has tvOS support.
        #if os(iOS)
        extensions.append(contentsOf: [Edge.self, AEPEdgeIdentity.Identity.self, Assurance.self])
        #endif

//        MobileCore.registerExtensions(extensions, {
//            MobileCore.configureWith(appId: self.ENVIRONMENT_FILE_ID)
//        })
        
        MobileCore.registerExtensions(extensions, {
              MobileCore.configureWith(appId: self.ENVIRONMENT_FILE_ID)
              // E2E testing (adobe-decebalus)
              MobileCore.updateConfigurationWith(configDict: ["edgemedia.channel": "test-channel", "edgemedia.playerName": "testPlayerName",
                                      "edge.configId": "05d4a30a-f0b5-4452-b7a0-3bafefd691c0",
                                      "experienceCloud.org": "6D9FE18C5536A5E90A4C98A6@AdobeOrg",
                                      "edge.domain": "edge.adobedc.net"])
              //      MobileCore.updateConfigurationWith(configDict: ["edgemedia.channel": "channel", "edgemedia.playerName": "testPlayerName",
              //                              "edge.configId": "97a2598a-eed9-497b-808f-2bbda159c7c4",
              //                              "experienceCloud.org": "4E9432245BC7C44B0A494037@AdobeOrg",
              //                              "edge.domain": "beta.adobedc.net"])
            })

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // To handle deeplink on iOS versions 12 and below
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        #if os(iOS)
        Assurance.startSession(url: url)
        #endif
        return true
    }
}
