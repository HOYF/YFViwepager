# YFViwepager
用法简单的图片轮播器框架：传入图片url或者本地图片名称，直接自行滚动

轮播中的图片，如果是网络图片，则点击轮播中的图片，push到对应图片的url详情页面，如果是本地图片则不能点击

几行代码设置即可使用：
   YFViwepager *viwepager = [YFViwepager viwepagerWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    //协议关联
    viwepager.delegate = self;
    //图片类型：YES为网络图片，NO为本地图片
    viwepager.imageType = YES;
    if (viwepager.imageType == YES) {
        viwepager.imageNames = @[@"url1",
                                 @"url2,
                                 @"url3"];
    }else{
        viwepager.imageNames = @[@"1.png",@"2.png",@"3.png"];
    }
    
    tableV.tableHeaderView = viwepager;


该工程使用CocoaPods引入第三放SDWebImage，如果出现cocoaPods报错，可以使用CocoaPods pod install 以下即可

