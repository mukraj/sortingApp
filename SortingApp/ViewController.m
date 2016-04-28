//
//  ViewController.m
//  SortingApp
//
//  Created by Mukesh on 25/04/16.
//  Copyright © 2016 Mukesh. All rights reserved.
//

#import "ViewController.h"
#import "SortingVC.h"
#import "BubbleSortVC.h"

@interface ViewController ()
{
    NSMutableArray *sortNameArray;
    NSArray *dataArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   // self.tableView.dataSource=self;
   // self.tableView.delegate=self;
    
    
    dataArray = [[NSArray alloc]initWithObjects: [NSNumber numberWithInt:2] ,[NSNumber numberWithInt:8],[NSNumber numberWithInt:9],[NSNumber numberWithInt:3],[NSNumber numberWithInt:7],[NSNumber numberWithInt:5],[NSNumber numberWithInt:1],[NSNumber numberWithInt:4],nil];
    
    sortNameArray = [[NSMutableArray alloc]initWithObjects:@"Merge Sort",@"Quick Sort",@"Heap Sort",@"Bubble" ,nil];
    
    NSLog(@"%@",dataArray);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-
#pragma mark TableView Data Source Methods.......

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return sortNameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [sortNameArray objectAtIndex:indexPath.row];
    
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle= UITableViewCellSelectionStyleDefault;
    return cell;
}
#pragma mark-
#pragma mark TableView Delegate Methods.......

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        
        BubbleSortVC  *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"BubbleVC"];
        vc.sortTitle = [sortNameArray objectAtIndex:indexPath.row];
        
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    [self performSegueWithIdentifier:@"SortVC" sender:self];
    
}
#pragma mark-
#pragma mark Prepare for Segue Method.........
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier ]isEqualToString:@"SortVC"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SortingVC *vc = [segue destinationViewController];
        // vc.view.frame= vc.view.frame;
        if (indexPath.row==0) {
            vc.sortTitle = [sortNameArray objectAtIndex:indexPath.row];
            vc.sortArray = [NSArray arrayWithArray:dataArray];
            vc.sortCompareValue = 1;
            return ;
        }
        if (indexPath.row==1) {
            vc.sortTitle = [sortNameArray objectAtIndex:indexPath.row];
            vc.sortArray = [NSArray arrayWithArray:dataArray];
            vc.sortCompareValue = 2;
            return;
        }
        if (indexPath.row==2) {
            vc.sortTitle = [sortNameArray objectAtIndex:indexPath.row];
            vc.sortArray = [NSArray arrayWithArray:dataArray];
            vc.sortCompareValue=3;
            return;
        }
        
    }
}






@end
