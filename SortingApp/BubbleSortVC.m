//
//  BubbleSortVC.m
//  SortingApp
//
//  Created by Mukesh on 25/04/16.
//  Copyright © 2016 Mukesh. All rights reserved.
//

#import "BubbleSortVC.h"

@interface BubbleSortVC ()
{
    NSMutableArray *sortArray;
    NSString *str;
}

@property (weak, nonatomic) IBOutlet UIButton *sortButton;
@property (weak, nonatomic) IBOutlet UILabel *labelSortTitle;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//-(NSMutableArray*):bubbleSort:(NSMutableArray*)bUnsotedArray;
- (IBAction)sortPressed:(id)sender;
- (IBAction)savePressed:(id)sender;

@end

@implementation BubbleSortVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelSortTitle.text= self.sortTitle;
    sortArray = [NSMutableArray new];
   // self.tableView.delegate=self;
   // self.tableView.dataSource=self;
}

#pragma mark- 
#pragma mark Table View Data Source method...
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger x= sortArray.count;
    return x;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    str = [NSString stringWithFormat:@"%@",[sortArray objectAtIndex:indexPath.row]];
    
    cell.textLabel.text = str;
    
    return cell;
    
}


-(IBAction)savePressed:(id)sender {
     str =self.textField.text;
    [sortArray addObject:str];
    [self.tableView reloadData];
    [self.textField resignFirstResponder];

    
}

#pragma mark- Bubble Sort...
-(NSMutableArray*)bubbleSort:(NSMutableArray*)bUnsotedArray{
    long count = bUnsotedArray.count;
    int i;
    bool swapped = TRUE;
    while (swapped){
        swapped = FALSE;
        for (i=1; i<count;i++)
        {
            if ([[bUnsotedArray objectAtIndex:(i-1)] integerValue]> [[bUnsotedArray objectAtIndex:i]integerValue])
            {
                [bUnsotedArray exchangeObjectAtIndex:(i-1) withObjectAtIndex:i];
                swapped = TRUE;
            }
            
        }
    }
    
    return bUnsotedArray;
}



- (IBAction)sortPressed:(id)sender {
    NSMutableArray *sortedArray= [NSMutableArray new];
    sortedArray= [self bubbleSort:sortArray];
    sortArray=sortedArray;
    [self.tableView reloadData];
    [self.textField resignFirstResponder];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [self.textField resignFirstResponder];
    return YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
