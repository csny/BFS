//
//  main.m
//  BFS
//
//  Created by macbook on 2014/08/10.
//  Copyright (c) 2014年 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

// 幅優先探索Breadth First Search
const int imax=63; // 最大試行数兼残額
const int coinkind=6; // 硬貨の種類
int coinvalue[coinkind]={1,2,4,8,16,32}; // 各硬貨の額面
int k; // 親ノードの数

/* Queue  First-In First-Out方式 */
const int SIZE = 10000; // キューとして使う配列のサイズ、最後までループするには全然足りない
int q[SIZE]; // キュー本体
NSString *path[SIZE]; // 経路出力用に文字列の配列を用意 キュー本体とほぼ同じ操作をする

// 幅優先探索の関数
// 探索の根幹は#1.2.3.4.5のループ
void bfsearch( int start, int goal )
{
    // キュー入出力用に使う変数。frontは先頭、rearは末尾。
    // rearは次のノードの取り込み位置、frontは親ノード兼次の削除位置として利用
    int rear = 1, front = 0;
    q[front]=start; // 一番最初の親ノード、杜撰な管理でおk
    path[front]=@"残額の経路"; // 一番最初の親ノード、入れるものはぶっちゃけ何でもいい
    while( front < rear ){ // #0.ループ設定 front=rearはキューが空の状態を表す
        if(q[front]!=goal){ // 残額初期値が0=64回目の支払いでキューへの取り込み終了
            for(int i = 0; i < coinkind; i++){ // #1.子ノード取り込み処理開始
                if(q[front]-coinvalue[i]==0){ // #2.条件判定等の処理
                    // 親ノードq[front]を経路出力用に文字列として格納
                    path[rear]=[NSString stringWithFormat:@"%@,%d,%d",path[front],q[front],0];
                    
                    // 探索結果出力
                    NSLog(@"親ノード数%d",k+1);
                    NSLog(@"front:%d, rear:%d",front,rear);
                    NSLog(@"%@",path[rear]);
                    return; // キューのサイズが全然足りないので、答えが出たら探索途中でwhileループ終了
                    
                    // キュー[rear]の位置に残額[front]から硬貨分を引いて格納
                    // キューのサイズ節約のため、残額がマイナスになったらキューに取り込まない
                }else if(q[front]-coinvalue[i]>0){
                    q[rear]=q[front]-coinvalue[i]; // #3.実際に子ノードをキューに取り込む処理
                    // 親ノードq[front]を経路出力用に文字列として格納
                    path[rear]=[NSString stringWithFormat:@"%@,%d",path[front],q[front]];
                    rear++; // #4.キューに取り込んだら、次に取り込む位置に移動
                }
            }
        }
        front++; // #5.キューの先頭の枝１本を探索済み・削除扱いして、次の枝の取り込みへ
        k++;
        
        // キューの配列を１つ前にコピーして、キューの先頭を本当に削除する処理
        // キューのサイズに余裕があれば不要な処理　まぁ焼け石に水
        for(int i=0;i<rear;i++){
            q[i]=q[i+1];
            path[i]=path[i+1];
        }
        rear--;
        front--;
    }
}


int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        bfsearch(63,0);
        
    }
    return 0;
}


