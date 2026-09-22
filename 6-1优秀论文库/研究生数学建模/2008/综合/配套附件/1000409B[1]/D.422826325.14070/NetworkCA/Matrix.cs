using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Drawing.Drawing2D; 
using System.Drawing.Text;
using System.Runtime.InteropServices;

/// <summary>
/// Defination 的摘要说明。
/// </summary>
public class Matrix
{
	public Matrix()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
	//create identity matrix
	public static double[,] IdentityMatrix(int size)
	{
		double[,] E=new double[size,size];
		for(int i=0;i<size;i++)
			E[i,i]=1;
		return E;
	}
	//矩阵的和
	public static double[] Sum(double[,] a) 
	{ 
		double[] c = new double[a.GetLength(1)]; 
		for (int i = 0; i < a.GetLength(0); i++) 
			for (int j = 0; j < a.GetLength(1); j++) 
				c[j]+=a[i,j];			 
				//c[j] = c[j] +a[i,j]; 
		return c; 
	}
	public static double Sum(double[] a) 
	{ 
		double c =0; 
		for (int i = 0; i < a.GetLength(0); i++)				 
				c +=a[i];
		return c; 
	}
	public static int[] Sum(int[,] a) 
	{ 
		int[] c = new int[a.GetLength(1)]; 
		for (int i = 0; i < a.GetLength(0); i++) 
			for (int j = 0; j < a.GetLength(1); j++) 
				c[j]+=a[i,j];			 
		//c[j] = c[j] +a[i,j]; 
		return c; 
	}
	public static int Sum(int[] a) 
	{ 
		int c =0; 
		for (int i = 0; i < a.GetLength(0); i++)				 
			c +=a[i];
		return c; 
	}
    public static int Sum(bool[] a)
    {
        int c = 0;
        for (int i = 0; i < a.GetLength(0); i++)
            if(a[i])
                c ++;
        return c;
    }
	//矩阵的转置
	public static double[,] Transpose(double[,] a) 
	{ 
		double[,] c = new double[a.GetLength(1), a.GetLength(0)]; 
		for (int i = 0; i < a.GetLength(0); i++) 
			for (int j = 0; j < a.GetLength(1); j++) 									 
				c[j, i] = a[i,j]; 
		return c; 
	}
	public static double[,] Transpose(double[] a) 
	{ 
		double[,] c = new double[a.GetLength(0), 1]; 
		for (int i = 0; i < a.GetLength(0); i++)  									 
				c[i,0] = a[i]; 
		return c; 
	}
	//矩阵的加法
	public static double[,] Add(double[,] a,double[,] b) 
	{ 
		if (a.GetLength(0) != b.GetLength(0) || a.GetLength(1) != b.GetLength(1)) 
			return new double[0,0];
		double[,] c = new double[a.GetLength(0), a.GetLength(1)]; 
		for (int i = 0; i < a.GetLength(0); i++) 
			for (int j = 0; j < a.GetLength(1); j++) 									 
				c[i,j] = a[i,j]+b[i,j];
		return c;
	}

	public static double[,] Add(double[,] a,double b) 
	{ 			
		double[,] c = new double[a.GetLength(0), a.GetLength(1)]; 
		for (int i = 0; i < a.GetLength(0); i++) 
			for (int j = 0; j < a.GetLength(1); j++) 									 
				c[i,j] = a[i,j]+b;
		return c;
	}
	public static double[] Add(double[] a,double[] b) 
	{ 			
		if(a.GetLength(0)!=b.GetLength(0)) return null;
		double[] c = new double[a.GetLength(0)]; 
		for (int i = 0; i < a.GetLength(0); i++) 											 
			c[i] = a[i]+b[i];
		return c;
	}

	public static double[,] Add(double b,double[,] a) 
	{ 			
		double[,] c = new double[a.GetLength(0), a.GetLength(1)]; 
		for (int i = 0; i < a.GetLength(0); i++) 
			for (int j = 0; j < a.GetLength(1); j++) 									 
				c[i,j] = a[i,j]+b;
		return c;
	}
	//矩阵的减法
	public static double[,] Minus(double[,] a,double[,] b) 
	{ 
		if (a.GetLength(0) != b.GetLength(0) || a.GetLength(1) != b.GetLength(1)) 
			return new double[0,0];
		double[,] c = new double[a.GetLength(0), a.GetLength(1)]; 
		for (int i = 0; i < a.GetLength(0); i++) 
			for (int j = 0; j < a.GetLength(1); j++) 									 
				c[i,j] = a[i,j]-b[i,j];
		return c;
	}
	public static double[] OneDimension(double[,] a)
	{
		int row=a.GetLength(0);
		int col=a.GetLength(1);
		double[] b=new double[row*col];
		for(int i=0;i<row;i++)
			for(int j=0;j<col;j++)
				b[i*col+j]=a[i,j];
		return b;
	}
	public static double[,] Minus(double[,] a,double b) 
	{ 			
		double[,] c = new double[a.GetLength(0), a.GetLength(1)]; 
		for (int i = 0; i < a.GetLength(0); i++) 
			for (int j = 0; j < a.GetLength(1); j++) 									 
				c[i,j] = a[i,j]-b;
		return c;
	}
	public static int[] DescentOrder(double[] a)
	{
		double[] b=Matrix.Copy(a);
		double p;
		int i,j,n;
		int[] order=new int[a.GetLength(0)];
		for(i=0;i<a.GetLength(0);i++)		
			order[i]=i;
		for(i=0;i<a.GetLength(0);i++)
		{
			for(j=i+1;j<a.GetLength(0);j++)
			{
				if(b[i]<b[j])
				{
					p=b[i];
					b[i]=b[j];
					b[j]=p;

					n=order[i];
					order[i]=order[j];
					order[j]=n;
				}
			}
		}
		return order;
	}
	public static int[] AscentOrder(double[] a)
	{
		double[] b=Matrix.Copy(a);
		double p;
		int i,j,n;
		int[] order=new int[a.GetLength(0)];
		for(i=0;i<a.GetLength(0);i++)		
			order[i]=i;
		for(i=0;i<a.GetLength(0);i++)
		{
			for(j=i+1;j<a.GetLength(0);j++)
			{
				if(b[i]>b[j])
				{
					p=b[i];
					b[i]=b[j];
					b[j]=p;

					n=order[i];
					order[i]=order[j];
					order[j]=n;
				}
			}
		}
		return order;
	}
	public static double[,] Minus(double b,double[,] a) 
	{ 			
		double[,] c = new double[a.GetLength(0), a.GetLength(1)]; 
		for (int i = 0; i < a.GetLength(0); i++) 
			for (int j = 0; j < a.GetLength(1); j++) 									 
				c[i,j] = b-a[i,j];
		return c;
	}
	public static double[] Minus(double[] a,double[] b) 
	{ 			
		if(a.GetLength(0)!=b.GetLength(0))
			return null;
		double[] c = new double[a.GetLength(0)]; 
		for (int i = 0; i < a.GetLength(0); i++)
			c[i]=a[i]-b[i];
		return c;
	}
	//矩阵的数乘
	public static double[,] NumericalMultiply(double[,] a,double[,] b) 
	{ 
		if (a.GetLength(0) != b.GetLength(0) || a.GetLength(1) != b.GetLength(1)) 
			return new double[0,0];
		double[,] c = new double[a.GetLength(0), a.GetLength(1)]; 
		for (int i = 0; i < a.GetLength(0); i++) 
			for (int j = 0; j < a.GetLength(1); j++) 									 
				c[i,j] = a[i,j]*b[i,j];
		return c;
	}
	//矩阵的乘法
	public static double[,] Multiply(double[,] a,double[,] b) 
	{ 
		int i,j;
		if (a.GetLength(1) != b.GetLength(0)) 
			return new double[0,0];
		double[,] c = new double[a.GetLength(0), b.GetLength(1)];
		for ( i = 0; i < a.GetLength(0); i++)
			for(int k=0; k < b.GetLength(1) ;k++)
				for ( j = 0; j < a.GetLength(1); j++)
					c[i,k] += a[i,j]*b[j,k];
		return c;
	}

