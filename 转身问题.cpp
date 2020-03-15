#include <iostream>
using namespace std;


int main(){
	
	int n,m,i,s;
	short *N=NULL;
	int *M=NULL;
	
	cout << "学生人数:";
	cin >> n;
	N = new short[n]();
	
	cout << "转身次数:";
	cin >> m;
	M = new int[m]();
	
	cout << "依次输入作为倍数基底的数字:";
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
		    cout << i << "个人\n" << endl;
	}
	delete [] N;
	delete [] M;
	cout << "共有" << s <<"人面对老师。" << endl;
}
