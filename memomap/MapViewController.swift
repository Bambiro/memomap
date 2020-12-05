//
//  MapViewController.swift
//  memomap
//
//  Created by 水谷彩葉 on 2020/11/27.
//  Copyright © 2020 Mizutani Mozuku. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    var pointAno: MKPointAnnotation = MKPointAnnotation()
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //ロケーションマネージャーのセットアップ
        locationManager = CLLocationMAnager()
        locationManager.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        
        //デリゲートを設定
        mapView.delegate = self
        
        //経度、緯度を生成.
        let myLatitude: CLLOcationDegress = 37.331714
        let myLongitude: CLLOcationDegress = -122.030333
        
        //MapViewに中心点を設定
        mapView.setcenter
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
