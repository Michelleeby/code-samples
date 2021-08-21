public int maxDifference(int[] ints) {
    int acc = 0;
    for (int current = 0; current < ints.length; current++) {
        for (int offset = current + 1; offset < ints.length; offset++) {
            if (ints[current] < ints[offset]) {
                if (acc < ints[offset] - ints[current]) {
                    acc = ints[offset] - ints[current];
                }
            }
        }
    }
    
    return acc;
}