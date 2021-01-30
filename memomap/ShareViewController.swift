//
//  ShareViewController.swift
//  memomap
//
//  Created by 水谷彩葉 on 2021/01/17.
//  Copyright © 2021 Mizutani Mozuku. All rights reserved.
//

import Foundation

var latitude = Double()
var longitude = Double()

func shareMap(){
        let address = String(format: "%f,%f", latitude, longitude)

        let urlString = "http://maps.apple.com/?address=\(address)"
        //マップの種類の変更可(&t = m or k or h or r)

        let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        let url = NSURL(string: encodedUrl)!

        UIApplication.shared.open(url as URL, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: true], completionHandler: nil)

        //UIApplication.shared.open(URL(string: encodedUrl)!, options: [:], completionHandler: nil)
        print(latitude)
        print(longitude)
        print(urlString)

        //ここからシェア内容
        let shareText = "ここがすごい！"
        let shareWebsite = url
        //let shareImage = UIImage(named: "ムック5.png")!

        let activityItems = [shareText, shareWebsite] as [Any]
        //shareImageの追加も可

        // 初期化処理
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)


        // UIActivityViewControllerを表示
        self.present(activityVC, animated: true, completion: nil)

    }
