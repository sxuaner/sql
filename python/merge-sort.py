
# --  Python code to implement merge sort algorithm
def merge_sort(arr):    
    # Step 1: 算数组长度
    # Step 2: 把数组分成两半
    # Step 3: 递归地对每一半进行排序
    # Step 4: 合并两个已排序的数组
    # Step 5: 检查是不是有元素剩下
    # Step 6: 把剩下的元素添加到合并后的数组中
    # Step 7: 返回合并后的数组
    
    if len(arr) > 1:
    # Floor Division (//): This operator performs division and then rounds the result down to the nearest whole number (the floor, the opposite is ceiling). The return type 
    # depends on the operands: if both are integers, the result is an integer; if either is a float, the result is a float
        mid = len(arr) // 2  # Finding the mid of the array

        # In Python, array[:mid] represents array slicing. This operation extracts a portion of an array (or list) from the beginning up to, 
        # but not including, the element at the mid index.

        L = arr[:mid]        # Dividing the elements into 2 halves
        R = arr[mid:]

        merge_sort(L)  # Sorting the first half
        merge_sort(R)  # Sorting the second half

        i = j = k = 0

        # The while loop iterates through both arrays L and R, comparing their elements and merging them back into the original array arr in sorted order.
        while i < len(L) and j < len(R):
            if L[i] < R[j]:
                # Be careful with  the arr here, it refers to the left or right array, not the original array from the beginning.
                arr[k] = L[i]
                i += 1
            else:
                arr[k] = R[j]
                j += 1
            k += 1

        # Checking if any element was left
        # Is this step necessary? Yes, this step is necessary to ensure that any remaining elements in either L or R are added to arr after the main merging loop has completed.
        # The while loop iterates through the remaining elements in L and R, if any, and appends them to arr.
        
        while i < len(L):
            arr[k] = L[i]
            #  is there i++ in python?
            # in Python, you can increment a variable using i += 1.
            # This is equivalent to i = i + 1, which increases the value of i     
            i += 1
            k += 1

        while j < len(R):
            arr[k] = R[j]
            j += 1
            k += 1


            