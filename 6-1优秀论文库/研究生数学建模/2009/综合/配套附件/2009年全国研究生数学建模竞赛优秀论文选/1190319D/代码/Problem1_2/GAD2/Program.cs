using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.IO;

namespace GAD2
{
    class Program
    {
        static int generation = 3000;
        static int population = 120;
        static double Pc = 0.5;
        static double Pm = 0.01;

        static int pointNum = 1350;
        static int len;
        StreamReader reader;
        double[,] lagroad;


        static int[,] indiv; //个体
        static int[,] new_indiv; //下一代个体
        static double[] score; //适应度
        //static int[] score_indiv; //每个适应度对应的个体
        Random rand;

        public void readMap()
        {
            lagroad = new double[pointNum, pointNum];
            reader = File.OpenText("C:\\book3.txt");
            string thisLine = null;
            int i = 0;
            while ((thisLine = reader.ReadLine()) != null)
            {
                string[] line = thisLine.Trim().Split('\t');
                for (int j = 0; j < pointNum; j++)
                {
                    lagroad[i, j] = Double.Parse(line[j]);
                }
                i++;
            }
            reader.Close();
        }

        public void initial()
        {
            indiv = new int[population, len];
            new_indiv = new int[population, len];
            score = new double[population];
            rand = new Random();
            for (int i = 0; i < population; i++)
            {
                for (int j = 0; j < len; j++)
                {
                    indiv[i, j] = rand.Next(0, 1349);
                }
            }
        }

        public void select()
        {
            //评分
            for (int i = 0; i < population; i++)
            {
                score[i] = 0.00;

                int goodpoint = 0; //三分钟能赶到的点数
                int[] goodimportant = { 0, 0, 0 }; //二分钟能赶到重点部位的点数

                for (int p = 0; p < pointNum; p++)
                {
                    for (int p2 = 0; p2 < len; p2++)
                    {
                        //计算每个点和每个中心的距离,取最小距离
                        int temp = indiv[i, p2]; // 第p2个点

                        if (lagroad[p, temp] < 2000.00)
                        {
                            goodpoint++;
                            break;
                        }

                    }
                    
                }

                score[i] += (double)goodpoint / (double)pointNum;
                
                for (int p2 = 0; p2 < len; p2++)
                {
                    //计算每个点和每个中心的距离,取最小距离
                    int temp = indiv[i, p2]; // 第p2个点
                    if (lagroad[100, temp] < 1170.3364 || lagroad[102, temp] < 1178.4915 || lagroad[109, temp] < 1170.3364 || lagroad[111, temp] < 1141.9907)
                    {
                        goodimportant[0] = 1;
                    }
                    if (lagroad[122, temp] < 1188.2127 || lagroad[140, temp] < 1145.4078)
                    {
                        goodimportant[1] = 1;
                    }
                    if (lagroad[276, temp] < 1333.3333)
                    {
                        goodimportant[2] = 1;
                    }
                    
                }

                if (0 == goodimportant[0] || 0 == goodimportant[1] || 0 == goodimportant[2]) score[i] -= 0.5;


            }



            for (int i = 0; i < population; i++)
            {
                int maxIndex = i;
                for (int j = i + 1; j < population; j++)
                {
                    if (score[maxIndex] < score[j]) maxIndex = j;
                }
                double temp = score[maxIndex];
                score[maxIndex] = score[i];
                score[i] = temp;

                int temp2 = 0;
                for (int j = 0; j < len; j++)
                {
                    temp2 = indiv[maxIndex, j];
                    indiv[maxIndex, j] = indiv[i, j];
                    indiv[i, j] = temp2;
                }
            }

            for (int i = 0; i < population / 3; i++)
            {
                for (int j = 0; j < len; j++)
                {
                    new_indiv[i, j] = indiv[i, j];
                }
            }
        }

        public void crossover()
        {
            for (int i = population / 3; i < 2 * population / 3; i++)
            {
                int x1 = rand.Next(0, 39);
                int x2 = rand.Next(0, 39);

                int[] gene1 = new int[len];
                int[] gene2 = new int[len];

                for (int j = 0; j < len; j++)
                {
                    if (rand.Next(0, 99) < Pc * 100)
                    {
                        gene1[j] = indiv[x2, j];
                        gene2[j] = indiv[x1, j];
                    }
                    else
                    {
                        gene1[j] = indiv[x1, j];
                        gene2[j] = indiv[x2, j];
                    }
                }

                for (int j = 0; j < len; j++)
                {
                    new_indiv[i, j] = gene1[j];
                }

                if ((i + 1) >= 2 * population / 3) break;

                for (int j = 0; j < len; j++)
                {
                    new_indiv[i + 1, j] = gene2[j];
                }
                i++;

            }
        }

        public void mutation()
        {
            int i = 2 * population / 3;
            for (int j = 0; j < population / 3; j++)
            {
                for (int p = 0; p < len; p++)
                {
                    if (rand.Next(0, 99) < Pm * 100)
                    {
                        new_indiv[i, p] = rand.Next(0, 1349);
                    }
                    else
                    {
                        new_indiv[i, p] = indiv[j, p];
                    }
                }
                i++;
                if (i >= population) break;
            }
        }

        public void reproduct()
        {
            for (int i = 0; i < population; i++)
            {
                for (int j = 0; j < len; j++)
                {
                    indiv[i, j] = new_indiv[i, j];
                }
            }
        }

        public void print()
        {
            for (int i = 0; i < len; i++)
            {
                Console.Write(indiv[0, i] + " ");
            }
            Console.WriteLine();
            Console.WriteLine(score[0]);
        }

        static void Main(string[] args)
        {
            len = Convert.ToInt32(args[0]);
            Program pro = new Program();
            pro.readMap();
            pro.initial();

            for (int i = 0; i < generation; i++)
            {
                //Pm = 0.01 * (i / 500);                
                pro.select();
                Console.WriteLine("generation " + i + ": " + score[0]);
                pro.crossover();
                pro.mutation();
                pro.reproduct();
            }
            pro.select();
            pro.print();

            Console.ReadKey();
        }
    }
}
