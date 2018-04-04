#  Swift 4.1 problem with YapDatabase
## Modified ManualViewExample project that comes with YapDatabase

Swift runtime crashes with EXC_BAD_ACCESS on block invocation of Swift closure when called from Objective-C.

One way to patch this is to init metadata as an NSObject. For example:


```Objective-C
	[self enumerateRowidsInGroup:group
	                 withOptions:options
	                  usingBlock:^(int64_t rowid, NSUInteger index, BOOL *stop)
	{
		YapCollectionKey *ck = nil;
		id object = nil;
		id metadata = nil;
		[databaseTransaction getCollectionKey:&ck object:&object metadata:&metadata forRowid:rowid];
		
        // NOTE: - Fix for nil metadata!
        // Swift will try to treat Any as AnyObject
        // and will produce EXC_BAD_ACCESS
        if (metadata == nil) {
            metadata = [NSObject new];
        }
        
		block(ck.collection, ck.key, object, metadata, index, stop);
	}];
```

