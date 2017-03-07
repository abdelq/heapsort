/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package heapsort;

/**
 *
 * @author Lena
 */
public class HeapSort {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        int [] a = new int[10];
        a[0] = 56;
        a[1] = 2;
        a[3] = -78;
        a[4] = 100;
        a[5] = 42;
        a[6] = 0;
        a[7] = 99;
        a[8] = -23;
        a[9] = 17;
        HeapSorter hs = new HeapSorter(a);
        hs.sort();
        for(int e: a)
            System.out.println(e);
        
    }
    
}
