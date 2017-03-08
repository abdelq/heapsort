def suite(n):
    if (n == 0): return 1
    else: return (suite(n - 1) + 2 * n) % 7

print(suite(12))
