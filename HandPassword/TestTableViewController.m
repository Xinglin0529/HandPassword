//
//  TestTableViewController.m
//  HandPassword
//
//  Created by Dongdong on 16/5/6.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "TestTableViewController.h"
#import "TestTableViewCell.h"
#import "TestModel.h"
#import "YZTGestureDefine.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>

@interface TestTableViewController ()

@property (nonatomic, strong) NSMutableArray<TestModel *> *rowData;

@end

@implementation TestTableViewController

static NSString *const kTestTableViewCell = @"TestTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rowData = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        TestModel * m = [TestModel new];
        m.title = [NSString stringWithFormat:@"标题%ld",i+1];
        if (i == 0) {
            m.content = @"你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你好111";
            m.describe = @"你好你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你11";
        } else if (i == 3) {
            m.content = @"你好你你好你你好你你好你你好你你好你你好你你好你你好你你你好你你好你你好你你好你你好你你你好你你好你你好你你好你你好你你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你好111";
            m.describe = @"你好你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你11";

        } else if (i == 6) {
            m.content = @"你好你你好你你好你你你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你好111";
            m.describe = @"你好你好你你好你你好你你好你你好你你好你你你好你你好你你好你你好你你好你你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你11";

        } else if (i == 9) {
            m.content = @"你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你好111";
            m.describe = @"你好你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你11";

        } else {
            m.content = @"你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你你好你你你好你你好你你好你你好你你好你你你好你你你好你你好你你好你你好你你好你你你好你你你好你你好你你好你你好你你好你你你好你你你好你你好你你好你你好你你好你你你好你你你好你你好你你好你你好你你好你你你好你你你好你你好你你好你你好你你好你你你好你你你好你你好你你好你你好你你好你你你好你你你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你你好你好111";
            m.describe = @"你好你好你你好你你好你你好你你好你你好你你好你你你你好你你好你你好你你好你你好你你你好你你你好你你好你你好你你好你你好你你你好你你你好你你好你你好你你好你你好你你你好你你你好你你好你你好你你好你你好你你你好你你你好你你好你你好你你好你你好你你你好你你你好你你好你你好你你好你你好你你你好你你你好你你好你你好你你好你你好你你你好你好你你好你你好你你好你11";
        }
        
        [self.rowData addObject:m];
    }
    [self.tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:kTestTableViewCell];
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
    return self.rowData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:kTestTableViewCell cacheByIndexPath:indexPath configuration:^(id cell) {
        [(TestTableViewCell *)cell configCellData:self.rowData[indexPath.row]];
    }];
//    return 200.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTestTableViewCell];
    [cell configCellData:self.rowData[indexPath.row]];
    return cell;
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
