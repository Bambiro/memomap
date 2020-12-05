//
//  PreserveViewController.swift
//  memomap
//
//  Created by 水谷彩葉 on 2020/11/27.
//  Copyright © 2020 Mizutani Mozuku. All rights reserved.
//

import UIKit

class PreserveViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var textField: UITextField!
    var pickerView = UIPickerView()
    var data = ["飲食店","観光地","お店","その他"]
    
    
    @IBOutlet weak var preservebutton: UIButton!
    
    @IBAction func mymapbutton(){
    }
    @IBAction func sharemap(){
    }

    
    let innsyokuArray: [String] = ["和食","洋食","中華","イタリアン","フレンチ","パン・サンドイッチ","弁当","焼肉","カレー","カフェ・スイーツ"]
    let kannkoutiArray: [String] =  ["歴史・文化","アウトドア","景観","宿泊","温泉","公園"]
    let omiseArray: [String] =  ["コンビニ","スーパー","ドラッグストア","書店","銀行","カラオケ","雑貨屋"]
    let sonotaArray: [String] =  ["駅・バス停","駐車場","その他"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //角丸
        preservebutton.layer.cornerRadius = 40.0
        
        createPickerView()
        
        // Do any additional setup after loading the view.
    }
    

    
    func createPickerView() {
        pickerView.delegate = self
        textField.inputView = pickerView
        //toolbar
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0,y: 0,width: self.view.frame.width,height: 44)
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ViewController.donePicker))
        toolbar.setItems([doneButtonItem], animated: true)
        textField.inputAccessoryView = toolbar
        
    }
    
    @objc func donePicker(){
        textField.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView,titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        textField.text = data[row]
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
