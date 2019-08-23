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

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    // 地図を紐付け
    @IBOutlet var mapView: MKMapView!

    //CLLocationManagerの入れ物を用意
    var myLocationManager:CLLocationManager!
    // ボタンのタイトルを指定
    //タップされた回数
    var tapped = 1
    //ロングタップしたときに立てるピンを定義
    var pinByLongPress: MKPointAnnotation!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        //CLLocationManagerをインスタンス化
        myLocationManager = CLLocationManager()
        //位置情報使用許可のリクエストを表示するメソッドの呼び出し
        myLocationManager.requestWhenInUseAuthorization()
        // 地図の初期化
        initMap()
    }
    
    @IBAction func longPressMap(_ sender: Any) {
        //ロングタップの最初の感知のみ受け取る
        if (sender as AnyObject).state != UIGestureRecognizer.State.began {
            return
        }
        //　ここから追加
        //インスタンス化
        pinByLongPress = MKPointAnnotation()
        //ロングタップから位置情報を取得
        let location:CGPoint = (sender as AnyObject).location(in: mapView)
        //取得した位置情報をCLLocationCoordinate2D（座標）に変換
        let longPressedCoordinate:CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)
        //ロングタップした位置の座標をピンに入力
        pinByLongPress.coordinate = longPressedCoordinate
        if tapped == 1 {
            pinByLongPress.title = "1つ目のピン"
        } else {
            pinByLongPress.title = "1つ目以外のピン"
        }
        tapped += 1
        //ピンを追加する（立てる）
        mapView.addAnnotation(pinByLongPress)
        /* ここまで追加 */
    }

    //位置情報取得に失敗したときに呼び出されるメソッド
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
