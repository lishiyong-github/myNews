//
//  CoreManager.m
//  头条
//
//  Created by  on 14-10-4.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "CoreManager.h"
#import "Article.h"

@implementation CoreManager



@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

/*
 一个articleEntity相当于一张表
 一个articleEntity对象就是相当于一条数据（记录）
 
 用coreData实现数据的－》存储－》协调
 */
//增加第一张表*******************Article****************
- (void)addArticleModel:(NewsModel *)model
{
    NSLog(@"model.title is %@",model.title);
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    Article *articleEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:managedObjectContext];
    articleEntity.title = model.title;
    articleEntity.source = model.source;
    articleEntity.shareUrl = model.share_url;
    articleEntity.hasImage = model.has_image;
    articleEntity.imageUrl = model.imageUrl;
    
    NSError *error = nil;
    if ([self.managedObjectContext save:&error]) {
        NSLog(@"插入数据成功");
    }else {
        NSLog(@"插入数据失败");
    }
}

- (void)removeArticleModel:(NewsModel *)model
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSEntityDescription *articleEntity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    [request setEntity:articleEntity];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"title = %@",model.title];
    [request setPredicate:predict];
    
    NSError *error = nil;
    NSArray *listData = [managedObjectContext executeFetchRequest:request error:&error];
    if (listData.count > 0) {
        Article *artEntity = [listData lastObject];
        [self.managedObjectContext deleteObject:artEntity];
        NSError *error = nil;
        if ([self.managedObjectContext save:&error]) {
            NSLog(@"删除成功");
        }else {
            NSLog(@"删除失败");
        }
    }
    
    
}

- (BOOL)findArtivleModel:(NewsModel *)model
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSEntityDescription *articleEntity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    [request setEntity:articleEntity];
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"title = %@",model.title];
    [request setPredicate:predict];
    
    NSError *error = nil;
    NSArray *listData = [managedObjectContext executeFetchRequest:request error:&error];
    if (listData.count > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (NSMutableArray *)findAllArticle
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init ];
    [fetchRequest setEntity:entityDescription];
    
    NSArray *listData = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    
    for (Article *articleEntity in listData) {
        NewsModel *model = [[NewsModel alloc]init];
        model.title = articleEntity.title;
        model.source = articleEntity.source;
        model.share_url = articleEntity.shareUrl;
        model.has_image = articleEntity.hasImage;
        model.imageUrl = articleEntity.imageUrl;
        [resultArray addObject:model];
        
    }
    return resultArray;
    
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SaveModel" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Article.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
