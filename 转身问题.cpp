#include <iostream>
using namespace std;


int main(){
	
	int n,m,i,s;
	short *N=NULL;
	int *M=NULL;
	
	cout << "ѧ������:";
	cin >> n;
	N = new short[n]();
	
	cout << "ת�����:";
	cin >> m;
	M = new int[m]();
	
	cout << "����������Ϊ�������׵�����:";
	for(i=0;i<m;i++)
	    cin >> M[i];
	  
	for(i=0;i<m;i++){
		s=M[i];
		while(s<=n){
			N[s-1]=!N[s-1];
			s+=M[i];
		}
	}
	
	s=0;
	for(i=0;i<n;i++){
		if(N[i]==0)
		    s++;
		    cout << i << "����\n" << endl;
	}
	delete [] N;
	delete [] M;
	cout << "����" << s <<"�������ʦ��" << endl;
}
