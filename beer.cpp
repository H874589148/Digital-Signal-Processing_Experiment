#include<stdio.h>
int main()
{
	int i,j,k,l;
	printf("买了几瓶水？\n");
	scanf("%d",&i);
	l=i;
	k=i;
	j=0;
	while(i!=j)
	{
		j=i;
		while(k>0)
		{
			k=k-4;
			i++;
			l++;
			k++;
		};
		while(l>0)
		{
			l=l-2;
			i++;
			l++;
			k++;
		};
	};
	printf("能喝%d瓶水\n",i);
	printf("剩%d瓶盖，%d空瓶\n",k,l);
	return 0;
 } 