	public static double[,] Multiply(double[,] a,double b) 
	{ 
		int i,j;
		double[,] c = new double[a.GetLength(0), a.GetLength(1)];
		for ( i = 0; i < a.GetLength(0); i++)
				for ( j = 0; j < a.GetLength(1); j++)
					c[i,j] =b * a[i,j];
		return c;
	}

	public static double[,] Multiply(double b, double[,] a) 
	{ 
		int i,j;
		double[,] c = new double[a.GetLength(0), a.GetLength(1)];
		for ( i = 0; i < a.GetLength(0); i++)
			for ( j = 0; j < a.GetLength(1); j++)
				c[i,j] =b * a[i,j];
		return c;
	}
	public static double[] Multiply(double b, double[] a) 
	{ 
		int i;
		double[] c = new double[a.GetLength(0)];
		for ( i = 0; i < a.GetLength(0); i++)				
				c[i] =b * a[i];
		return c;
	}
	public static double[,] Multiply(double[] a,double[,] b) 
	{ 
		int i,j;
		if (a.GetLength(0) != b.GetLength(0)) 
			return new double[0,0];
		double[,] c = new double[1, b.GetLength(1)];
		for ( i = 0; i < 1; i++)
			for(int k=0; k < b.GetLength(1) ;k++)
				for ( j = 0; j < a.GetLength(0); j++)
					c[i,k] += a[j]*b[j,k];
		return c;
	}
	public static double Multiply(double[] a,double[] b) 
	{ 
		int i;
		if (a.GetLength(0) != b.GetLength(0)) 
			return double.NaN;
		double c=0;
		for(i=0;i<a.GetLength(0);i++)
			c+=a[i]*b[i];
		return c;
	}
	//矩阵的逆
	public static double[,] Inverse(double[,] A)
	{
		int i,j,k;
		double lMax,temp;

		int RC=A.GetLength(0);
		if (A.GetLength(1) != A.GetLength(0)) 
			return new double[0,0];
		double[,] tt = new double[RC, RC];
		double[,] B = new double[RC, RC];
		//临时矩阵存放A			
		for(i=0;i<RC;i++)
			for(j=0;j<RC;j++)
				tt[i,j] = A[i,j];
		//初始化B为单位阵
		for(i=0;i<RC;i++)
			B[i,i]=1;
		//
		for(i=0;i<RC;i++)
		{
			//寻找主元
			lMax = tt[i,i];
			k = i;
			for(j=i+1;j<RC;j++) //扫描从i+1到n的各行
			{
				if( tt[j,i]*tt[j,i] > lMax*lMax)
				{
					lMax = tt[j,i];
					k = j;
				}
			}
			//如果主元所在行不是第i行，进行行交换
			if(k!=i)
			{
				for(j=0;j<RC;j++)
				{
					temp = tt[i,j] ;
					tt[i,j] = tt[k,j];
					tt[k,j] = temp;
					//B伴随计算
					temp = B[i,j];
					B[i,j] = B[k,j];
					B[k,j] = temp;
				}
			}
			//判断主元是否是0，如果是，则矩阵A不是满秩矩阵，不存在逆矩阵
			if(tt[i,i] == 0)   return new double[0,0];
			//消去A的第i列除去i行以外的各行元素
			temp = tt[i,i];
			for(j=0;j<RC;j++)
			{
				tt[i,j] = tt[i,j] / temp; //主对角线上元素变成1
				B[i,j] = B[i,j] / temp; //伴随计算
			}

			for(j=0;j<RC;j++) //行 0 -> n
			{
				if(j!=i)  //不是第i行
				{
					temp = tt[j,i];
					for(k=0;k<RC;k++) // j行元素 - i行元素* j行i列元素
					{
						tt[j,k] = tt[j,k] - tt[i,k] * temp;
						B[j,k] = B[j,k] - B[i,k] * temp;
					}
				}
			}
		}
		return B;	
	}
	public static double[,] Random(int row,int col)
	{
		double [,] A=new double[row,col];
		Random r = new Random(); //产生随机数
		
		for(int i=0;i<row;i++)
			for(int j=0;j<col;j++)
				A[i,j]=r.NextDouble();
		return A;
	}
	public static bool IfEqual(int[] A,int[] B)
	{
		if(A.GetLength(0)!=B.GetLength(0))
			return false;
		for(int i=0;i<A.GetLength(0);i++)
			if(A[i]!=B[i])
				return false;
		return true;
	}
	public static bool IfEqual(double[] A,double[] B)
	{
		if(A.GetLength(0)!=B.GetLength(0))
			return false;
		for(int i=0;i<A.GetLength(0);i++)
			if(A[i]!=B[i])
				return false;
		return true;
	}
	public static bool IfEqual(int[,] A,int[,] B)
	{
		if(A.GetLength(0)!=B.GetLength(0))
			return false;
		if(A.GetLength(1)!=B.GetLength(1))
			return false;
		for(int i=0;i<A.GetLength(0);i++)
			for(int j=0;j<A.GetLength(1);j++)
				if(A[i,j]!=B[i,j])
					return false;
		return true;
	}
	public static bool IfEqual(double[,] A,double[,] B)
	{
		if(A.GetLength(0)!=B.GetLength(0))
			return false;
		if(A.GetLength(1)!=B.GetLength(1))
			return false;
		for(int i=0;i<A.GetLength(0);i++)
			for(int j=0;j<A.GetLength(1);j++)
				if(A[i,j]!=B[i,j])
					return false;
		return true;
	}
	public static int[] Equal(int[] A)
	{
		int[] B=new int[A.GetLength(0)];
		for(int i=0;i<A.GetLength(0);i++)
			B[i]=A[i];
		return B;
	}
	public static int[,] Equal(int[,] A)
	{
		int[,] B=new int[A.GetLength(0),A.GetLength(1)];
		for(int i=0;i<A.GetLength(0);i++)
			for(int j=0;j<A.GetLength(1);j++)
				B[i,j]=A[i,j];
		return B;
	}
	public static double[] Equal(double[] A)
	{
		double[] B=new double[A.GetLength(0)];
		for(int i=0;i<A.GetLength(0);i++)
			B[i]=A[i];
		return B;
	}

