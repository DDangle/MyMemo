//
//  MemoCell.swift
//  MyMemo
//
//  Created by 한규철 on 9/22/R4.
//

import UIKit

protocol MemoCellDelegate: AnyObject {
    func deleteBtnClicked(memo: MemoData?)
}

class MemoCell : UITableViewCell {
    @IBOutlet weak var mymemoTitle: UILabel!
    @IBOutlet weak var mymemoContents: UILabel!
    
    var memo: MemoData?
    weak var delegate: MemoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    func setUI() {
        
    }
    
    func setData(memo: MemoData) {
        self.memo = memo
        self.mymemoTitle.text = memo.title
        self.mymemoContents.text = memo.contents
    }
    
    @IBAction func deleteBtnClicked(_ sender: UIButton) {
        self.delegate?.deleteBtnClicked(memo: memo)
    }
    
}
