//
//  SortingVC.m
//  SortingApp
//
//  Created by Mukesh on 25/04/16.
//  Copyright © 2016 Mukesh. All rights reserved.
//

#import "SortingVC.h"

@interface SortingVC (){
    
  
    NSMutableArray *unsortedArray;
    
}

@property (weak, nonatomic) IBOutlet UILabel *labelSortName;
@property (weak, nonatomic) IBOutlet UIButton *sortButton;
@property (weak, nonatomic) IBOutlet UITableView *tableSorting;
//-(NSMutableArray*)mergeSort:(NSMutableArray*)mArray;
//-(NSMutableArray*)quickSort:(NSMutableArray*)qArray;
//-(NSMutableArray*)heapSort:(NSMutableArray*)hArray;
- (IBAction)sortPressed:(id)sender;
@end


@implementation SortingVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.labelSortName.text= self.sortTitle;
    
   // self.tableSorting.delegate=self;
    
   // self.tableSorting.dataSource=self;
  
  //  unsortedArray = [NSMutableArray new];
    unsortedArray= [NSMutableArray arrayWithArray:self.sortArray];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-
#pragma mark Table View Data Source Method.......

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sortArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.sortArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (IBAction)sortPressed:(id)sender {
    NSMutableArray * sortedArray = [NSMutableArray new];
    if (self.sortCompareValue==1){
        sortedArray = [self mergeSort:unsortedArray];
        self.sortArray = sortedArray;
        [self.tableSorting reloadData];
        return;
    }
    else
        if (self.sortCompareValue==2)
        {
            sortedArray= [self quickSort:unsortedArray];
            self.sortArray= sortedArray;
            [self.tableSorting reloadData];       
            return;
        }
    
        else {
            sortedArray= [self heapSort:unsortedArray];
            self.sortArray= sortedArray;
            [self.tableSorting reloadData];
            return;
        }
}



#pragma mark-
#pragma mark MergeSort....

-(NSMutableArray*)mergeSort:(NSMutableArray*)mUnsotedArray{
    
    if ([mUnsotedArray count]<2) {
        return mUnsotedArray;
    }
    
    long middle = ([mUnsotedArray count]/2);
    NSRange left = NSMakeRange(0, middle);
    NSRange right = NSMakeRange(middle, ([mUnsotedArray count] - middle));
    NSArray *leftArr = [mUnsotedArray subarrayWithRange:left];
    NSArray *rightArr = [mUnsotedArray subarrayWithRange:right];
    NSMutableArray *resultArray =[self merge:[self mergeSort:leftArr] andRight:[self mergeSort:rightArr]];
    return resultArray;
}

-(NSArray *)merge:(NSArray *)leftArr andRight:(NSArray *)rightArr{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    int right = 0;
    int left = 0;
    while (left < [leftArr count] && right < [rightArr count])
    {
        if ([[leftArr objectAtIndex:left] intValue] < [[rightArr objectAtIndex:right] intValue]){
            [result addObject:[leftArr objectAtIndex:left++]];
        }
        else
        {
            [result addObject:[rightArr objectAtIndex:right++]];
        }
    }
    
    NSRange leftRange = NSMakeRange(left, ([leftArr count] - left));
    NSRange rightRange = NSMakeRange(right, ([rightArr count] - right));
    NSArray *newLeft = [leftArr subarrayWithRange:leftRange];
    NSArray *newRight = [rightArr subarrayWithRange:rightRange];
    newLeft = [result arrayByAddingObjectsFromArray:newLeft];
    return [newLeft arrayByAddingObjectsFromArray:newRight];
}


#pragma mark-
#pragma mark QuickSort ....


-(NSMutableArray*)quickSort:(NSMutableArray*)qUnsotedArray{
    
    NSMutableArray *lessArray = [[NSMutableArray alloc] init];
    NSMutableArray *greaterArray =[[NSMutableArray alloc] init];
    if ([qUnsotedArray count] <1)
    {
        return nil;
    }
    
    int randomPivotPoint = arc4random() % [qUnsotedArray count];
    
    NSNumber *pivotValue = [qUnsotedArray objectAtIndex:randomPivotPoint];
    [qUnsotedArray removeObjectAtIndex:randomPivotPoint];
    
    
    for (NSNumber *num in qUnsotedArray)
    {
        
        if (num < pivotValue)
        {
            [lessArray addObject:num];
        }
        else
        {
            [greaterArray addObject:num];
        }
    }
    
    
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    
    [sortedArray addObjectsFromArray:[self quickSort:lessArray]];
    
    [sortedArray addObject:pivotValue];
    [sortedArray addObjectsFromArray:[self quickSort:greaterArray]];
        
    return sortedArray;
    
}















#pragma mark-
#pragma mark Heap Sort............

-(NSMutableArray*)heapSort:(NSMutableArray*)hUnsotedArray{
    
    if([hUnsotedArray count]<1)
        return nil;
    [self buildMaxHeap:hUnsotedArray];
    NSMutableArray* sortedA = [NSMutableArray new];
    for (int i = (int)hUnsotedArray.count-1; i>0; i--) {
        [sortedA insertObject:hUnsotedArray[0] atIndex:0];
        [hUnsotedArray exchangeObjectAtIndex:0 withObjectAtIndex:hUnsotedArray.count-1];
        [hUnsotedArray removeLastObject];
        [self maxHeapify:hUnsotedArray andParentIndex : 0];
        
    }
    [sortedA insertObject:hUnsotedArray[0] atIndex:0];
    return sortedA ;
}


-(void)buildMaxHeap:(NSMutableArray*)nodeData{
    if(nodeData.count<2){
        return;
    }
    int lastParentIndex = (int)nodeData.count/2;
    for (int parentIndex = lastParentIndex; parentIndex >= 0; parentIndex--) {
        
        [self maxHeapify:nodeData andParentIndex:parentIndex];
    }
}

-(void)maxHeapify:(NSMutableArray*)nodeData andParentIndex :(int)indexRoot{
    if([self leftLeafIndex:indexRoot]>[self heapLastIndex:nodeData]){
        return;
    }
    
    int rootValue =[nodeData[indexRoot] intValue];
    int largestIndex = indexRoot;
    int largestValue = rootValue;
    
    int leftLeafValue = [nodeData[[self leftLeafIndex:indexRoot]] intValue];
    if(leftLeafValue>rootValue) {
        largestIndex = [self leftLeafIndex:indexRoot];
        largestValue = leftLeafValue;
    }
    if([self rightLeafIndex:indexRoot]<=[self heapLastIndex:nodeData]){
        int rightLeafValue = [nodeData[[self rightLeafIndex:indexRoot]] intValue];
        if(rightLeafValue>largestValue) {
            largestIndex = [self rightLeafIndex:indexRoot];
            largestValue = rightLeafValue;
        }
    }
    
    if(largestIndex != indexRoot){
        [nodeData exchangeObjectAtIndex:indexRoot withObjectAtIndex:largestIndex];
        [self maxHeapify:nodeData andParentIndex:largestIndex ];
    }
}



-(int)leftLeafIndex:(int)rootIndex{
    int heapIndex = rootIndex+1;
    return heapIndex*2-1;
}

-(int)rightLeafIndex:(int) rootIndex{
    int heapIndex = rootIndex+1;
    return heapIndex*2+1-1;
}

-(int) heapLastIndex:(NSMutableArray*) nodeData{
    return (int)nodeData.count-1;
}



@end