	public static double[,] Equal(double[,] A)
	{
		double[,] B=new double[A.GetLength(0),A.GetLength(1)];
		for(int i=0;i<A.GetLength(0);i++)
			for(int j=0;j<A.GetLength(1);j++)
				B[i,j]=A[i,j];
		return B;
	}
	public static int Max(int[] A)
	{
		int B=-int.MaxValue;
		for(int i=0;i<A.GetLength(0);i++)
			if(B<A[i])
				B=A[i];
		return B;
	}
	public static double Max(double[] A)
	{
		double B=-double.MaxValue;
		for(int i=0;i<A.GetLength(0);i++)
			if(B<A[i])
				B=A[i];
		return B;
	}
	public static int Min(int[] A)
	{
		int B=int.MaxValue;
		for(int i=0;i<A.GetLength(0);i++)
			if(B>A[i])
				B=A[i];
		return B;
	}
	public static double Min(double[] A)
	{
		double B=double.MaxValue;
		for(int i=0;i<A.GetLength(0);i++)
			if(B>A[i])
				B=A[i];
		return B;
	}
	public static int[] Copy(int[] A)
	{
		int[] B=new int[A.GetLength(0)];
		for(int i=0;i<A.GetLength(0);i++)
			B[i]=A[i];
		return B;
	}
	public static int[,] Copy(int[,] A)
	{
		int[,] B=new int[A.GetLength(0),A.GetLength(1)];
		for(int i=0;i<A.GetLength(0);i++)
			for(int j=0;j<A.GetLength(1);j++)
				B[i,j]=A[i,j];
		return B;
	}
    public static bool[] Copy(bool[] A)
    {
        bool[] B = new bool[A.GetLength(0)];
        for (int i = 0; i < A.GetLength(0); i++)
            B[i] = A[i];
        return B;
    }
    public static bool[,] Copy(bool[,] A)
    {
        bool[,] B = new bool[A.GetLength(0), A.GetLength(1)];
        for (int i = 0; i < A.GetLength(0); i++)
            for (int j = 0; j < A.GetLength(1); j++)
                B[i, j] = A[i, j];
        return B;
    }
	public static double[] Copy(double[] A)
	{
		double[] B=new double[A.GetLength(0)];
		for(int i=0;i<A.GetLength(0);i++)
			B[i]=A[i];
		return B;
	}
	public static double[,] Copy(double[,] A)
	{
		double[,] B=new double[A.GetLength(0),A.GetLength(1)];
		for(int i=0;i<A.GetLength(0);i++)
			for(int j=0;j<A.GetLength(1);j++)
				B[i,j]=A[i,j];
		return B;
	}
	public static double[] Sort(double[] A,bool ascend)
	{
		double p;
		int i,j;
		double [] B=new double[A.GetLength(0)];
		for(i=0;i<A.GetLength(0);i++)
			B[i]=A[i];
		for(i=0;i<A.GetLength(0)-1;i++)
		{
			for(j=i+1;j<A.GetLength(0);j++)
			{
				if(ascend && B[i]>B[j])//按照升序
				{
					p=B[i];
					B[i]=B[j];
					B[j]=p;
				}
				else if(!ascend && B[i]<B[j])//按照降序
				{
					p=B[i];
					B[i]=B[j];
					B[j]=p;
				}
			}
		}
		return B;
	}
	public static void Output(double[] A,String DataPath)
	{
		StreamWriter sr = File.CreateText(DataPath);
		for(int i=0;i<A.GetLength(0);i++)
			sr.WriteLine(A[i].ToString());
		sr.Close();
	}
	public static void Output(int[] A,String DataPath)
	{
		StreamWriter sr = File.CreateText(DataPath);
		for(int i=0;i<A.GetLength(0);i++)
			sr.WriteLine(A[i].ToString());
		sr.Close();
	}

