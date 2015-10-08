//
//  YQCompanyViewController.m
//  记账软件
//
//  Created by nickchen on 15/4/30.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQCompanyViewController.h"
#import "YQCompany.h"
#import "YQCompanyCell.h"

@interface YQCompanyViewController ()
/**
 *  公司信息数组
 */
@property(nonatomic,strong) NSMutableArray *companys;


@end

@implementation YQCompanyViewController

#warning 没有使用这个控制器

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - lazyLoad
- (NSMutableArray *)companys
{
    if (_companys == nil) {
        NSString* path = [[NSBundle mainBundle]pathForResource:@"p2pbank.plist" ofType:nil];
        NSArray* dictArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *companyArray = [NSMutableArray array];
        for (NSDictionary* dict in dictArray) {
            YQCompany* companyInfo = [YQCompany companyWithDict:dict];
            [companyArray addObject:companyInfo];
        }
        _companys = companyArray;
    }
    return _companys;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.companys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YQCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"company"];

    cell.company = self.companys[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
    YQCompany *company = self.companys[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(companyViewController:selectCompany:)]) {
        
        [self.delegate companyViewController:self selectCompany:company ];
    }
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
