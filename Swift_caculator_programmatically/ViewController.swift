//
//  ViewController.swift
//  Swift_caculator_programmatically
//
//  Created by ユオン タイン on 2021/12/04.
//

import UIKit

extension UIView{
    @objc func blink() {
         self.alpha = 0.2
         UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
     }
}



class Caculator {
    var print_str:String = ""
    
    var number1_str:String = ""
    var number2_str:String = ""
    
    var number1:CGFloat = 0.0
    var number2:CGFloat = 0.0
    var name: String?
    
    enum type {
        case number
        case plus
        case sub
        case mul
        case div
        case equal
        case AC
        case None
    }
    
    var TYPE_CAL_NOW = type.None
    
    func plus(a:CGFloat, b:CGFloat) -> CGFloat{
        return a + b
    }
    func sub(a:CGFloat, b:CGFloat) -> CGFloat{
        return a - b
    }
    func mul(a:CGFloat, b:CGFloat) -> CGFloat{
        return a * b
    }
    func div(a:CGFloat, b:CGFloat) -> CGFloat{
        return a / b
    }
    func forTrailingZero(temp: Double) -> String {
        let tempVar = String(format: "%g", temp)
        return tempVar
    }
    
    func check_input_string(input_str:String){
        let check_type = check_input_string_type(input_str:input_str)
        
        
        if(check_type==type.AC){
            number1_str = String(number1_str.dropLast())
            print_str = number1_str
        }
        else if(check_type == type.number){
            number1_str+=input_str
            print_str = number1_str
        }
        else if(TYPE_CAL_NOW != type.None){
            
            print("number1_str ", number1_str)
            
            
            //cong lai
            number2 = CGFloat((number2_str as NSString).doubleValue)
            number1 = CGFloat((number1_str as NSString).doubleValue)
            
            
            if(TYPE_CAL_NOW==type.plus){
                let result = plus(a: number2, b: number1)
                print_str = forTrailingZero(temp:Double(result))
            }
            else if(TYPE_CAL_NOW==type.sub){
                let result = sub(a: number2, b: number1)
                print_str = forTrailingZero(temp:Double(result))
            }
            else if(TYPE_CAL_NOW==type.mul){
                let result = mul(a: number2, b: number1)
                print_str = forTrailingZero(temp:Double(result))
            }
            else if(TYPE_CAL_NOW==type.div){
                let result = div(a: number2, b: number1)
                print_str = forTrailingZero(temp:Double(result))
            }
            else if(TYPE_CAL_NOW==type.equal){
                //do no thing
            }
                                    
            //save result
            number2_str = print_str
            TYPE_CAL_NOW = check_type
            number1_str = ""
        }
        else {
            number2_str = number1_str
            number1_str = ""
            
            TYPE_CAL_NOW = check_type
            print("first ", TYPE_CAL_NOW)
        }
        
        print(TYPE_CAL_NOW)
        print("number1_str ", number1_str)
        print("number2_str ", number2_str)
        
        
    }
    
    func check_input_string_type(input_str:String) -> type {
        if(input_str=="+") {
            return .plus
        }
        if(input_str=="-") {
            return .sub
        }
        if(input_str=="x") {
            return .mul
        }
        if(input_str=="÷") {
            return .div
        }
        if(input_str=="=") {
            return .equal
        }
        if(input_str == "AC") {
            return .AC
        }
        if( (input_str != "%") && (input_str != "%") ){
            return .number
        }
        
        return .equal
        
    }
    
    
}



class ViewController: UIViewController {
    
    var CAL = Caculator()
    
    var lbl_show: UILabel!
    
    let number_text = [
        "0", "0", ".", "=", // 0 0 1 2
        "1",  "2",  "3",  "+", // 3 4 5 6
        "4",  "5",  "6",  "-", // 7 8 9 10
        "7",  "8",  "9",  "x", // 11 12 13 14
        "AC",  "+/-",  "%", "÷", "0"] // 15 16 17 18
    
    var allButtons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .black
        
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        let bottomPadding = window.safeAreaInsets.bottom
        
        print("window = ", topPadding)
        print("bottomPadding = ", bottomPadding)
                