	public static void Output(double[,] A,char SeparateChar,String DataPath)
	{
		StreamWriter sr = File.CreateText(DataPath);
		StringBuilder sb=new StringBuilder();
		for(int i=0;i<A.GetLength(0);i++)
		{
			sb.Remove(0,sb.Length);
			for(int j=0;j<A.GetLength(1);j++)
			{
				sb.Append(A[i,j].ToString());
                sb.Append(SeparateChar);
			}
			sb.Remove(sb.Length-1,1);
			sr.WriteLine(sb.ToString());
		}				
		sr.Close();			
	}
    public static void OutputAppend(double[,] A, char SeparateChar, String DataPath)
    {
        StreamWriter sr;
        if (File.Exists(DataPath))
            sr =  File.AppendText(DataPath);
        else
            sr = File.CreateText(DataPath);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < A.GetLength(0); i++)
        {
            sb.Remove(0, sb.Length);
            for (int j = 0; j < A.GetLength(1); j++)
            {
                sb.Append(A[i, j].ToString());
                sb.Append(SeparateChar);
            }
            sb.Remove(sb.Length - 1, 1);
            sr.WriteLine(sb.ToString());
        }
        sr.Close();
    }
    public static void OutputAppend(double[] A, String DataPath)
    {
        StreamWriter sr;
        if (File.Exists(DataPath))
            sr=File.AppendText(DataPath);
        else
            sr = File.CreateText(DataPath);
        StringBuilder sb = new StringBuilder();
        for (int j = 0; j < A.GetLength(0); j++)
        {
            sb.Append(A[j].ToString());
            sb.Append('\t');
        }
        sb.Remove(sb.Length - 1, 1);
        sr.WriteLine(sb.ToString());

        sr.Close();
    }
	public static void Output(int[,] A,char SeparateChar,String DataPath)
	{
		StreamWriter sr = File.CreateText(DataPath);
		StringBuilder sb=new StringBuilder();
		for(int i=0;i<A.GetLength(0);i++)
		{
			sb.Remove(0,sb.Length);
			for(int j=0;j<A.GetLength(1);j++)
			{
				sb.Append(A[i,j].ToString());
				sb.Append('\t');
			}
			sb.Remove(sb.Length-1,1);
			sr.WriteLine(sb.ToString());
		}				
		sr.Close();
					
	}
    public static double OneModel(double[] A, double[] B)
    {
        double erro=0;
        if (A.GetLength(0) != B.GetLength(0)) return double.MaxValue;
        for (int i = 0; i < A.GetLength(0); i++)
            if (erro < Math.Abs(A[i] - B[i]))
                erro = Math.Abs(A[i] - B[i]);
        return erro;
    }
    public static double OneModel(double[] A)
    {
        double erro = 0;        
        for (int i = 0; i < A.GetLength(0); i++)
            if (erro < Math.Abs(A[i]))
                erro = Math.Abs(A[i]);
        return erro;
    }
    public static void Superaddition(double[,] A, char SeparateChar,String DataPath)
	{
		StreamWriter sr;
		if (!File.Exists(DataPath)) 			
			sr=File.CreateText(DataPath);
		else
				sr=File.AppendText(DataPath);
		StringBuilder sb=new StringBuilder();
		for(int i=0;i<A.GetLength(0);i++)
		{
			sb.Remove(0,sb.Length);
			for(int j=0;j<A.GetLength(1);j++)
			{
				sb.Append(A[i,j].ToString());
				sb.Append('\t');
			}
			sb.Remove(sb.Length-1,1);
			//sr.w
			sr.WriteLine(sb.ToString());
		}				
		sr.Close();
				
	}
	//对线段画箭头
	public static Point[] GetArrowDirectionPoint(Point originPoint,Point destinatePoint,double angle,double length)
	{
		double directAngle=0;
		Point[] arrowPoint=new Point[2];
		PointF direction =new PointF(originPoint.X-destinatePoint.X,originPoint.Y-destinatePoint.Y);
		if(direction.X<0)
		{
			directAngle=Math.PI;
			directAngle-=Math.Atan(-direction.Y/direction.X);
		}
		else if(direction.X==0)
		{
			if(direction.Y>0)
				directAngle=Math.PI/2;
			else
				directAngle=-Math.PI/2;
		}
		else
			directAngle=Math.Atan(direction.Y/direction.X);
		//下面得到点
		arrowPoint[0].Y=(int)(length*Math.Sin(directAngle-angle))+destinatePoint.Y;
		arrowPoint[0].X=(int)(length*Math.Cos(directAngle-angle))+destinatePoint.X;

		arrowPoint[1].Y=(int)(length*Math.Sin(directAngle+angle))+destinatePoint.Y;
		arrowPoint[1].X=(int)(length*Math.Cos(directAngle+angle))+destinatePoint.X;
		return arrowPoint;
	}
	//画曲线图
	public static Bitmap DrawCurve1(Rectangle maprect,double[,] xy, String[] name,int lineType)
	{
		
		double rateX,rateY;
		double maxX=-double.MaxValue,maxY=-double.MaxValue,minX=double.MaxValue,minY=double.MaxValue;
		int num=xy.GetLength(0);//数据量
		int i;
		int left=20,bottom=10;//用于坐标轴标记
		for(i=0;i<num;i++)
		{
			if(xy[i,0]<minX) minX=xy[i,0];
			if(xy[i,0]>maxX) maxX=xy[i,0];
			if(xy[i,1]<minY) minY=xy[i,1];
			if(xy[i,1]>maxY) maxY=xy[i,1];
		}
		//确定中位数
		rateX=maxX/(maprect.Width-2*left);
		rateY=maxY/(maprect.Height-2*bottom);
		//
		Point origin=new Point(maprect.Left-left,maprect.Height-bottom);//原点

		Bitmap bmp=new Bitmap(maprect.Width,maprect.Height);
		Graphics gImage=Graphics.FromImage(bmp);
		gImage.SmoothingMode=SmoothingMode.AntiAlias;

		//白底
		Rectangle rect=new Rectangle(new Point(0,0),bmp.Size);			
		SolidBrush backBrush=new SolidBrush(Color.White);
		gImage.FillRectangle(backBrush,rect);
		backBrush.Dispose();


		//画坐标轴
		Pen axisPen=new Pen(Color.Red,1);
		Point[] arrowPoint=new Point[2]; 
		//x轴
		Point originPoint=new Point(origin.X,origin.Y);
		Point destinatePoint=new Point(maprect.Right-left/2,origin.Y);			
		gImage.DrawLine(axisPen,originPoint,destinatePoint);
		//箭头
		//画箭头				
		arrowPoint=GetArrowDirectionPoint(originPoint,destinatePoint,Math.PI/15,12);
		gImage.DrawLine(axisPen,arrowPoint[0],destinatePoint);
		gImage.DrawLine(axisPen,arrowPoint[1],destinatePoint);
		//y轴
		originPoint=new Point(origin.X,origin.Y);
		destinatePoint=new Point(origin.X,maprect.Top+bottom/2);			
		gImage.DrawLine(axisPen,originPoint,destinatePoint);
		//箭头
		//画箭头				
		arrowPoint=GetArrowDirectionPoint(originPoint,destinatePoint,Math.PI/15,12);
		gImage.DrawLine(axisPen,arrowPoint[0],destinatePoint);
		gImage.DrawLine(axisPen,arrowPoint[1],destinatePoint);
		//描点
		Pen curvePen=new Pen(Color.Brown,1);
		for(i=0;i<num-1;i++)
		{
			//
			originPoint=new Point();
			originPoint.X=origin.X+(int)(rateX*xy[i,0]);
			originPoint.Y=origin.Y+(int)(rateY*xy[i,1]);
			destinatePoint=new Point();
			destinatePoint.X=origin.X+(int)(rateX*xy[i+1,0]);
			destinatePoint.Y=origin.Y+(int)(rateY*xy[i+1,1]);
			gImage.DrawLine(curvePen,originPoint,destinatePoint);
		}
		axisPen.Dispose();
		curvePen.Dispose();
		return bmp;
	}

	public static Bitmap DrawCurve(Rectangle maprect,double[,] xy, String[] name,double[] zoom)
	{
		
		double rateX,rateY;
		double maxX=-double.MaxValue,maxY=-double.MaxValue,minX=double.MaxValue,minY=double.MaxValue;
		int num=xy.GetLength(0);//数据量
		int i;
		int left=30,bottom=10;//用于坐标轴标记
		for(i=0;i<num;i++)
		{
			xy[i,0]*=zoom[0];//放大
			xy[i,1]*=zoom[1];
			if(xy[i,0]<minX) minX=xy[i,0];
			if(xy[i,0]>maxX) maxX=xy[i,0];
			if(xy[i,1]<minY) minY=xy[i,1];
			if(xy[i,1]>maxY) maxY=xy[i,1];
		}
		//确定中位数
		if(maprect.Width>maprect.Height)
			left=(maprect.Width-maprect.Height)/2+bottom;
		else
			bottom=(maprect.Height-maprect.Width)/2+left;
		rateX=(maprect.Width-2*left)/maxX;
		rateY=(maprect.Height-2*bottom)/maxY;
		//
		Point origin=new Point(left,maprect.Height-bottom);//原点

		Bitmap bmp=new Bitmap(maprect.Width,maprect.Height);
		Graphics gImage=Graphics.FromImage(bmp);
		gImage.SmoothingMode=SmoothingMode.AntiAlias;

		//白底
		Rectangle rect=new Rectangle(new Point(0,0),bmp.Size);			
		SolidBrush backBrush=new SolidBrush(Color.White);
		gImage.FillRectangle(backBrush,rect);
		backBrush.Dispose();


		//画坐标轴
		Pen axisPen=new Pen(Color.Black,1);
		Point[] arrowPoint=new Point[2]; 
		//x轴
		Font nameFont=new Font("Times New Roman",12);
		SolidBrush textShadowBrush = new SolidBrush(Color.FromArgb(100, Color.Black));
		StringFormat pFormat=new StringFormat();
		pFormat.Alignment= StringAlignment.Center;
		pFormat.LineAlignment=StringAlignment.Near;

		Point originPoint=new Point(origin.X,origin.Y);
		Point destinatePoint=new Point(maprect.Width-left/2,origin.Y);			
		gImage.DrawLine(axisPen,originPoint,destinatePoint);
		//箭头
		//画箭头				
		arrowPoint=GetArrowDirectionPoint(originPoint,destinatePoint,Math.PI/15,12);
		gImage.DrawLine(axisPen,arrowPoint[0],destinatePoint);
		gImage.DrawLine(axisPen,arrowPoint[1],destinatePoint);
		gImage.DrawString(name[0],nameFont,textShadowBrush,destinatePoint.X-2,destinatePoint.Y,pFormat);

		//x轴刻度
		for(i=1;i<300;i++)
		{
			if(i*10>maxX) break;
			originPoint=new Point((int)(origin.X+i*10*rateX),origin.Y);
			if(i%5==0)
			{
				destinatePoint=new Point((int)(origin.X+i*10*rateX),originPoint.Y-12);
				gImage.DrawString((i*10.0/zoom[0]).ToString(),nameFont,textShadowBrush,originPoint.X,originPoint.Y,pFormat);
			}
			else
				destinatePoint=new Point((int)(origin.X+i*10*rateX),originPoint.Y-4);
			gImage.DrawLine(axisPen,originPoint,destinatePoint);
			
		}
		pFormat.Dispose();
		textShadowBrush.Dispose();
		nameFont.Dispose();

		//y轴
		nameFont=new Font("Times New Roman",12);
		textShadowBrush = new SolidBrush(Color.FromArgb(100, Color.Black));
		pFormat=new StringFormat();
		pFormat.Alignment= StringAlignment.Far;
		pFormat.LineAlignment=StringAlignment.Center;
		originPoint=new Point(origin.X,origin.Y);
		destinatePoint=new Point(origin.X,bottom/2);			
		gImage.DrawLine(axisPen,originPoint,destinatePoint);			
		//箭头
		//画箭头				
		arrowPoint=GetArrowDirectionPoint(originPoint,destinatePoint,Math.PI/15,12);
		gImage.DrawLine(axisPen,arrowPoint[0],destinatePoint);
		gImage.DrawLine(axisPen,arrowPoint[1],destinatePoint);
		
		//坐标轴的名称
		gImage.DrawString(name[1],nameFont,textShadowBrush,destinatePoint.X,destinatePoint.Y+5,pFormat);

		//y轴刻度
		for(i=1;i<300;i++)
		{
			if(i>maxY) break;
			originPoint=new Point(origin.X,(int)(origin.Y-rateY*i));
			if(i%5==0)
			{
				destinatePoint=new Point(origin.X+12,originPoint.Y);
				gImage.DrawString((i*1.0/zoom[1]).ToString(),nameFont,textShadowBrush,originPoint.X,originPoint.Y,pFormat);
			}
			else
				destinatePoint=new Point(origin.X+4,originPoint.Y);
			gImage.DrawLine(axisPen,originPoint,destinatePoint);
			
		}
		pFormat.Dispose();
		textShadowBrush.Dispose();
		nameFont.Dispose();
		//描点
		Pen curvePen=new Pen(Color.Brown,1);
		for(i=0;i<num-1;i++)
		{
			//
			originPoint=new Point();
			originPoint.X=origin.X+(int)(rateX*xy[i,0]);
			originPoint.Y=origin.Y-(int)(rateY*xy[i,1]);
			destinatePoint=new Point();
			destinatePoint.X=origin.X+(int)(rateX*xy[i+1,0]);
			destinatePoint.Y=origin.Y-(int)(rateY*xy[i+1,1]);
			gImage.DrawLine(curvePen,originPoint,destinatePoint);
		}
		axisPen.Dispose();
		curvePen.Dispose();
		return bmp;
	}
	public static Bitmap DrawCurve(Rectangle maprect,ArrayList m_PointSet, String[] name,double[] zoom)
	{
		
		double[,] xy;
		double rateX,rateY;
		double maxX=-double.MaxValue,maxY=-double.MaxValue,minX=double.MaxValue,minY=double.MaxValue;			
		int i;
		int left=30,bottom=10;//用于坐标轴标记
		int group;
		Color[] colorSet= new Color[5];
		colorSet[0]=Color.Red;
		colorSet[1]=Color.Yellow;
		colorSet[2]=Color.Green;
		colorSet[3]=Color.Blue;
		colorSet[4]=Color.Brown;
		
		for(group=0;group<m_PointSet.Count;group++)
		{
			xy=(double[,])m_PointSet[group];
			for(i=0;i<xy.GetLength(0);i++)
			{
				xy[i,0]*=zoom[0];//放大
				xy[i,1]*=zoom[1];
				if(xy[i,0]<minX) minX=xy[i,0];
				if(xy[i,0]>maxX) maxX=xy[i,0];
				if(xy[i,1]<minY) minY=xy[i,1];
				if(xy[i,1]>maxY) maxY=xy[i,1];
			}
		}
		//确定中位数
		if(maprect.Width>maprect.Height)
			left=(maprect.Width-maprect.Height)/2+bottom;
		else
			bottom=(maprect.Height-maprect.Width)/2+left;
		if(maxX==0)
			rateX=100;
		else
			rateX=(maprect.Width-2*left)/maxX;
		if(maxY==0)
			rateY=100;
		else
			rateY=(maprect.Height-2*bottom)/maxY;
		//
		Point origin=new Point(left,maprect.Height-bottom);//原点

		Bitmap bmp=new Bitmap(maprect.Width,maprect.Height);
		Graphics gImage=Graphics.FromImage(bmp);
		gImage.SmoothingMode=SmoothingMode.AntiAlias;

		//白底
		Rectangle rect=new Rectangle(new Point(0,0),bmp.Size);			
		SolidBrush backBrush=new SolidBrush(Color.White);
		gImage.FillRectangle(backBrush,rect);
		backBrush.Dispose();


		//画坐标轴
		Pen axisPen=new Pen(Color.Black,1);
		Point[] arrowPoint=new Point[2]; 
		//x轴
		Font nameFont=new Font("Times New Roman",12);
		SolidBrush textShadowBrush = new SolidBrush(Color.FromArgb(100, Color.Black));
		StringFormat pFormat=new StringFormat();
		pFormat.Alignment= StringAlignment.Center;
		pFormat.LineAlignment=StringAlignment.Near;

		Point originPoint=new Point(origin.X,origin.Y);
		Point destinatePoint=new Point(maprect.Width-left/2,origin.Y);			
		gImage.DrawLine(axisPen,originPoint,destinatePoint);
		//箭头
		//画箭头				
		arrowPoint=GetArrowDirectionPoint(originPoint,destinatePoint,Math.PI/15,12);
		gImage.DrawLine(axisPen,arrowPoint[0],destinatePoint);
		gImage.DrawLine(axisPen,arrowPoint[1],destinatePoint);
		gImage.DrawString(name[0],nameFont,textShadowBrush,destinatePoint.X-2,destinatePoint.Y,pFormat);

		//x轴刻度
		for(i=1;i<300;i++)
		{
			if(i*10>maxX) break;
			originPoint=new Point((int)(origin.X+i*10*rateX),origin.Y);
			if(i%5==0)
			{
				destinatePoint=new Point((int)(origin.X+i*10*rateX),originPoint.Y-12);
				gImage.DrawString((i*10.0/zoom[0]).ToString(),nameFont,textShadowBrush,originPoint.X,originPoint.Y,pFormat);
			}
			else
				destinatePoint=new Point((int)(origin.X+i*10*rateX),originPoint.Y-4);
			gImage.DrawLine(axisPen,originPoint,destinatePoint);
			
		}
		pFormat.Dispose();
		textShadowBrush.Dispose();
		nameFont.Dispose();

		//y轴
		nameFont=new Font("Times New Roman",12);
		textShadowBrush = new SolidBrush(Color.FromArgb(100, Color.Black));
		pFormat=new StringFormat();
		pFormat.Alignment= StringAlignment.Far;
		pFormat.LineAlignment=StringAlignment.Center;
		originPoint=new Point(origin.X,origin.Y);
		destinatePoint=new Point(origin.X,bottom/2);			
		gImage.DrawLine(axisPen,originPoint,destinatePoint);			
		//箭头
		//画箭头				
		arrowPoint=GetArrowDirectionPoint(originPoint,destinatePoint,Math.PI/15,12);
		gImage.DrawLine(axisPen,arrowPoint[0],destinatePoint);
		gImage.DrawLine(axisPen,arrowPoint[1],destinatePoint);
		
		//坐标轴的名称
		gImage.DrawString(name[1],nameFont,textShadowBrush,destinatePoint.X,destinatePoint.Y+5,pFormat);

		//y轴刻度
		for(i=1;i<300;i++)
		{
			if(i>maxY) break;
			originPoint=new Point(origin.X,(int)(origin.Y-rateY*i));
			if(i%5==0)
			{
				destinatePoint=new Point(origin.X+12,originPoint.Y);
				gImage.DrawString((i*1.0/zoom[1]).ToString(),nameFont,textShadowBrush,originPoint.X,originPoint.Y,pFormat);
			}
			else
				destinatePoint=new Point(origin.X+4,originPoint.Y);
			gImage.DrawLine(axisPen,originPoint,destinatePoint);
			
		}
		pFormat.Dispose();
		textShadowBrush.Dispose();
		nameFont.Dispose();
		//描点
		Pen curvePen;
		for(group=0;group<m_PointSet.Count;group++)
		{
			xy=(double[,])m_PointSet[group];
			int num=xy.GetLength(0);//数据量
			if(group<colorSet.GetLength(0))
				curvePen=new Pen(colorSet[group],1);
			else
				curvePen=new Pen(Color.YellowGreen,1);
			for(i=0;i<num-1;i++)
			{					
				originPoint=new Point();
				originPoint.X=origin.X+(int)(rateX*xy[i,0]);
				originPoint.Y=origin.Y-(int)(rateY*xy[i,1]);
				destinatePoint=new Point();
				destinatePoint.X=origin.X+(int)(rateX*xy[i+1,0]);
				destinatePoint.Y=origin.Y-(int)(rateY*xy[i+1,1]);
				gImage.DrawLine(curvePen,originPoint,destinatePoint);
			}
			curvePen.Dispose();
		}
		axisPen.Dispose();			
		return bmp;
	}
	public static double SquareNormal2( double[] a)
	{
		double norm=0;
		for(int i=0;i<a.GetLength(0);i++)
			norm+=a[i]*a[i];
		return norm;
	}
	public static double SquareNormal( double[] a)
	{
		double norm=0;
		for(int i=0;i<a.GetLength(0);i++)
			norm+=a[i]*a[i];
		norm=Math.Sqrt(norm);
		return norm;
	}
    public static void LoadData(ref double[] loaddata, String datapath)
    {
        if (!File.Exists(datapath))
        {
            Console.WriteLine("{0} does not exist!", datapath);
            return ;
        }
        StreamReader sr = File.OpenText(datapath);
        int row;
        String input;       
      
        row = 0;  
        while ((input = sr.ReadLine()) != null)
        {          
            row++;
        }
        sr.Close();
        loaddata = new double[row];
        sr = File.OpenText(datapath);
        row = 0;
        while ((input = sr.ReadLine()) != null)
        {
            loaddata[row] = Convert.ToDouble(input);           
            row++;
        }
        sr.Close();
     
    }
    public static double[,] LoadData(String datapath,char SeparateChar)
	{
		if (!File.Exists(datapath)) 
		{
			Console.WriteLine("{0} does not exist!", datapath);
			return null;
		}
		StreamReader sr = File.OpenText(datapath);
		int row,col;
		String input;	
		String[] Data=null;
		int i;
		row=0;
		col=0;
		while ((input=sr.ReadLine())!=null) 
		{	
			Data=input.Split(SeparateChar);
			if(col<Data.GetLength(0))
				col=Data.GetLength(0);
			row++;
		}
		sr.Close();
		double[,] loaddata=new double[row,col];
		sr = File.OpenText(datapath);
		row=0;
		while ((input=sr.ReadLine())!=null) 
		{	
			Data=input.Split(SeparateChar);
			for(i=0;i<Data.GetLength(0);i++)
				loaddata[row,i]=Convert.ToDouble(Data[i]);
			row++;
		}
		sr.Close();
		return loaddata;
	}
	public static double dijktra(ref int[] pRoute, double[,] netCostMatrix, int s,int d)
	{
		int n=netCostMatrix.GetLength(1);			
		if(s==d)
		{		
			return(0);
		}
		int i,h,u,p,v;
		double cost;
		int[] visited=new int[n];
		int[] parent=new int[n];
		double[] distance=new double[n];
		double[] temp=new double[n];			
		for(i=0;i<n;i++)
		{
			visited[i]=0;
			distance[i] = double.MaxValue;
			parent[i]=-1;
			temp[0]=-1;
		}
		distance[s] = 0;		
		//////////////////////////////////
		for (i=0;i<n-1;i++)
		{		
			u=-1;cost=double.MaxValue;
			for(h=0;h<n;h++)
			{
				if(visited[h] == 0)
					temp[h]=distance[h];
				else
					temp[h]=double.MaxValue;
				if(temp[h]<cost)
				{
					u=h;
					cost=temp[u];
				}
			}
			//如果任意temp[h]==INF 进行不下去了 			
			if (cost==double.MaxValue)  break;
			visited[u] = 1;       // mark it as visited;
			for (v=0;v<n;v++)    // for each neighbors of node u;
			{
				cost=netCostMatrix[u,v];        
				if((cost+ distance[u]) < distance[v])
				{
					distance[v] = distance[u] + cost;// update the shortest distance when a shorter path is found;
					parent[v] = u;                                     // update its parent;
				}
			}
		}   
		//得到最短径路
		int linkNum;	
		if (parent[d]==-1)    
			return (double.MaxValue);             //没有路径   else there is a path!			
		linkNum=0;
		v = d;
		while (v != s)
		{
			linkNum++;
			p = parent[v];
			v = p;      
		}
		pRoute=new int[linkNum+1];
		pRoute[linkNum]=d;
		v = d;
		while (v != s)
		{
			linkNum--;
			p = parent[v];
			pRoute[linkNum]=p;
			v = p;      
		}
		cost=distance[d];	
		return(cost);
	}
	public static double dijktra(ref int[] pRoute,double[,,] netCostMatrix ,int s,int d ,double k)
	{
		int n=netCostMatrix.GetLength(1);
		int intervalNum=netCostMatrix.GetLength(2)-2;
		if(s==d)
		{		
			return(0);
		}
		int i,h,u,p,v,dint;
		double rate,cost,t;
		int[] visited=new int[n];
		int[] parent=new int[n];
		double[] distance=new double[n];
		double[] temp=new double[n];
		for(i=0;i<n;i++)
		{
			visited[i]=0;
			distance[i] = double.MaxValue;
			parent[i]=-1;
			temp[0]=-1;
		}
		distance[s] = k;		
		//////////////////////////////////
		for (i=0;i<n-1;i++)
		{
			u=-1;t=double.MaxValue;
			for(h=0;h<n;h++)
			{
				if(visited[h] == 0)
					temp[h]=distance[h];
				else
					temp[h]=double.MaxValue;
				if(temp[h]<t)
				{
					u=h;
					t=temp[u];
				}
			}
			//如果任意temp[h]==INF 进行不下去了 			
			if (t==double.MaxValue)  break;			
			visited[u] = 1;       // mark it as visited;
			for (v=0;v<n;v++)    // for each neighbors of node u;
			{
				dint=(int)(distance[u]);
				rate=dint+1-distance[u];
				if(dint<intervalNum)
					cost=rate*(netCostMatrix[u,v,dint]-netCostMatrix[u,v,dint+1])+netCostMatrix[u,v,dint+1];//线性插值
				else
					cost=netCostMatrix[u,v,intervalNum+1];//线性插值
				if((cost+ distance[u]) < distance[v])
				{
					distance[v] = distance[u] + cost;// update the shortest distance when a shorter path is found;
					parent[v] = u;                                     // update its parent;
				}
			}
		} 
		
		//得到最短径路
		int linkNum;	
		if (parent[d]==-1)    return (double.MaxValue);             //没有路径   else there is a path!
		//if(distance[d]>=INF/2) return(INF);
		linkNum=0;
		v = d;
		while (v != s)
		{
			linkNum++;
			p = parent[v];
			v = p;      
		}	
		pRoute=new int[linkNum+1];
		pRoute[linkNum]=d;
		v = d;
		while (v != s)
		{
			linkNum--;
			p = parent[v];
			pRoute[linkNum]=p;
			v = p;      
		}
		cost=distance[d]-k;	
		return(cost);
	}
	public static void CreateRouteSearch(double[,] distance,ref double[,] mindistance,ref int [,]RouteSearch)//生成查询矩阵
	{
		int NodeNum;
		int i,j,k;
		NodeNum=distance.GetLength(1);
		mindistance=new double[NodeNum,NodeNum];
		RouteSearch=new int[NodeNum,NodeNum];
		for(i=0;i<NodeNum;i++)
		{
			for(j=0;j<NodeNum;j++)
			{
				mindistance[i,j]=distance[i,j];
				RouteSearch[i,j]=j; //初始化查询矩阵
			}
		}
		for(k=0;k<NodeNum;k++)
		{
			for(i=0;i<NodeNum;i++)
			{
				if(i!=k)
				{
					for(j=0;j<NodeNum;j++)
					{
						if(j!=k)
						{
							if(mindistance[i,j]>mindistance[i,k]+mindistance[k,j])
							{
								mindistance[i,j]=mindistance[i,k]+mindistance[k,j];
								RouteSearch[i,j]=k;
							}
						}
					}
				}
			}
		}
	}
	public static int[]  FindShortRoute(double[,] distance,double[,] mindistance, int[,] RouteSearch, int origin,int destination)//计算最短路径
	{
		int NodeNum;
		int NodeNumofRoute;
		NodeNum=distance.GetLength(1);			
		int i,j,pnode,addnode,passnode;
		int[] nodeRoute=new int[NodeNum];
		int[] Route=new int[NodeNum+1];
		for(i=0;i<=NodeNum;i++)
			Route[i]=0;			
		if(mindistance[origin,destination]>=double.MaxValue)
			return new int[0];
		Route[1]=origin;
		Route[2]=destination;	
		NodeNumofRoute=2;
		i=1;
		while (i<NodeNumofRoute)  
		{
			if ( mindistance[Route[i],Route[i+1]]   <  distance[Route[i],Route[i+1]] )  //需要进一步搜索
			{
				for(j=0;j<NodeNum;j++)
					nodeRoute[j]=0;//搜索并记录没有直接连线的两点的路径
				origin=Route[i];
				destination=Route[i+1];
				pnode=i;
				addnode=0;//新增加的节点
				passnode=origin;
				while (passnode != destination)
				{
					addnode=addnode+1;
					nodeRoute[addnode]=RouteSearch[passnode,destination];
					passnode=nodeRoute[addnode];
				}
				//把增加的节点添加到路径中去
				for(j=i+1;j<=NodeNumofRoute;j++)
					Route[NodeNumofRoute+i-j+addnode]=Route[NodeNumofRoute+i-j+1];
				for (j=1;j<=addnode-1;j++)
					Route[i+j]=nodeRoute[j];			
				NodeNumofRoute=NodeNumofRoute+addnode-1;//更改节点数
				i--;
			}
			i++;
		}
		int[] pRoute=new int[NodeNumofRoute];
		for(i=0;i<NodeNumofRoute;i++)
			pRoute[i]=Route[i+1];
		return(pRoute);
	}
    public static ArrayList GeneratekthShortestPathwithPunish(double[,] distance, int r, int s, int knum)
    {
        int k,node, node1, node2;
        double[,] dis = Copy(distance);
        double[,] mindis=null;
        int[,] routeSearch=null;
        int[] path;
        double alpha = double.MaxValue, dshort=1;
        ArrayList m_RouteSet = new ArrayList();
        // the minimum link length
        for (node1 = 0; node1 < dis.GetLength(0); node1++)
            for (node2 = 0; node2 < dis.GetLength(1); node2++)
                if (dis[node1, node2] < alpha && node1 != node2)
                    alpha = dis[node1, node2];
        alpha *= 0.3;        
        for (k = 0; k < knum; k++)
        {
            CreateRouteSearch(dis, ref mindis, ref routeSearch);
            if (k == 0)      dshort = mindis[r, s];
            path = FindShortRoute(dis, mindis, routeSearch, r, s);
            m_RouteSet.Add(path);
            //update the link cost
            for (node = 0; node < path.GetLength(0) - 1; node++)
                dis[path[node], path[node + 1]] *= (1 + alpha / dshort);
        }
        // path combination
        int r1, r2;
        int[] path1;
        for (r1 = 0; r1 < m_RouteSet.Count; r1++)
        {
            path1=(int[]) m_RouteSet[r1];
            for (r2 = m_RouteSet.Count - 1; r2 > r1; r2--)
            {
                path=(int[]) m_RouteSet[r2];
                if ( path1.GetLength(0)!=path.GetLength(0)) continue;
                // whether the routes are the same
                bool bsame = true;
                for(node=0;node<path.GetLength(0);node++)
                    if( path[node] != path1[node])
                    {
                        bsame = false;
                        break;
                    }
                if (bsame) m_RouteSet.RemoveAt(r2);
            }
        }
        return m_RouteSet;
    }
    public static ArrayList CombineGeneratekthShortestPath(double[,] distance, int r, int s, int knum)
    {
        ArrayList m_PathbyPunish = GeneratekthShortestPathwithPunish(distance, r, s, knum);
        ArrayList m_PathbyElimation = GeneratekthShortestPathbyElimination(distance, r, s, 4);
        // combine she route      
        int route1, route2,node;
        int[] path1;
        int[] path2;
        for (route1 = 0; route1 < m_PathbyPunish.Count; route1++)
        {
            path1 = (int[])m_PathbyPunish[route1];
            for (route2 = m_PathbyElimation.Count - 1; route2 > -1; route2--)
            {
                path2 = (int[])m_PathbyElimation[route2];
                if (path1.GetLength(0) != path2.GetLength(0)) continue;
                bool bsame = true;
                for (node = 0; node < path1.GetLength(0); node++)
                {
                    if (path1[node] != path2[node])
                    {
                        bsame = false;
                        break;
                    }
                }
                if (bsame) m_PathbyElimation.RemoveAt(route2);
            }
        }

        for (route2 = 0; route2 < m_PathbyElimation .Count; route2++)
        {
            path2 = (int[])m_PathbyElimation[route2];
            m_PathbyPunish.Add(path2);
        }
        return m_PathbyPunish;
    }
    public static ArrayList GeneratekthShortestPathbyElimination(double[,] distance, int r, int s, int knum)
    {
        int k, node, node1;
        double[,] dis = Copy(distance);
        double[,] mindis = null;
        int[,] routeSearch = null;
        int[] path; 
        ArrayList m_RouteSet = new ArrayList();
    
        for (k = 0; k < knum; k++)
        {
            CreateRouteSearch(dis, ref mindis, ref routeSearch);          
            if (mindis[r, s] == double.MaxValue) break;
            path = FindShortRoute(dis, mindis, routeSearch, r, s);
            m_RouteSet.Add(path);
            //update the link cost
            node1 = path.GetLength(0) / 2;
            dis[path[node1 - 1], path[node1]] = double.MaxValue;
            //if (node1 == 0 ) break;
            //for (node = 0; node < dis.GetLength(0); node++)
            //{
            //    if (node == node1) continue;
            //    dis[node, node1] = double.MaxValue;
            //    dis[node1, node] = double.MaxValue;
            //}
        }
        // path combination
        int r1, r2;
        int[] path1;
        for (r1 = 0; r1 < m_RouteSet.Count; r1++)
        {
            path1 = (int[])m_RouteSet[r1];
            for (r2 = m_RouteSet.Count - 1; r2 > r1; r2--)
            {
                path = (int[])m_RouteSet[r2];
                if (path1.GetLength(0) != path.GetLength(0)) continue;
                // whether the routes are the same
                bool bsame = true;
                for (node = 0; node < path.GetLength(0); node++)
                    if (path[node] != path1[node])
                    {
                        bsame = false;
                        break;
                    }
                if (bsame) m_RouteSet.RemoveAt(r2);
            }
        }
        return m_RouteSet;
    }
    public static ArrayList Dail(double[,] distance, double[,] nodeDistance, int r,int s)//
	{
		ArrayList routeSet=new ArrayList();
		ArrayList route=new ArrayList();
		//int route
		int nodeNum=nodeDistance.GetLength(0);
		int i,j;
		bool[,] L=new bool[nodeNum,nodeNum];
		for(i=0;i<nodeNum;i++)
		{				
			for(j=0;j<nodeNum;j++)
			{
				if(distance[i,j]>double.MaxValue/10.0) continue;
				if(nodeDistance[r,i]<nodeDistance[r,j]  && nodeDistance[i,s] > nodeDistance[j,s])
					L[i,j]=true;
				else
					L[i,j]=false;
			}
		}
		//根据L搜索有效路径集合
		int order,node=r;
		int index=0;
		bool addroute;
		route=new ArrayList();
		route.Add(node);
		routeSet.Add(route);
		while(index<routeSet.Count)
		{
			addroute=false;
			route=(ArrayList)routeSet[index];
			node=(int)route[route.Count-1];
			if(node==s)
			{
				index++;
				continue;
			}
			for(j=0;j<nodeNum;j++)
			{
				if(L[node,j] && !addroute)
				{
					route.Add(j);
					addroute=true;
					if(j==s)
						index++;
				}
				else if(L[node,j])
				{
					ArrayList proute=new ArrayList();
					for(i=0;i<route.Count-1;i++)
					{
						order=(int)route[i];
						proute.Add(order);
					}						
					proute.Add(j);
					routeSet.Add(proute);
				}
			}
			if(!addroute) index++;
		}
		//批除部分无效路径
		for(i=routeSet.Count-1;i>=0;i--)
		{
			route=(ArrayList)routeSet[i];
			node=(int)route[route.Count-1];
			if(node!=s)
				routeSet.RemoveAt(i);
		}
		//改成数组格式
		ArrayList validrouteSet=new ArrayList();
		for(i=0;i<routeSet.Count;i++)
		{
			route=(ArrayList)routeSet[i];				
			Int32[] routenode = (Int32[])route.ToArray(typeof(Int32));//返回ArrayList包含的数组
			validrouteSet.Add(routenode);
		}
		return(validrouteSet);
	}
	public static double Angle(double x,double y)
	{
		double angle;
		if(x==0)
		{
			if(y>0)
				return Math.PI/2;
			else
				return -Math.PI/2;
		}
		angle=Math.Atan(y/x);
		if(x<0 && y<=0)
			angle-=Math.PI;
		else if(x>0 && y<0)
			angle+=Math.PI;
		return angle;
	}
	public static String ArrayToString(char SeparateChar,double[] A)
	{
		StringBuilder sb=new StringBuilder();
		for(int i=0;i<A.GetLength(0);i++)
		{
			sb.Append(A[i].ToString());
			sb.Append(SeparateChar);
		}
		if(A.GetLength(0)>0)
			sb.Remove(sb.Length-1,1);
		return sb.ToString();
	}
	public static String ArrayToString(char SeparateChar,int[] A)
	{
		StringBuilder sb=new StringBuilder();
		for(int i=0;i<A.GetLength(0);i++)
		{
			sb.Append(A[i].ToString());
			sb.Append(SeparateChar);
		}
		if(A.GetLength(0)>0)
			sb.Remove(sb.Length-1,1);
		return sb.ToString();
	}
    // 全选主元高斯消去法
    //a-n*n 存放方程组的系数矩阵，返回时将被破坏
    //b-常数向量
    //x-返回方程组的解向量
    //n-存放方程组的阶数
    //返回0表示原方程组的系数矩阵奇异
    public static bool cagaus(double[,] a, double[] b,  ref double[] x)
    {
        int n = a.GetLength(0);
        x = new double[n];
        int l, k, i, j, iis, p, q;
        int[] js = new int[n];
        double d, t;
        l = 1;
        iis = 0;
        for (k = 0; k <= n - 2; k++)
        {
            d = 0.0;
            for (i = k; i <= n - 1; i++)
            {
                for (j = k; j <= n - 1; j++)
                {
                    t = Math.Abs(a[i, j]);
                    if (t > d)
                    {
                        d = t;
                        js[k] = j;
                        iis = i;
                    }
                }
            }
            if (d + 1.0 == 1.0)
            {
                l = 0;
            }
            else
            {
                if (js[k] != k)
                {
                    for (i = 0; i <= n - 1; i++)
                    {
                        p = k;
                        q = js[k];
                        t = a[i, p];
                        a[i, p] = a[i, q];
                        a[i, q] = t;
                    }
                }
                if (iis != k)
                {
                    for (j = k; j <= n - 1; j++)
                    {
                        p = k;
                        q = iis;
                        t = a[p, j];
                        a[p, j] = a[q, j];
                        a[q, j] = t;
                    }
                    t = b[k];
                    b[k] = b[iis];
                    b[iis] = t;
                }
            }
            if (l == 0)
            {
                return false;
            }
            d = a[k, k];
            for (j = k + 1; j <= n - 1; j++)
                a[k, j] = a[k, j] / d;
            b[k] = b[k] / d;
            for (i = k + 1; i <= n - 1; i++)
            {
                for (j = k + 1; j <= n - 1; j++)
                {
                    p = i * n + j;
                    a[i, j] = a[i, j] - a[i, k] * a[k, j];
                }
                b[i] = b[i] - a[i, k] * b[k];
            }
        }
        d = a[(n - 1), n - 1];
        if (Math.Abs(d) + 1.0 == 1.0)
        {
            return false;
        }
        x[n - 1] = b[n - 1] / d;
        for (i = n - 2; i >= 0; i--)
        {
            t = 0.0;
            for (j = i + 1; j <= n - 1; j++)
            {
                t = t + a[i, j] * x[j];
            }
            x[i] = b[i] - t;
        }
        js[n - 1] = n - 1;
        for (k = n - 1; k >= 0; k--)
        {
            if (js[k] != k)
            {
                t = x[k];
                x[k] = x[js[k]];
                x[js[k]] = t;
            }
        }
        return true;
    }
}
