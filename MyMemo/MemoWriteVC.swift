//
//  MemoWriteVC.swift
//  MyMemo
//
//  Created by 한규철 on 9/22/R4.
//

import UIKit

protocol MemoWriteVCDelegate: AnyObject {
    func updateMemo()
}

class MemoWriteVC : UIViewController, UINavigationControllerDelegate, UITextViewDelegate {
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var writeTitle: UITextField!
    
    var subject : String!
    
    var memo: MemoData?
    
    weak var delegate: MemoWriteVCDelegate?
    
    override func viewDidLoad() {
        self.setUI()
    }
    
    func setUI() {
        self.detailTextView.delegate = self
        
       if let memo = memo {
            // 메모가 있을 때
           self.saveBtn.setTitle("수정", for: .normal)
           self.writeTitle.text = memo.title
           self.detailTextView.text = memo.contents
        } else {
            // 메모가 없을 때
            self.saveBtn.setTitle("저장", for: .normal)
            
        }
    }
    
    //save 버튼 클릭시 호출
    @IBAction func saveButton(sender: UIButton) {
       
        //내용이 없을시 경고창
        guard self.detailTextView.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            self.present(alert, animated: true)
            return
        }
        if let memo = memo {
            // 메모가 있을 때
            //제목
            memo.title = self.writeTitle.text
            //내용
            memo.contents = self.detailTextView.text
            let success = DBManager.shared.updateMemo(memo: memo)
            var message = ""
            var action: UIAlertAction?
            if success {
                message = "메모 수정에 성공하였습니다."
                action = UIAlertAction(title: "OK", style: .default)
            } else {
                message = "메모 수정에 실패하였습니다."
                action = UIAlertAction(title: "OK", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
            }
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(action!)
            self.present(alert, animated: true)
            
         } else {
             // 메모가 없을 때
             //memoData 객체 생성후 데이터 담기
             let data = MemoData()
             //제목
             data.title = self.writeTitle.text
             //내용
             data.contents = self.detailTextView.text
             
             DBManager.shared.insertMemo(memo: data)
             
             //글작성 화면을 종료하고 memoList로 돌아간다
             //popViewController - 탐색 스택에서 상위뷰컨트롤러를 팝하고 디스플레이를 업데이트
             self.navigationController?.popViewController(animated: true)
         }
        
    }
    
    //사용자가 텍스트뷰에 뭔가 입력하면 호출되는 메소드
    func textViewDidChange(_ textView: UITextView) {
        //내용에 최대 15자리까지 읽어 mememoTilte 변수에 저장
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
    
    }
}
