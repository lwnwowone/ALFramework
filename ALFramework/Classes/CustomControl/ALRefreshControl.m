//
//  ALRefreshControl.m
//  DAE
//
//  Created by AlancLiu on 24/07/2017.
//  Copyright © 2017 Huiyin. All rights reserved.
//

#import "ALRefreshControl.h"
#import "ALBasicToolBox.h"

@implementation ALRefreshControl

-(void)beginRefreshing{
    [ALBasicToolBox runFunctionInMainThread:^{
        UITableView *tableView = (UITableView *)self.superview;
        if(tableView){
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^(void){
                                 tableView.contentOffset = CGPointMake(0, -self.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 [super beginRefreshing];
                                 [super sendActionsForControlEvents:UIControlEventValueChanged];
                             }];
        }
        else
            [super beginRefreshing];
    }];
}

-(void)endRefreshing{
    [ALBasicToolBox runFunctionInMainThread:^{
        [super endRefreshing];
    }];
}

@end
