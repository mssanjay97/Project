#include <iostream>
using namespace std;

struct node
{
    int data;
    node *next,*prev;
}*ptr2=NULL,*ptr1=NULL,*temp=NULL,*top1=NULL,*top2=NULL,*ptr=NULL,*anss=NULL,*res=NULL;
int l1,l2;node *bt=NULL;
node *prod=new node;

node* add(node *topp1,node *topp2)
{  node *ans=NULL;
    int c=0;
   ptr2=topp2;
   ptr1=topp1;
   if (top1==NULL&&top2==NULL)
   cout<<endl<<"both null na\n";
   while(ptr2!=NULL)
   {
   temp=new node;
   temp->data=(ptr1->data+ptr2->data+c)%10;

   c=(ptr1->data+ptr2->data+c)/10;
   temp->next=NULL;temp->prev=NULL;
   if (ans==NULL)
   {
       ans=temp;
   }
   else
   {
       ans->next=temp;temp->prev=ans;
       ans=temp;

   }
   ptr1=ptr1->next;
   ptr2=ptr2->next;
   }
   while(ptr1!=NULL)
   {
    temp=new node;
   temp->data=(ptr1->data+c)%10;
   c=(ptr1->data+c)/10;
   temp->next=NULL;temp->prev=NULL;

    ptr1=ptr1->next;
    ans->next=temp;temp->prev=ans;
    ans=temp;
   }

   if (c)
   {
       temp=new node;
       temp->data=c;
       ans->next=temp;temp->prev=ans;
       ans=temp;
   }



   while(ans->prev!=NULL)
   {
    ans=ans->prev;
   }
   return ans;
}
void get()
{int i;
    cout<<"Enter 1st number length";
    cin>>l1;
    cout<<"ENTER 1st number";
    for(i=0;i<l1;i++)
    {
        temp=new node;
        cin>>temp->data;
        temp->next=NULL;temp->prev=NULL;
        if (top1==NULL)
        top1=temp;
        else
        {
            temp->next=top1;top1->prev=temp;
            top1=temp;
        }
    }

    cout<<"Enter second number length";
    cin>>l2;
    cout<<"Enter second number";
    for(i=0;i<l2;i++)
    {
        temp=new node;
        cin>>temp->data;
        temp->next=NULL;temp->prev=NULL;
        if (top2==NULL)
        top2=temp;
        else
        {
        temp->next=top2;top2->prev=temp;
        top2=temp;
        }
    }

}

node* sub(node *top1,node *top2)
{int c=0;
   ptr2=top2;
   ptr1=top1;
   while(ptr2!=NULL)
   {
   temp=new node;
   if (((ptr1->data)-(ptr2->data)-c)<0)
   {temp->data=10+(ptr1->data-ptr2->data-c);
   c=1;
   }
   else
   {temp->data=(ptr1->data-ptr2->data-c);
   c=0;
   }
   temp->next=NULL;temp->prev=NULL;
   if (anss==NULL)
   {
       anss=temp;
   }
   else
   {
       anss->next=temp;temp->prev=anss;
       anss=temp;
   }
   ptr1=ptr1->next;
   ptr2=ptr2->next;
   }
   while(ptr1!=NULL)
   {
    temp=new node;
    temp->prev=NULL;temp->next=NULL;
  if (((ptr1->data)-c)<0)
   {temp->data=10+(ptr1->data-c);
   c=1;
   }
   else
   {temp->data=(ptr1->data-c);
   c=0;
   }
    ptr1=ptr1->next;
    anss->next=temp;temp->prev=anss;
    anss=temp;
   }
  /* if (c)
   {
       temp=new node;
       temp->data=c;
       temp->next=ans;
       ans=temp;
   }*/
   //temp=anss;
   while(anss->prev!=NULL)
    anss=anss->prev;
   return anss;
   /*cout<<"\nanswer\n";
   if (l2>l1)
   cout<<"-";
   while(temp!=NULL)
   {
       cout<<temp->data;
       temp=temp->next;
   }*/
}

void multipli(node *topp1,node *topp2)
{
    int k=0;int c;
    //node *prod=NULL,*res;
    node *ptrmul=topp2;
    while(ptrmul!=NULL)
    {int c=0;
    res=NULL;
    node *trav=topp1;
     for(int i=0;i<k;i++)
    {
        temp=new node;
        temp->data=0;
        temp->next=NULL;temp->prev=NULL;
        if(res!=NULL)
        {res->next=temp;temp->prev=res;
        res=temp;
        }
        else
            res=temp;
    }
    while(trav!=NULL)
    {
        temp=new node;
        temp->data=((ptrmul->data*trav->data)+c)%10;
        c=((ptrmul->data*trav->data)+c)/10;
        temp->next=NULL;temp->prev=NULL;
        if(res==NULL)
        res=temp;
        else
        {
           res->next=temp;temp->prev=res;
           res=temp;
        }
         trav=trav->next;

    }
    if(c)
    {
        temp=new node;
        temp->data=c;
        res->next=temp;temp->prev=res;
        res=temp;
    }
    while(res->prev!=NULL)
       { res=res->prev;
       }
    k++;

    prod=add(res,prod);

    ptrmul=ptrmul->next;
    }
    while(prod->next!=NULL)
        prod=prod->next;
    while(prod!=NULL)
    {
        cout<<prod->data;
        prod=prod->prev;
    }

}
int main()
{node *wanser=NULL;

   get();
   //{ wanser=(top1,top2);}

prod->data=0;
prod->next=NULL;
prod->prev=NULL;
wanser=sub(top1,top2);
/*
cout<<"\nsubtraction\n";
while(wanser->next!=NULL)
    wanser=wanser->next;
while(wanser!=NULL)
{
    cout<<wanser->data;
    wanser=wanser->prev;
}

/cout<<"\nmultiplication\n";
  multipli(top1,top2);
  cout<<"\naddition\n";
 */ wanser=add(top1,top2);
  while(wanser->next!=NULL)
    wanser=wanser->next;
    while(wanser!=NULL)
    {
       cout<<wanser->data;wanser=wanser->prev;
    }
	return 0;
}
