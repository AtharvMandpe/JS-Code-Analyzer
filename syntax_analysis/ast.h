typedef struct ASTNode {
    char *name;
    struct ASTNode *left;
    struct ASTNode *right;
} ASTNode;

ASTNode *new_node(char *name, ASTNode *left, ASTNode *right);
void print_ast(ASTNode *node, int depth);
