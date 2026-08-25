#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 045 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read of the reached leaf
//   Sink   (write): VOLATILE - one write instruction per tree leaf
// Idea:
//   A small binary tree is walked by a random path, and each of the four
//   leaves is written by its own instruction. The read dereferences the
//   pointer produced by the walk, so the source is unique while the sink
//   depends on the path taken.
// Expected result:
//   VOLATILE. At least one leaf write line is expected to disappear from
//   the sampled dependency set.
// ============================================================

struct TreeNode {
    int value;
    TreeNode* left;
    TreeNode* right;
};

int main() {
    TreeNode leaf00; leaf00.left = 0; leaf00.right = 0;
    TreeNode leaf01; leaf01.left = 0; leaf01.right = 0;
    TreeNode leaf10; leaf10.left = 0; leaf10.right = 0;
    TreeNode leaf11; leaf11.left = 0; leaf11.right = 0;

    TreeNode inner0; inner0.left = &leaf00; inner0.right = &leaf01;
    TreeNode inner1; inner1.left = &leaf10; inner1.right = &leaf11;
    TreeNode root;   root.left = &inner0;   root.right = &inner1;

    int first = rand() % 2;
    int second = rand() % 2;

    if (first == 0 && second == 0) {
        leaf00.value = 1;           // Sink (leaf 00)
    } else if (first == 0) {
        leaf01.value = 2;           // Sink (leaf 01)
    } else if (second == 0) {
        leaf10.value = 3;           // Sink (leaf 10)
    } else {
        leaf11.value = 4;           // Sink (leaf 11)
    }

    TreeNode* cursor = (first == 0) ? root.left : root.right;
    cursor = (second == 0) ? cursor->left : cursor->right;
    int x = cursor->value;          // Source
    (void) x;
}
