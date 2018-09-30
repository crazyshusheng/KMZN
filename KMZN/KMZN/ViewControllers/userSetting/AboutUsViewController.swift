//
//  AboutUsViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/9/10.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class AboutUsViewController: ThemeViewController {

    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension AboutUsViewController{
    
    func  setupUI(){
        
        
        let detailStr = "        赫高（酷米智能科技股份有限公司）旗下品牌。专业从事智能终端产品研发、设计、生产、销售及服务于一体的高科技企业。公司拥有国内外研发创新团队，致力为中国高端家庭提供智能家居安全解决方案与服务。\n        赫高秉承着“品质成就品牌 品牌创造价值”的经营理念。不断提升品牌的知名度和美誉度，首创无线充电智能门锁，为每一位消费者提供舒适，便捷，安全的高品质生活。并与中国移动达成长期战略合作关系。"
        let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: detailStr)
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7//行间距大小调整
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, detailStr.count))
        
        detailLabel.attributedText = attributedString
    }
    
    
}
