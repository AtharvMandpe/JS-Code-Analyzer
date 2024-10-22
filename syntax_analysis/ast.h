/* Define structure for the AST nodes */
typedef struct ASTNode {
    char *name;
    struct ASTNode *left;
    struct ASTNode *right;
} ASTNode;

/* Function prototypes for AST creation and printing */
ASTNode *new_node(char *name, ASTNode *left, ASTNode *right);
void print_ast(ASTNode *node, int depth);