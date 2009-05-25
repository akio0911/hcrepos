/* MacでUSB経由にてTDS01Vの値を取得する
*/

#include<stdio.h>
#include<stdlib.h>
#include<strings.h>
#include<termios.h>
#include<unistd.h>
#include<fcntl.h>

#define BAUDRATE B9600           /* 通信速度の設定 */
#define MODEMDEVICE "/dev/tty.usbserial-00001004" /* デバイスファイルの指定 */

#define FALSE 0
#define TRUE 1

volatile int STOP=FALSE;

int main()
  {
    int fd, c, res;                 /* fd:ファイルディスクリプタ res:受け取った文字数 */
    struct termios oldtio, newtio;  /* 通信ポートを制御するためのインターフェイス */
    char buf[255];                 /* 受信文字を格納 */

   if((fd = open(MODEMDEVICE, O_RDWR | O_NOCTTY ))==-1){
   /* O_RDWR:読み書き両用 O_NOCTTY:tty制御をしない */
       perror(MODEMDEVICE);
       exit(-1);
    }

   tcgetattr(fd, &oldtio);         /* 現在のシリアルポートの設定を待避させる*/
   bzero(&newtio, sizeof(newtio)); /* 新しいポートの設定の構造体をクリアする */
   newtio.c_cflag = (BAUDRATE | CRTSCTS | CS8 | CLOCAL | CREAD);

  /*
    BAUDRATE: ボーレートの設定
    CRTSCTS : 出力のハードウェアフロー制御
    CS8     : 8n1 (8 ビット，ノンパリティ，ストップビット 1)
    CLOCAL  : ローカル接続，モデム制御なし
    CREAD   : 受信文字(receiving characters)を有効にする．
  */

   newtio.c_iflag = (IGNPAR | ICRNL);
  /*
    IGNPAR  : パリティエラーのデータは無視する
    ICRNL   : CR を NL に対応させる(これを行わないと，他のコンピュータで
              CR を入力しても，入力が終りにならない)
    それ以外の設定では，デバイスは raw モードである(他の入力処理は行わない)
  */

   newtio.c_oflag = 0;
  /*   Raw モードでの出力 */

   newtio.c_lflag = ICANON;
  /*
    ICANON  : カノニカル入力を有効にする
    全てのエコーを無効にし，プログラムに対してシグナルは送らせない
  */

   tcflush(fd, TCIFLUSH);
   tcsetattr(fd,TCSANOW,&newtio);
  /*  モデムラインをクリアし，ポートの設定を有効にする */

  /*
    端末の設定終了．
    行の先頭に 'z' を入力することでプログラムを終了させる
  */
   puts("START");

   // 計測条件設定
  puts("WRITE");
  sprintf(buf, "050027950000\r\n");
   write(fd,buf,strlen(buf));

   // [ACK 計測条件設定応答]を読み取ってみる
   puts("READ");
   res = read(fd,buf,2);
   puts("AFTER READ");
   printf("res=%d\n", res);
   buf[res]=0;
   printf(":%s:%d\n", buf, res);

if(0){ // ひとまずコメントアウト
   while (STOP==FALSE) {     /* 終了条件が満たされるまでループ */
      puts(".");
//      res = read(fd,buf,255);
      res = read(fd,buf,255);
      buf[--res]=0;             /* 文字列の終端をセットする */
      printf(":%s:%d", buf, res);
      if (buf[0]=='z') STOP=TRUE;
   }
 }
   puts("END");
  tcsetattr(fd, TCSANOW, &oldtio);  /* 退避させた設定に戻す */
  close(fd);                       /* シリアルポートを閉じる */
  return(0);
}
