#include<stdio.h>
int main()
{
	int i,j,k,l;
	printf("���˼�ƿˮ��\n");
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
	printf("�ܺ�%dƿˮ\n",i);
	printf("ʣ%dƿ�ǣ�%d��ƿ\n",k,l);
	return 0;
 } 
