import UIKit

/// 3202. Find the Maximum Length of Valid Subsequence II
func maximumLength(_ nums: [Int], _ k: Int) -> Int {
    
    let n = nums.count
    var dp = Array(repeating: [Int: Int](), count: n)
    var maxLen = 1
    
    for j in 0..<n {
        for i in 0..<j {
            let mod = (nums[i] + nums[j]) % k
            let prevLen = dp[i][mod] ?? 1
            dp[j][mod] = max(dp[j][mod] ?? 1, prevLen + 1)
            maxLen = max(maxLen, dp[j][mod]!)
        }
    }
    
    return maxLen
    
}

/// 1. Two Sum
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var numToIndex = [Int: Int]()
    
    for (index, num) in nums.enumerated() {
        let complement = target - num
        if let matchIndex = numToIndex[complement] {
            return [matchIndex, index]
        }
        numToIndex[num] = index
    }
    
    return []
}

/// 2. Add Two Numbers
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    let dummyHead = ListNode(0)
    var current = dummyHead
    var carry = 0
    var p = l1, q = l2
    
    while p != nil || q != nil || carry != 0 {
        let x = p?.val ?? 0
        let y = q?.val ?? 0
        let sum = x + y + carry
        
        carry = sum / 10
        current.next = ListNode(sum % 10)
        current = current.next!
        
        p = p?.next
        q = q?.next
    }
    
    return dummyHead.next
}

/// 3. Longest Substring Without Repeating Characters
func lengthOfLongestSubstring(_ s: String) -> Int {
    var maxLength: Int = 0
    
    var charMap: [Character: Int] = [:]
    
    var startIndex = 0
    
    for (index, char) in s.enumerated() {
        if let lastIndex = charMap[char] {
            startIndex = max(startIndex, lastIndex+1)
            
        }
        maxLength = max(maxLength, index - startIndex+1)
        charMap[char] = index
    }
    
    return maxLength
}

/// 4. Median of Two Sorted Arrays
func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    let A = nums1
    let B = nums2
    let m = A.count
    let n = B.count
    
    if m > n {
        return findMedianSortedArrays(B, A)
    }
    
    var low = 0, high = m
    while low <= high {
        let partitionA = (low + high) / 2
        let partitionB = (m + n + 1) / 2 - partitionA
        
        let maxLeftA = partitionA == 0 ? Int.min : A[partitionA - 1]
        let minRightA = partitionA == m ? Int.max : A[partitionA]
        
        let maxLeftB = partitionB == 0 ? Int.min : B[partitionB - 1]
        let minRightB = partitionB == n ? Int.max : B[partitionB]
        
        if maxLeftA <= minRightB && maxLeftB <= minRightA {
            if (m + n) % 2 == 0 {
                return Double(max(maxLeftA, maxLeftB) + min(minRightA, minRightB)) / 2.0
            } else {
                return Double(max(maxLeftA, maxLeftB))
            }
        } else if maxLeftA > minRightB {
            high = partitionA - 1
        } else {
            low = partitionA + 1
        }
    }
    
    // If we reach here, input arrays were not sorted correctly
    fatalError("Input arrays are not sorted.")
}
