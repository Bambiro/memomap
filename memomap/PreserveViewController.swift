//
//  PreserveViewController.swift
//  memomap
//
//  Created by 水谷彩葉 on 2020/11/27.
//  Copyright © 2020 Mizutani Mozuku. All rights reserved.
//

import UIKit

class PreserveViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    var data1 = ["飲食店","観光地","お店","その他"]
    var data2 = ["和食","洋食","中華","イタリアン","フレンチ","パン・サンドイッチ","弁当","焼肉","カレー","カフェ・スイーツ","その他"]
    var data3 = ["歴史・文化","アウトドア","景観","宿泊","温泉","公園","その他"]
    var data4 = ["コンビニ","スーパー","ドラッグストア","書店","銀行","カラオケ","その他"]
    var data5 = ["駐車場","その他"]
    var word1 = String()
    var word2 = String()
    
    let image0 = UIImage(named: "mymap0.png")!
    let image1 = UIImage(named: "mymap.png")!
    let image2 = UIImage(named: "sharemap0.png")!
    let image3 = UIImage(named: "sharemap.png")!
    
   
    
    @IBOutlet weak var mymapbutton: UIButton!
    @IBOutlet weak var sharemapbutton: UIButton!
    
    @IBAction func mymapButtonTapped(_ sender: Any){
        if mymapbutton.imageView?.image == image0 {
            mymapbutton.setImage(image1, for: .normal)
        }else if mymapbutton.imageView?.image == image1{
            mymapbutton.setImage(image0, for: .normal)
        }
    }
    
    @IBAction func sharemapButtonTapped(_ sender: Any){
        if sharemapbutton.imageView?.image == image2{
            sharemapbutton.setImage(image3, for: .normal)
        }else if sharemapbutton.imageView?.image == image3{
            sharemapbutton.setImage(image2, for: .normal)
        }
    }

    @IBOutlet weak var preservebutton: UIButton!
    @IBOutlet weak var delatebutton: UIButton!
    
    @IBAction func preserveButtonTapped() {
                // mapViewControllerの取得
        if let mapVC = presentingViewController as? MapViewController{
            //MapViewControllerのgenreにtextfieldの値を代入
            mapVC.genre = textField3.text!
            print(textField3.text)
            print(mapVC.genre)
            
            //MapViewControllerのsubtitleにtextfieldの値を代入
            mapVC.subTitle = textField4.text!
            print(textField4.text)
            print(mapVC.subTitle)
            
            //MapViewControllerのpinBoolにtureを代入
            mapVC.pinBool = true
            
        }
                
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func delateBuuttonTapped() {
            // mapViewControllerの取得
        if let mapVC = presentingViewController as? MapViewController{
            //ピンを削除
            mapVC.mapView.removeAnnotation(mapVC.myPin)
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPickerView()
        
        //画像を設定
        mymapbutton.setImage(image0, for: .normal)
        sharemapbutton.setImage(image2, for: .normal)
        
        
        //角丸
        preservebutton.layer.cornerRadius = 25.0
        delatebutton.layer.cornerRadius = 25.0
    
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func keyboardWillShow(notifiction :NSNotification){
    if let keyboardSize = (notifiction.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
        //キーボードの高さを分Viewを上に移動する
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardSize.height
        }else {
            let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
            self.view.frame.origin.y -= suggestionHeight
        }
    }
}

        //Viewの位置を戻す
    @objc func keyboardWillHide(){
    if self.view.frame.origin.y != 0{
        self.view.frame.origin.y = 0
        }
    }

    @objc func dissmissKeyboard(){
       self.view.endEditing(true)
    }
    
    
    func textEnabled(){
            //TextField1,TextField2のどちらかが空のときの処理
                textField3.isEnabled == false //TextField3の編集を無効にする
                textField4.isEnabled == false //TextField4の編集を無効にする
            if textField1.text != "" && textField2.text != ""{
                //TextField1,TextField2のどちらも値が入っているときの処理
                textField3.isEnabled == true //TextField3の編集を有効にする
                textField4.isEnabled == true //TextField4の編集を有効にする
           }
    }
    
    
    func createPickerView() {
        
        //PickerView1
        pickerView1.delegate = self
        textField1.inputView = pickerView1
        
        //PickerView2
        pickerView2.delegate = self
        textField2.inputView = pickerView2
        
        //toolbar1
        let toolbar1 = UIToolbar()
        toolbar1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        let doneButtonItem1 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PreserveViewController.doneButton1))
        toolbar1.setItems([doneButtonItem1], animated: true)
        textField1.inputAccessoryView = toolbar1
        
        // toolbar2
        let toolbar2 = UIToolbar()
        toolbar2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        let doneButtonItem2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PreserveViewController.doneButton2))
        toolbar2.setItems([doneButtonItem2], animated: true)
        textField2.inputAccessoryView = toolbar2
    
    }
    
    
    @objc func doneButton1(){
        textField1.endEditing(true)
        textField1.text = word1
        textField2.text = ""
    }
    
    
    @objc func doneButton2() {
        textField2.endEditing(true)
        textField2.text = word2
        }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField1.endEditing(true)
        textField2.endEditing(true)
        textField3.endEditing(true)
        textField4.endEditing(true)
                //テキスト入力画面の外側をタップしたら編集が終了
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        //1画面に対するクルクル(PickerView)の数
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //候補の数
                if pickerView == pickerView1{
                    return data1.count
                }else {
                    if textField1.text == data1[0]{
                        return data2.count

                    }else if textField1.text == data1[1]{
                        return data3.count
                        
                    }else if textField1.text == data1[2]{
                        return data4.count

                    }else{
                        return data5.count
                    }
                }
            }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView == pickerView1{
                return data1[row]
            }else {
                if textField1.text == data1[0]{
                    return data2[row]
                }else if textField1.text == data1[1]{
                    return data3[row]
                }else if textField1.text == data1[2]{
                    return data4[row]
                }else if textField1.text == data1[3]{
                    return data5[row]
                }else{
                    return ""
                }
            }
        }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

            if textField1.text == "" {
                word1 = data1[row]
            }

            if textField1.text != "" && textField2.text == ""{
                if textField1.text == data1[0]{
                 word2 = data2[row]
                }else if textField1.text == data1[1]{
                    word2 = data3[row]
                }else if textField1.text == data1[2]{
                    word2 = data4[row]
                }else if textField1.text == data1[3]{
                    word2 = data5[row]
                }else{

                }
            }
        
             if textField1.text != "" && textField2.text != ""{
                 if pickerView == pickerView1{
                  word1 = data1[row]
                }else{
                        if textField1.text == data1[0]{
                            word2 = data2[row]
                        }else if textField1.text == data1[1]{
                            word2 = data3[row]
                        }else if textField1.text == data1[2]{
                            word2 =  data4[row]
                        }else if textField1.text == data1[3]{
                            word2 =  data5[row]
                        }else{

                        }
                    }
                }

            }
    }
    
    
    
    


