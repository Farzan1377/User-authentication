//
//  Table1ViewController.m
//  app Security
//
//  Created by Farzan Faghihi on 10/1/15.
//  Copyright (c) 2015 Farzan Faghihi. All rights reserved.
//

#import "Table1ViewController.h"

@implementation Table1ViewController

-(NSMutableArray *)array {
    
    NSString *str = [NSString stringWithFormat:@"%@/Documents/info4.txt",NSHomeDirectory()];
    if (!_array) {
        _array = [[NSMutableArray alloc]initWithContentsOfFile:str];
    }
    return _array;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    return cell;
    
}

@end
