public int numIslands(char[][] grid) {
    int count = 0;
    for (int row = 0; row < grid.length; row++) {
        for (int col = 0; col < grid[0].length; col++) {   
            // Check for land in place
            if (grid[row][col] == '1') {
                // Check for water behind
                if (col - 1 < 0 || grid[row][col - 1] == '0') {
                    // Check for water above
                    if (row - 1 < 0 || grid[row - 1][col] == '0') {
                        count++;
                    }
                }
            }             
        }
    }  
    return count;
}
