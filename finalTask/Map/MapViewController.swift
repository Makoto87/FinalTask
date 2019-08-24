//
//  MapViewController.swift
//  finalTask
//
//  Created by VERTEX20 on 2019/08/19.
//  Copyright © 2019 VERTEX20. All rights reserved.
//

import UIKit
import CoreLocation     // 地図に必要なキット
import MapKit           // 地図に必要

// クラスを追加
class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIPopoverControllerDelegate {

    // 地図を紐付け
    @IBOutlet var mapView: MKMapView!

    //CLLocationManagerの入れ物を用意
    var myLocationManager:CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        //CLLocationManagerをインスタンス化
        myLocationManager = CLLocationManager()
        //位置情報使用許可のリクエストを表示するメソッドの呼び出し
        myLocationManager.requestWhenInUseAuthorization()
        // 地図の初期化
        initMap()

        // ピンをはじめから設置しておくためのもの
        // 座標を緯線経線0にする
        let testLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.710063, 139.8107)
        //インスタンス化
        let pinAnnotation = MKPointAnnotation()
        //ピンを置く場所の座標を設定
        pinAnnotation.coordinate  = testLocation
        //ピンのタイトルの設定
        pinAnnotation.title       = "test"
        //ピンのサブタイトルを設定
        pinAnnotation.subtitle    = "test subtitle"
        //ピンを地図上に追加
        mapView.addAnnotation(pinAnnotation)

        // 緯度
        let myLatDist: CLLocationDistance = 100
        // 軽度
        let myLonDist: CLLocationDistance = 100

        // Regionを作成.
        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: testLocation, latitudinalMeters: myLatDist, longitudinalMeters: myLonDist)
        // MapViewに反映.
        mapView.setRegion(myRegion, animated: true)
    }

    // ピンの詳細情報を得るために書いた情報
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        // Identifier
        let myAnnotationIdentifier = "myAnnotation"

        // AnnotationViewをdequeue
        var myAnnotationView : MKAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: myAnnotationIdentifier)

        //アノテーションの右側につけるボタンの宣言
        let button: UIButton = UIButton(type: UIButton.ButtonType.infoLight)

        if myAnnotationView == nil {
            myAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: myAnnotationIdentifier)
            //アノテーションの右側にボタンを付ける
            myAnnotationView.rightCalloutAccessoryView = button
            myAnnotationView.canShowCallout = true
        }
        return myAnnotationView
    }

    // ボタンを押された時のメソッド
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        //アノテーションを消す
        if let annotation = view.annotation {
            mapView.deselectAnnotation(annotation, animated: true)
        }

        //ストーリーボードの名前を指定（何も変更ない状態であれば「Main」だと思う）
        let storyboard = UIStoryboard(name: "MapStoryboard", bundle: nil)
        //viewにつけた名前を指定
        let vc = storyboard.instantiateViewController(withIdentifier: "locationDetail")
        //popoverを指定する
        vc.modalPresentationStyle = UIModalPresentationStyle.popover

        present(vc, animated: true, completion: nil)

        let popoverPresentationController = vc.popoverPresentationController
        popoverPresentationController?.sourceView = view
        popoverPresentationController?.sourceRect = view.bounds

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 位置情報取得に失敗したときに呼び出されるメソッド
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }

    func initMap() {
        // 縮尺を設定
        var region:MKCoordinateRegion = mapView.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mapView.setRegion(region,animated:true)
        // 現在位置表示の有効化
        mapView.showsUserLocation = true
        // 現在位置設定（デバイスの動きとしてこの時の一回だけ中心位置が現在位置で更新される）
        mapView.userTrackingMode = .follow
    }
    func updateCurrentPos(_ coordinate:CLLocationCoordinate2D) {
        var region:MKCoordinateRegion = mapView.region
        region.center = coordinate
        mapView.setRegion(region,animated:true)
    }
    // CLLocationManagerのdelegate：現在位置取得
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        updateCurrentPos((locations.last?.coordinate)!)
    }


}
