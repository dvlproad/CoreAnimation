//
//  HomeViewController.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "HomeViewController.h"

#import "ModuleModel.h"

#import "BaseAnimationViewController.h"
#import "RadarAnimationViewController.h"
#import "PeiwoAnimationViewController.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"Home首页", nil);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.datas = [[NSMutableArray alloc] init];
    
    //BaseAnimationDemo
    ModuleModel *baseAnimationModuleModel = [[ModuleModel alloc] init];
    baseAnimationModuleModel.title = @"BaseAnimationDemo";
    baseAnimationModuleModel.classEntry = [BaseAnimationViewController class];
    [self.datas addObject:baseAnimationModuleModel];
    
    //RadarAnimation
    ModuleModel *radarAnimationModule = [[ModuleModel alloc] init];
    radarAnimationModule.title = @"RadarAnimation(雷达动画)";
    radarAnimationModule.classEntry = [RadarAnimationViewController class];
    [self.datas addObject:radarAnimationModule];
    
    //PeiwoAnimation
    ModuleModel *peiwoAnimationModule = [[ModuleModel alloc] init];
    peiwoAnimationModule.title = @"PeiwoAnimation(陪我动画)";
    peiwoAnimationModule.classEntry = [PeiwoAnimationViewController class];
    [self.datas addObject:peiwoAnimationModule];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ModuleModel *moduleModel = [self.datas objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = moduleModel.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
    
    ModuleModel *moduleModel = [self.datas objectAtIndex:indexPath.row];
    Class classEntry = moduleModel.classEntry;
    NSString *nibName = NSStringFromClass(moduleModel.classEntry);
    
    
    UIViewController *viewController = nil;
    
    NSString *clsString = NSStringFromClass(moduleModel.classEntry);
    if ([clsString isEqualToString:NSStringFromClass([UIViewController class])])
    {
        viewController = [[classEntry alloc] init];
        viewController.view.backgroundColor = [UIColor whiteColor];
        
    } else {
        viewController = [[classEntry alloc] initWithNibName:nibName bundle:nil];
    }
    viewController.title = NSLocalizedString(moduleModel.title, nil);
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end