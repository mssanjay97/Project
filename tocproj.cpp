#include <iostream>
using namespace std;
#include<stdlib.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

struct node
{
    char kv[100];
    struct node *left, *right;
};
struct node *newNode(int key,int value)
{char kv1[100],kv2[100];

    struct node *temp =  (struct node *)malloc(sizeof(struct node));
      itoa (key,kv1,10);
    strcat(kv1,".");
    itoa(value,kv2,10);
    strcat(kv1,kv2);
    strcpy(temp->kv,kv1);
    //temp->kv[0] =char(key);temp->kv[1]='.';temp->kv[2]=char(value);temp->kv[3]='\0';
    temp->left = temp->right = NULL;
    return temp;
}
struct node* insert(struct node* node, int key,int value)
{   char temp[100];
    if (node == NULL)
        return newNode(key,value);
    int i;
    for(i=0;i<strlen(node->kv);i++)
    {
        if(node->kv[i]=='.')
            break;
        temp[i]=node->kv[i];
    }
    temp[i]='\0';
    int kvkey=atoi(temp);
    if (key < kvkey)
        node->left  = insert(node->left, key,value);
    else if (key > kvkey)
        node->right = insert(node->right, key,value);
    else if(key == kvkey)
    {   strcat(node->kv,".");
        char buffer[100];
        itoa (value,buffer,10);
        strcat(node->kv,buffer);
    }
    return node;
}
void inorder(struct node *root)
{
    if (root != NULL)
    {
        inorder(root->left);
        cout<<root->kv<<endl;
        inorder(root->right);
    }
}

struct node* search(struct node* root, int key)
{   if(root==NULL)
        return NULL;
    char temp[100];
    int i;
    for(i=0;i<strlen(root->kv);i++)
    {
        if(root->kv[i]=='.')
            break;
        temp[i]=root->kv[i];
    }
    temp[i]='\0';
    int kvkey=atoi(temp);
    if (kvkey == key)
       return root;

    if (kvkey < key)
       return search(root->right, key);

    return search(root->left, key);
}
struct node * minValueNode(struct node* node)
{
    struct node* current = node;

    while (current->left != NULL)
        current = current->left;

    return current;
}
struct node* deleteNode(struct node* root, int key)
{
    if (root == NULL) return root;
    char temp[100];
    int i;
    for(i=0;i<strlen(root->kv);i++)
    {
        if(root->kv[i]=='.')
            break;
        temp[i]=root->kv[i];
    }
    temp[i]='\0';
    int kvkey=atoi(temp);
    if (key < kvkey)
        root->left = deleteNode(root->left, key);

    else if (key > kvkey)
        root->right = deleteNode(root->right, key);

    else
    {
        if (root->left == NULL)
        {
            struct node *temp = root->right;
            free(root);
            return temp;
        }
        else if (root->right == NULL)
        {
            struct node *temp = root->left;
            free(root);
            return temp;
        }
        struct node* temp = minValueNode(root->right);
        char tem[100];
    int i;
    for(i=0;i<strlen(temp->kv);i++)
    {
        if(temp->kv[i]=='.')
            break;
        tem[i]=temp->kv[i];
    }
    tem[i]='\0';
    int kvtemkey=atoi(tem);
        strcpy(root->kv,temp->kv);
        root->right = deleteNode(root->right, kvtemkey);
    }
    return root;
}
int main() {
	node *root;
	root=NULL;
	root=insert(root,1,2);
	root=insert(root,2,3);
    root=insert(root,3,4);
	root=insert(root,4,5);
	root=insert(root,4,6);
    inorder(root);
    node *res;
    int key=9;
    res=search(root,key);
    if(res==NULL)
        cout<<key<<" not found\n";
    else
        cout<<"Key is found";
    deleteNode(root,2);
    inorder(root);
    	return 0;
}
