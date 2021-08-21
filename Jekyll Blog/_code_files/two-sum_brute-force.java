public int[] twoSum(int[] nums, int target) {
    int[] indices = new int[2];
    
    for (int current = 0; current < nums.length; current++) {
        for (int offset = current + 1; offset < nums.length; offset++) {
            if (nums[current] + nums[offset] == target) {
                indices[0] = current;
                indices[1] = offset;
            }
        }
    }
    
    return indices;
}