#include <stdio.h>
int main()
{
    FILE *stream;
    char list[30];
    int i, numread, numwritten;
    // ���ı���ʽ���ļ�
    if( (stream = fopen( "bluesky1.wav", "w+t" )) != NULL )  // �����ȡ����
    {
        for ( i = 0; i < 25; i++ )
        list[i] = (char)('z' - i);
        numwritten = fwrite( list, sizeof( char ), 25, stream );
        printf( "Wrote %d items\n", numwritten );
        fclose( stream );
    }
    else
    {
        printf( "Problem opening the file\n" );
    }
    if( (stream = fopen( "bluesky1.wav", "r+t" )) != NULL )  // �ļ���ȡ
    {
        numread = fread( list, sizeof( char ), 25, stream );
        printf( "Number of items read = %d\n", numread );
        printf( "Contents of buffer = %.25s\n", list );
        fclose( stream );
    }
    else
    {
        printf( "File could not be opened\n" );
    }
}