        let hang_length = view.frame.width/4
        let cot_length = hang_length //view.frame.height/6
        
        
        for cot in 0...4{
            for hang in 0...3{
                let color:UIColor = .black //color_random()


                let x = CGFloat(CGFloat(hang-0)*hang_length)
                let y = view.frame.height - cot_length - bottomPadding - CGFloat(CGFloat(cot-0)*hang_length)
                let width = CGFloat(hang_length)
                let height = CGFloat(cot_length)

                let tich = (cot*4) + hang
                
                if(tich==0){
                    createView(number:tich, view_input:view, background_color:color, x:x, y:y, width:width*2, height:height)
                }
                else if(tich>1){
                    createView(number:tich, view_input:view, background_color:color, x:x, y:y, width:width, height:height)
                }
            }
        }
        
        
        //add last label
        lbl_show = UILabel(frame: CGRect(x: 0, y: view.frame.height - bottomPadding - cot_length*6, width: view.frame.width, height: cot_length))
        lbl_show.backgroundColor = .black
        view.addSubview(lbl_show)
        lbl_show.font = UIFont(name: "Helvetica", size: 60)
        lbl_show.textColor = .white
        lbl_show.textAlignment = .right
        
        lbl_show.contentMode = .scaleToFill
        lbl_show.numberOfLines = 0
        lbl_show.lineBreakMode = .byWordWrapping
    }
    
    @objc func blink1(button:UIButton) {
        UIView.animate(withDuration: 0.01) {
            button.alpha  = 0.3
        }
     }
    @objc func blink2(button:UIButton) {
        UIView.animate(withDuration: 0.05) {
            button.alpha  = 1
        }
        
        let number = Int(button.tag)
        let text = number_text[number]
        
        //tinh toan
        CAL.check_input_string(input_str: text)
        lbl_show.text = String(CAL.print_str)
        
        
        if(CAL.number1_str != ""){
            allButtons[15].setTitle("C", for: .normal)
        }
        else{
            allButtons[15].setTitle("AC", for: .normal)
        }
     }
    
    
    func add_center_view(number:Int, view_input:UIView){
        
        let width_intput = view_input.frame.width
        let height_intput = view_input.frame.height
        
        var width = width_intput*0.8
        var height = height_intput*0.8
        
        var x = width_intput*0.1
        var y = height_intput*0.1
        
        if(number==0){
            width = width_intput*0.9
            height = height_intput*0.8
            
            x = width_intput*0.05
            y = height_intput*0.1
        }

        
//        print("center ", x, " ", y, " ", width, " ", height)
                
        let new_center_view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        
        new_center_view.backgroundColor = .systemGray6
        new_center_view.layer.cornerRadius = CGFloat(height/2)
        
        
        
        
        //BUTTON
        let new_button = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: height))
        new_button.layer.cornerRadius = CGFloat(height/2)
        
        //gan text tuong ung voi tung button
        new_button.setTitle(number_text[number], for: UIControl.State.normal)
        new_button.titleLabel?.font = UIFont(name: "Helvetica", size: 45)
               
        new_button.contentHorizontalAlignment = .center
        new_button.contentVerticalAlignment = .center
                
        
        if(number%4==3){
            new_button.backgroundColor = .orange
        }
        else if(number<16){
            new_center_view.backgroundColor = .gray
            new_button.backgroundColor = .darkGray
        }
        else {
            new_button.backgroundColor = .systemGray2
            new_button.titleLabel?.font = UIFont(name: "Helvetica", size: 35)
            new_button.setTitleColor(.black, for: .normal)
        }
        
        
        new_button.tag = number
        new_button.addTarget(self,
                         action: #selector(blink1),
                         for: .touchDown)
        new_button.addTarget(self,
                         action: #selector(blink2),
                         for: .touchUpInside)
                
        allButtons.append(new_button)
        new_center_view.addSubview(new_button)
        
        view_input.addSubview(new_center_view)
        
    }
    
    
    func createView(number:Int, view_input:UIView, background_color:UIColor, x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat){
        let new_view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        
        new_view.backgroundColor = background_color
        
//        print("newview ", x, " ", y, " ", width, " ", height)
        add_center_view(number:number, view_input: new_view)
        
        view.addSubview(new_view)
    }
    
    
    func color_random() -> UIColor {
       let color_random_result = UIColor(displayP3Red: CGFloat(Double.random(in: 0.0...1.0)), green: CGFloat(Double.random(in: 0.0...1.0)), blue: CGFloat(Double.random(in: 0.0...1.0)), alpha: CGFloat(1))
       return color_random_result
   }
    

}

