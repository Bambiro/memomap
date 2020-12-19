//
//  MapViewController.swift
//  memomap
//
//  Created by 水谷彩葉 on 2020/11/27.
//  Copyright © 2020 Mizutani Mozuku. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
        var pointAno = MKPointAnnotation()
        var locationManager: CLLocationManager!
        var genre = "タイトル"
        var subTitle = "サブタイトル"
        
    override func viewDidLoad() {
            super.viewDidLoad()

            //ロケーションマネージャーのセットアップ
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()

            //mapViewDelegate
            mapView.delegate = self

            //中心点の設定
            mapView.setCenter(mapView.userLocation.coordinate, animated: true)

            //縮尺の設計
            let mySpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let myRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: mySpan)

            //regionの追加
            mapView.region = myRegion

            //現在地追従
            mapView.userTrackingMode = MKUserTrackingMode.follow

            //viewに表示
            self.view.addSubview(mapView)

            //長押し機能
            let myLongPress: UILongPressGestureRecognizer =  UILongPressGestureRecognizer()
                myLongPress.addTarget(self, action: #selector(MapViewController.recognizeLongPress(sender:)))

            //myMapに長押し機能を追加
            mapView.addGestureRecognizer(myLongPress)



            }
    
    
    @objc func recognizeLongPress(sender: UILongPressGestureRecognizer) {

                // 長押しの最中に何度もピンを生成しないようにする.
                if sender.state != UIGestureRecognizer.State.began {
                    return
                }

                // 長押しした地点の座標を取得.
                let location = sender.location(in: mapView)

                // locationをCLLocationCoordinate2Dに変換.
                let myCoordinate: CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)

                // ピンを生成.
                let myPin: MKPointAnnotation = MKPointAnnotation()

                // 座標を設定.
                myPin.coordinate = myCoordinate

                // タイトルを設定.
                myPin.title = genre

                // サブタイトルを設定.
                myPin.subtitle = subTitle

                // MapViewにピンを追加.
                mapView.addAnnotation(myPin)
            }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

            let myPinIdentifier = "PinAnnotationIdentifier"
            //ピンの生成
            let myPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: myPinIdentifier)

            //ピンの登場時のアニメーション
            myPinView.animatesDrop = true

            //コールアウト(吹き出し)の表示
            myPinView.canShowCallout = true

            //annnotationの設定
            myPinView.annotation = annotation

            let btn = UIButton(type: .detailDisclosure)

            btn.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControl.Event.touchUpInside)
            myPinView.rightCalloutAccessoryView = btn
        
        return myPinView
            }

            func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
                switch status {
                //許可されていない場合
                case .notDetermined:
                    //許可を求める
                    manager.requestWhenInUseAuthorization()
                //拒否されている場合
                case .denied, .restricted:
                    break
                //許可されている場合
                case .authorizedAlways, .authorizedWhenInUse:
                    manager.startUpdatingLocation()
                    break

                default:
                    break
                }
            }

    @objc func buttonEvent(_ sender: UIButton) {
            self.performSegue(withIdentifier: "next", sender: nil)
        }
    
            
    

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


