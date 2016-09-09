//
//  MyInformationController.m
//  JiaPlus
//
//  Created by 汪杰 on 16/9/6.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MyInformationController.h"
#import "MyInformationModel.h"
@interface MyInformationController ()

@property (nonatomic ,strong) NSArray *titles;
@property (nonatomic, strong) MyInformationModel *myself;

@property (nonatomic, strong) NSArray *myInformation;

@end

@implementation MyInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
    self.tableView.estimatedRowHeight = 45.0f;
    self.titles = @[@"头像",@"呢称",@"真实姓名",@"年龄",@"性别",@"情感状态",@"常出没地点",@"兴趣"];
    NSDictionary *dic = @{@"headImage":@"icon1.jpg",@"nickName":@"呵呵",@"realName":@"哈哈哈",@"age":@"18",@"gender":@"女",@"emotion":@"单身",@"place":@"普陀",@"interesting":@"美食、旅游"};
    _myself = [MyInformationModel modelWithDictionary:dic];
    
    _myInformation = @[@"呵呵",@"哈哈哈",@"18",@"女",@"单身",@"普陀",@"美食、旅游"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"myInformationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 0) {
        UIImageView *userImage = [[UIImageView alloc] initWithImage:[self clipImageWithImage:[UIImage imageNamed:@"icon1.jpg"] inRect:CGRectMake(60, 60, 60, 60)]];
        userImage.layer.cornerRadius = 10.0f;
        userImage.layer.masksToBounds = YES;
        cell.accessoryView = userImage;
    }else{
        cell.detailTextLabel.text = _myInformation[indexPath.row-1];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}
/**
 *  剪切图片
 *
 *  @param image 原始图片
 *  @param rect  裁剪范围
 *
 *  @return 剪切好的图片
 */
- (UIImage*)clipImageWithImage:(UIImage*)image inRect:(CGRect)rect {
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, rect, imageRef);
    
    UIImage* clipImage = [UIImage imageWithCGImage:imageRef];
    
    //    CGImageCreateWithImageInRect(CGImageRef  _Nullable image, <#CGRect rect#>)
    
    //    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();      // 不同的方式
    
    UIGraphicsEndImageContext();
    
    //    NSData* data = [NSData dataWithData:UIImagePNGRepresentation(clipImage)];
    
    //    BOOL flag = [data writeToFile:@"/Users/gua/Desktop/Image/后.png" atomically:YES];
    
    //    GGLogDebug(@"========压缩后=======%@",clipImage);
    
    return clipImage;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80.0f;
    }else{
        return 40.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 100)];
    view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"个人认证" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.frame = CGRectMake(20, 10, screen_width-40, 40);
    btn.layer.cornerRadius = 5.0f;
    btn.layer.masksToBounds = true;
    [view addSubview:btn];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"*个人认证后可查看周边妹子(帅哥)哦!";
    label.frame = CGRectMake(20, 60, screen_width-40, 30);
    [view addSubview:label];
    
    return view;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end