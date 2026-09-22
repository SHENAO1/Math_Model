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
	/// 
public class CVehiclePositionCompare : System.Collections.IComparer
{
    public int Compare(object x, object y)
    {
        return (((CVehicle)x).Position - ((CVehicle)y).Position);
    }
}
public class CLink//路段
{
    public int Direction;// 1 east  2 west  -1 north  -2 south
    public int Length;// the length of the link
    public int Channellen;// the length of channelization

    public ArrayList m_InnerVehicle;// Vehicles travelling on the inner lane
    public ArrayList m_OuterVehicle;// vehicles travelling on the outer lane
    public ArrayList m_Invehicle;
    public CLink()
    {
        m_InnerVehicle = new ArrayList();
        m_OuterVehicle = new ArrayList(); 
        m_Invehicle = new ArrayList();
        Channellen = 6; // 45 m
    }
}
public class CIntersection// junction
{
    public int[] BoundState;// element: E1, E2,W1,W2,S1,S2,N1,N2, four state: AHEAD, LEFT, RIGHT, EMPTY 
    public int[] VehicleOrder;
    public bool[] State;// cell state   true  occpucy   false   empty
    public int[] dforward;
    public int[] RelativePositon;
    public int[] LinkOrder;
    public int SignalPhase;
    public ArrayList m_Vehicle;   
    public CIntersection()
    {        
        m_Vehicle = new ArrayList();    
        State = new bool[4];
        VehicleOrder = new int[4];
        BoundState = new int[8];
        RelativePositon = new int[8];
        dforward = new int[4];
        LinkOrder = new int[4];
        for (int i = 0; i < 4; i++)
        {
            State[i] =false;
            VehicleOrder[i] = -1;            
        }
    }
}
public class CVehicle//
{
    public int Movement;// 0 ahead   -1 left turning   1 right turning
    public int Position;// the position on link
    public int ColIndex;// check vehicle's position, if ColIndex != -1, denote move at EW or WE direction
    public int RowIndex;// check vehicle's position, if RowIndex !=-1, denotes move at SN or NS direction 
    public int Velocity;// 

    public int NextPosition;// the position on link
    public int NextVelocity;// 
    public bool bIntoIntersection;//flow into intersection for next step
    public bool bLaneChange;

    public int Source; // vehicle source (e.g., SN NS SW WS) 

    public int IntoLinkTime;
    public int OutLinkTime;

    public CVehicle()
    {
        //bLinkChange = false;
        bLaneChange = false;
        NextPosition = -2;
    }
}
public class CNetwork//路段
{
    const int LEFT=1,RIGHT=2,AHEAD=0,EMPTY=-1;
    const int EWGREEN = 10, EWYELLOW = 11, SNGREEN = 12, SNYELLOW = 13;
    const int EW = 0, WE = 1, SN = 2, NS = 3, ES = 0, NE = 1, WN = 2, SW = 3;
    const int E1 = 0, E2 = 1, W1 = 2, W2 = 3, S1 = 4, S2 = 5, N1 = 6, N2 = 7;
    int Cycle;// signal cycle 
    int Green;// grean phase for east-weat
    int Yellow;// yellow phase
    int vmax;// the maximum velocity for vehicle driving on road, ahead movement,
                               //left turing movement, right turning movement, respectively.
    int HalfLinkLength;//the half cell number for a link with cells at intersections
    int NetworkSize;
    int EWSize, SNSize;
    double RateLeft, RateRight, RateAhead;
    public ArrayList m_EastWestLink;
    public ArrayList m_WestEastLink;
    public ArrayList m_SouthNorthLink;
    public ArrayList m_NorthSouthLink;
    public ArrayList m_Intersection;

    public int PredictLength;
    public int Capacity;
    public int MaxInterval;
    public int MinimumSignalPeriod;

    int dSafe;
    double SlowRate;
    Random Rand;
    public int NowTime;

    // link related variables
    int[,] EWLinkLength;
    int[,] SNLinkLength;

    // cumulative link by index
    int[,] EWLinkLenIndex;
    int[,] SNLinkLenIndex;
    int[,] WELinkLenIndex;
    int[,] NSLinkLenIndex;

    //traffic demand;
    int[,] EWDemand;
    int[,] WEDemand;
    int[,] SNDemand;
    int[,] NSDemand;

    // signal phase
    int[,] PhaseDelay;
    int[,] SignalPeriod;// related to intersection
    
    int[,] EastBegTime;
    int[,] WestBegTime;
    int[,] SouthBegTime;
    int[,] NorthBegTime;

    int[,] EastEndTime;
    int[,] WestEndTime;
    int[,] SouthEndTime;
    int[,] NorthEndTime;

    int[,] SignalPhase;

    // Statistic data
    int[,,] EWCumlativeInflow;
    int[,,] WECumlativeInflow;
    int[, ,] SNCumlativeInflow;
    int[, ,] NSCumlativeInflow;

    // Statistic data
    int[, ,] EWCumlativeOutflow;
    int[, ,] WECumlativeOutflow;
    int[, ,] SNCumlativeOutflow;
    int[, ,] NSCumlativeOutflow;

    // vehicles on link
    int[,] EWFlow;
    int[,] SNFlow;
    int[,] WEFlow;
    int[,] NSFlow;

    double[] AverageVelocity;
    int[] TotalVehicle;
    int[] StopTimes;
    double[] CongestionDelay;

    public CNetwork()
    {
        m_EastWestLink = new ArrayList();
        m_WestEastLink = new ArrayList();
        m_SouthNorthLink = new ArrayList();
        m_NorthSouthLink = new ArrayList();
        m_Intersection = new ArrayList();
        EWLinkLenIndex = null;
        SNLinkLenIndex = null;

        WELinkLenIndex = null;
        NSLinkLenIndex = null;

        MaxInterval = 7200;// 2 hour
        PredictLength = 60;//
        Capacity = 4400;
        NowTime = 0;

        MinimumSignalPeriod = 80;

        // signal phase
        PhaseDelay = null;
        SignalPeriod = null;// related to intersection
        EastBegTime = null;
        WestBegTime = null;
        SouthBegTime = null;
        NorthBegTime = null;
        EastEndTime = null;
        WestEndTime = null;
        SouthEndTime = null;
        NorthEndTime = null;
        SignalPhase = null;

        vmax = 3;
        dSafe = 3;
        Cycle = 30;
        Yellow = 2;
        Green = (Cycle - 2 * Yellow) / 2;
        RateAhead = 0.7;
        RateLeft = 0.1;
        RateRight = 1 - RateAhead - RateLeft;

        SlowRate = 0.05;
        NetworkSize = 1;
        HalfLinkLength = 20;

        Rand = new Random(unchecked((int)DateTime.Now.Ticks));
        Rand.NextDouble();
    }
    public void ReadLinkLength(String datapath)
    {
        double[] linklength = null;
        Matrix.LoadData(ref linklength, datapath);
        int foulink = 0;
        int row, col;
        for (row = 0; row < EWSize; row++)
        {
            for (col = 0; col < SNSize + 1; col++)
            { 
                EWLinkLength[row, col] = (int)(linklength[foulink] / 7.5);
                foulink++;
            }
        }

        for (col = 0; col < SNSize; col++)
        {
            for (row = 0; row < EWSize + 1; row++)
            {
                SNLinkLength[col, row] = (int)(linklength[foulink] / 7.5);
                foulink++;
            }
        }
        SetLinkLengthIndex();
    }
    public void ReadTrafficDemand(String datapath)
    {
        int inter,departtime;
        int link, veh, foulink = 0;
        CLink pLink;
        int intervalNum = MaxInterval / 60;
        double[,] demand = Matrix.LoadData(datapath, '\t');
        //East - West
        EWDemand = new int[EWSize, MaxInterval];
        for (link = 0; link < m_EastWestLink.Count; link++)
        {
            pLink = (CLink)m_EastWestLink[link];
            for (inter = 0; inter < demand.GetLength(0); inter++)
            {
                for (veh = 0; veh < demand[inter, foulink]; veh++)
                {
                    departtime = inter*60+(int)(60 * Rand.NextDouble());
                    if (departtime > MaxInterval) break;
                    EWDemand[link, departtime]++;
                }
            }
            foulink++;
        }
        //South-North
        SNDemand = new int[SNSize, MaxInterval];
        for (link = 0; link < m_SouthNorthLink.Count; link++)
        {
            pLink = (CLink)m_SouthNorthLink[link];
            for (inter = 0; inter < demand.GetLength(0); inter++)
            {
                for (veh = 0; veh < demand[inter, foulink]; veh++)
                {
                    departtime = inter * 60 + (int)(60 * Rand.NextDouble());
                    if (departtime > MaxInterval) break;
                    SNDemand[link, departtime]++;
                }
            }
            foulink++;
        }
        //West-East
        WEDemand = new int[EWSize, MaxInterval];
        for (link = 0; link < m_WestEastLink.Count; link++)
        {
            pLink = (CLink)m_WestEastLink[link];
            for (inter = 0; inter < demand.GetLength(0); inter++)
            {
                for (veh = 0; veh < demand[inter, foulink]; veh++)
                {
                    departtime = inter * 60 + (int)(60 * Rand.NextDouble());
                    if (departtime > MaxInterval) break;
                    WEDemand[link, departtime]++;
                }
            }
            foulink++;
        }
        //North-South
        NSDemand = new int[SNSize, MaxInterval];
        for (link = 0; link < m_NorthSouthLink.Count; link++)
        {
            pLink = (CLink)m_NorthSouthLink[link];
            for (inter = 0; inter < demand.GetLength(0); inter++)
            {
                for (veh = 0; veh < demand[inter, foulink]; veh++)
                {
                    departtime = inter * 60 + (int)(60 * Rand.NextDouble());
                    if (departtime > MaxInterval) break;
                    NSDemand[link, departtime]++;
                }
            }
            foulink++;
        }      
    }
    public void RemoveAllVehicles()
    {
        int link, row,col;
        CLink pLink;
        CIntersection pIntersection;
        // East -West
        for (link = 0; link < m_EastWestLink.Count;link++ )
        {
            pLink = (CLink)m_EastWestLink[link];
            pLink.m_InnerVehicle.RemoveRange(0, pLink.m_InnerVehicle.Count);
            pLink.m_OuterVehicle.RemoveRange(0, pLink.m_OuterVehicle.Count);
            pLink.m_Invehicle.RemoveRange(0, pLink.m_Invehicle.Count);
        }
        // West -East
        for (link = 0; link < m_WestEastLink.Count; link++)
        {
            pLink = (CLink)m_WestEastLink[link];
            pLink.m_InnerVehicle.RemoveRange(0, pLink.m_InnerVehicle.Count);
            pLink.m_OuterVehicle.RemoveRange(0, pLink.m_OuterVehicle.Count);
            pLink.m_Invehicle.RemoveRange(0, pLink.m_Invehicle.Count);
        }
        // South -North
        for (link = 0; link < m_SouthNorthLink.Count; link++)
        {
            pLink = (CLink)m_SouthNorthLink[link];
            pLink.m_InnerVehicle.RemoveRange(0, pLink.m_InnerVehicle.Count);
            pLink.m_OuterVehicle.RemoveRange(0, pLink.m_OuterVehicle.Count);
            pLink.m_Invehicle.RemoveRange(0, pLink.m_Invehicle.Count);
        }

        // North -South
        for (link = 0; link < m_NorthSouthLink.Count; link++)
        {
            pLink = (CLink)m_NorthSouthLink[link];
            pLink.m_InnerVehicle.RemoveRange(0, pLink.m_InnerVehicle.Count);
            pLink.m_OuterVehicle.RemoveRange(0, pLink.m_OuterVehicle.Count);
            pLink.m_Invehicle.RemoveRange(0, pLink.m_Invehicle.Count);
        }

        // intersection
        for (row = 0; row < EWSize;row++ )
        {
            for (col = 0; col < SNSize;col++ )
            {
                pIntersection = (CIntersection)m_Intersection[row * SNSize + col];
                pIntersection.m_Vehicle.RemoveRange(0, pIntersection.m_Vehicle.Count);
            }
        }
    }
    public void InitialStatisticVariables()
    {
        EWCumlativeInflow = new int[EWSize, SNSize + 1, MaxInterval];
        WECumlativeInflow = new int[EWSize, SNSize + 1, MaxInterval];
        SNCumlativeInflow = new int[SNSize, EWSize + 1, MaxInterval];
        NSCumlativeInflow = new int[SNSize, EWSize + 1, MaxInterval];

        EWCumlativeOutflow = new int[EWSize, SNSize + 1, MaxInterval];
        WECumlativeOutflow = new int[EWSize, SNSize + 1, MaxInterval];
        SNCumlativeOutflow = new int[SNSize, EWSize + 1, MaxInterval];
        NSCumlativeOutflow = new int[SNSize, EWSize + 1, MaxInterval];

        EWFlow = new int[EWSize, SNSize+1];
        SNFlow = new int[SNSize, EWSize+1];
        WEFlow = new int[EWSize, SNSize+1];
        NSFlow = new int[SNSize, EWSize+1];

        AverageVelocity = new double[MaxInterval];
        TotalVehicle = new int[MaxInterval];
        StopTimes = new int[MaxInterval];
        CongestionDelay = new double[MaxInterval];
    }
    public void SetLinkLengthIndex()
    {
          
        EWLinkLenIndex = new int[EWSize, SNSize + 1];       
        SNLinkLenIndex = new int[SNSize, EWSize + 1];

        WELinkLenIndex = new int[EWSize, SNSize + 1];
        NSLinkLenIndex = new int[SNSize, EWSize + 1];


        int row, col, cumlinklen;
        for (row = 0; row < EWSize; row++ )
        {
            cumlinklen = 0;
            for (col = 0; col < SNSize + 1; col++ )
            {
                WELinkLenIndex[row, col] = cumlinklen;
                cumlinklen += EWLinkLength[row, col] +4;
            }

            cumlinklen = 0;
            for (col = 0; col < SNSize + 1; col++)
            {
                EWLinkLenIndex[row, col] = cumlinklen;
                cumlinklen += EWLinkLength[row, SNSize - col] + 4;
            }
        }

        for (col = 0; col < SNSize; col++)
        {
            cumlinklen = 0;
            for (row = 0; row < EWSize + 1; row++)
            {
                NSLinkLenIndex[col, row] = cumlinklen;
                cumlinklen += SNLinkLength[col, row] +4;
            }

            cumlinklen = 0;
            for (row = 0; row < EWSize + 1; row++)
            {
                SNLinkLenIndex[col, row] = cumlinklen;
                cumlinklen += SNLinkLength[col, EWSize-row] + 4;
            }
        }
    }
    public void RandomSetSignal()
    {
        int row, col, phase;
        int gmin = 12, gmax = 24;
        int[] greentime = new int[4];
        double r = 0;
        for (row = 0; row < EWSize;row++)
        {
            for (col = 0; col < SNSize; col++ )
            {   
                for (phase = 0; phase < 4; phase++)
                {
                    r = Rand.NextDouble();
                    greentime[phase] = (int)(gmin + (gmax - gmin) * r + 0.5);
                }
                r = Rand.NextDouble();
                PhaseDelay[row, col] = (int)(gmin + 2*(gmax - gmin) * r + 0.5);

                EastBegTime[row, col] = 0;
                EastEndTime[row, col] = EastBegTime[row, col] + greentime[0] - 1;

                SouthBegTime[row, col] = EastEndTime[row, col] + 4;
                SouthEndTime[row, col] = SouthBegTime[row, col] + greentime[1] - 1;

                WestBegTime[row, col] = SouthEndTime[row, col] + 4;
                WestEndTime[row, col] = WestBegTime[row, col] + greentime[2]-1;

                NorthBegTime[row, col] = WestEndTime[row, col] + 4;
                NorthEndTime[row, col] = NorthBegTime[row, col] + greentime[3] - 1;

                SignalPeriod[row, col] = NorthEndTime[row, col] + 4;
            }
        }
    }
    public void RandomGenerateLinkLength()
    {
        int maxHalfLen = 30, minHalfLen = 30;
        int row, col;
        double r, halflength;
        for (row = 0; row < EWSize; row++)
        {
            for (col = 0; col < SNSize + 1; col++)
            {
                r = Rand.NextDouble();
                halflength = minHalfLen + (maxHalfLen - minHalfLen) * r;
                EWLinkLength[row, col] = 2 * ((int)(halflength + 0.5));
            }            
        }

        for (col = 0; col < SNSize; col++)
        {            
            for (row = 0; row < EWSize + 1; row++)
            {
                r = Rand.NextDouble();
                halflength = minHalfLen + (maxHalfLen - minHalfLen) * r;
                SNLinkLength[col, row] = 2 * ((int)(halflength + 0.5));
            }
        }
        SetLinkLengthIndex();
    }
    public void NetworkGeneration(int pEWsize, int pSNsize, int hlinklength)
    {
        EWSize = pEWsize;
        SNSize = pSNsize;
    
        HalfLinkLength = hlinklength;
        // link generation
        CLink pLink;
        int link, inters, subinters;
        m_EastWestLink.Clear();
        for (link = 0; link < EWSize; link++)
        {
            pLink = new CLink();           
            m_EastWestLink.Add(pLink);
        }
        m_WestEastLink.Clear();
        for (link = 0; link < EWSize; link++)
        {
            pLink = new CLink();
            m_WestEastLink.Add(pLink);
        }
        // Set link length
        EWLinkLength = new int[EWSize,SNSize+1];
        for (inters = 0; inters < EWSize; inters++)
        {
            for (subinters = 0; subinters < SNSize+1; subinters++)
            {
                EWLinkLength[inters , subinters] = 2 * hlinklength;               
            }
        }
        m_SouthNorthLink.Clear();
        for (link = 0; link < SNSize; link++)
        {
            pLink = new CLink();
            m_SouthNorthLink.Add(pLink);
        }
        m_NorthSouthLink.Clear();
        for (link = 0; link < SNSize; link++)
        {
            pLink = new CLink();
            m_NorthSouthLink.Add(pLink);
        }

        // set link length
        SNLinkLength = new int[SNSize,EWSize+1];
        for (inters = 0; inters < SNSize; inters++)
        {
            for (subinters = 0; subinters < EWSize+1; subinters++)
            {
                SNLinkLength[inters,subinters] = 2 * HalfLinkLength;                
            }
        }

        CIntersection pIntersection;    
        m_Intersection.Clear();
        for (inters = 0; inters < EWSize; inters++ )
        {
            for (subinters = 0; subinters < SNSize;subinters++ )
            {
                pIntersection = new CIntersection();
                m_Intersection.Add(pIntersection);
            }
        }
        // signal phase
        PhaseDelay = new int[EWSize, SNSize];
        SignalPeriod = new int[EWSize, SNSize];// related to intersection
        EastBegTime = new int[EWSize, SNSize];
        WestBegTime = new int[EWSize, SNSize];
        SouthBegTime = new int[EWSize, SNSize];
        NorthBegTime = new int[EWSize, SNSize];
        EastEndTime = new int[EWSize, SNSize];
        WestEndTime = new int[EWSize, SNSize];
        SouthEndTime = new int[EWSize, SNSize];
        NorthEndTime = new int[EWSize, SNSize];
        SignalPhase = new int[EWSize, SNSize];
        //RandomGenerateLinkLength();       
    }       
    public void InitialVehicles()
    {
        CLink pLink;
        CVehicle pVehicle;

        pLink = (CLink)m_SouthNorthLink[0];
        //pLink = (CLink)m_NorthSouthLink[0];
        //pLink = (CLink)m_WestEastLink[0];
        //pLink = (CLink)m_EastWestLink[0];
        pVehicle = new CVehicle();
        pVehicle.Position = 2;
        pVehicle.ColIndex = 0;
        pVehicle.Movement = LEFT;
        pLink.m_InnerVehicle.Add(pVehicle);


        pVehicle = new CVehicle();
        pVehicle.Position = 5;
        pVehicle.ColIndex = 0;
        pVehicle.Movement = RIGHT;
        pLink.m_OuterVehicle.Add(pVehicle);


        /*pLink = (CLink)m_NorthSouthLink[0];        
        pVehicle = new CVehicle();
        pVehicle.Position = 6;
        pVehicle.ColIndex = 0;
        pVehicle.RowIndex = 0;
        pVehicle.Movement = RandSetVehicleMovement();
        pLink.m_InnerVehicle.Add(pVehicle);


        pVehicle = new CVehicle();
        pVehicle.Position = 13;
        pVehicle.ColIndex = 0;
        pVehicle.RowIndex = 0;
        pVehicle.Movement = RandSetVehicleMovement();
        pLink.m_InnerVehicle.Add(pVehicle);
       
        pVehicle = new CVehicle();
        pVehicle.Position = 17;
        pVehicle.ColIndex = 1;
        pVehicle.RowIndex = 1; 
        pVehicle.Movement = RandSetVehicleMovement();
        pLink.m_InnerVehicle.Add(pVehicle);

        pVehicle = new CVehicle();
        pVehicle.Position = 32;
        pVehicle.ColIndex = 2;
        pVehicle.RowIndex = 2;
        pVehicle.Movement = RandSetVehicleMovement();
        pLink.m_InnerVehicle.Add(pVehicle);

        pVehicle = new CVehicle();
        pVehicle.Position = 8;
        pVehicle.ColIndex = 0;
        pVehicle.RowIndex = 0; 
        pVehicle.Movement = RandSetVehicleMovement();
        pLink.m_OuterVehicle.Add(pVehicle);


        pVehicle = new CVehicle();
        pVehicle.Position = 14;
        pVehicle.ColIndex = 0;
        pVehicle.RowIndex = 0;
        pVehicle.Movement = RandSetVehicleMovement();
        pLink.m_OuterVehicle.Add(pVehicle);


        CIntersection pIntersection;
        pIntersection = (CIntersection)m_Intersection[3];
        pVehicle = new CVehicle();
        pVehicle.Position = 8;
        pVehicle.ColIndex = 0;
        pVehicle.RowIndex = 0;
        pVehicle.Movement = LEFT;
        pIntersection.m_Vehicle.Add(pVehicle);

        pVehicle = new CVehicle();
        pVehicle.Position = 13;
        pVehicle.ColIndex = 0;
        pVehicle.RowIndex = 0;
        pVehicle.Movement = LEFT;
        pIntersection.m_Vehicle.Add(pVehicle);*/
    }   
    public int RandSetVehicleMovement()
    {
        double r = Rand.NextDouble();
        if (r < 0.1) return LEFT;
        else if (r < 0.25) return RIGHT;
        else       return AHEAD;
    }
    public Bitmap DrawVehicularNetwork(Rectangle maprect)
    {       
        //double cellLength = range / (double)(2 * HalfLinkLength * NetworkSize + 2 * NetworkSize);
        Bitmap bmp = new Bitmap(maprect.Width, maprect.Height);
        Graphics gImage = Graphics.FromImage(bmp);
        gImage.SmoothingMode = SmoothingMode.AntiAlias;      
        Pen linkPen = new Pen(Color.Black, 1);//设置路段线钢笔
        //linkPen.EndCap = LineCap.ArrowAnchor;
        int row,col, cell;
        double x, y;
        double left,top,right,bottom;
        Point originPoint=new Point();
        Point destinatePoint = new Point();

        Font nameFont = new Font("Times New Roman", 12);
        SolidBrush textShadowBrush = new SolidBrush(Color.FromArgb(100, Color.Black));
        String str = "Now Time is: " + NowTime.ToString();

        gImage.DrawString(str, nameFont, textShadowBrush, (float)10, (float)10);
        //gImage.DrawString();
        // determine map range
        // the maximum length of EW
        int[] maxEWlen = new int[SNSize + 1];
        int[] maxSNlen = new int[EWSize + 1];
       
        int[] cumEWlen = new int[SNSize+1];
        int[] cumSNlen = new int[EWSize + 1];
        
        int linkcumlen,sumEWlen=0,sumSNlen=0;
        for (col = 0; col < SNSize + 1; col++)
        {
            maxEWlen[col] = 0;
            for (row = 0; row < EWSize; row++)
            {
                if (maxEWlen[col] < EWLinkLength[row, col])
                {
                    maxEWlen[col] = EWLinkLength[row, col];
                }
            }
            sumEWlen += maxEWlen[col];
        }
        sumEWlen += 4 * SNSize;

        for (col = 0; col < EWSize + 1; col++)
        {
            maxSNlen[col] = 0;
            for (row = 0; row < SNSize; row++)
            {
                if (maxSNlen[col] < SNLinkLength[row, col])
                {
                    maxSNlen[col] = SNLinkLength[row, col];
                }
            }
            sumSNlen += maxSNlen[col];
        }
        sumSNlen += 4 * EWSize;
        //***********************************************
        // cumlative east- west length        
            linkcumlen = 0;
            for (col = 0; col < SNSize+1; col++)
            {                
                cumEWlen[col] = linkcumlen;
                linkcumlen = cumEWlen[col] + maxEWlen[col] + 4; 
            }        
        //cumlative south-north length        
            linkcumlen = 0;
            for (row = 0; row < EWSize+1; row++)
            {                
                cumSNlen[row] = linkcumlen;
                linkcumlen = cumSNlen[row]+maxSNlen[row]+4; 
            }       
        //***************************************************
        int range = maprect.Height - 10;
        if (range > maprect.Width - 10) range = maprect.Width - 10;
        double cellLength;

        double newleft, newtop, newcelllen;
        cellLength = (maprect.Height - 10.0) / sumSNlen;
        if (cellLength > (maprect.Width - 10.0) / sumEWlen)
            cellLength = (maprect.Width - 10.0) / sumEWlen;
        
        left = 0.5 * maprect.Width - sumEWlen * cellLength / 2;
        top = 0.5 * maprect.Height - sumSNlen * cellLength / 2;

        right = 0.5 * maprect.Width + sumEWlen * cellLength / 2;
        bottom = 0.5 * maprect.Height + sumSNlen * cellLength / 2;

        int line;
        linkcumlen = 0;
        for (row = 0; row < EWSize; row++)// east west link
        {
            linkcumlen += maxSNlen[row];
            //top
            for (line = 0; line < 5; line++ )
            {
                x = left;
                y = top + linkcumlen * cellLength;

                originPoint.X = (int)x;
                originPoint.Y = (int)y;

                x = left + sumEWlen * cellLength;
                destinatePoint.X = (int)x;
                destinatePoint.Y = (int)y;
                gImage.DrawLine(linkPen, originPoint, destinatePoint);
                linkcumlen++;
            }
            linkcumlen--;
        }
        linkcumlen = 0;
        for (col = 0; col < SNSize; col++)// east west link
        {
            linkcumlen += maxEWlen[col];
            for (line = 0; line < 5; line++)
            {
                x = left + linkcumlen * cellLength;
                y = top;
                originPoint.X = (int)x;
                originPoint.Y = (int)y;

                y = top + sumSNlen * cellLength;
                destinatePoint.X = (int)x;
                destinatePoint.Y = (int)y;
                gImage.DrawLine(linkPen, originPoint, destinatePoint);
                linkcumlen++;
            }
            linkcumlen--;
        }
        //draw East - West cell        
       for (row = 0; row < EWSize; row++)
        {                 
            for (col = 0; col < SNSize + 1; col++)
            {
                newleft = left + cumEWlen[col] * cellLength;
                newcelllen = cellLength * maxEWlen[col] / EWLinkLength[row, col];
                for (cell = 0; cell <= EWLinkLength[row, col];cell++ )
                {
                    x = newleft + cell * newcelllen;
                    y = top + (cumSNlen[row + 1] - 4) * cellLength;                
                    originPoint.X = (int)x;
                    originPoint.Y = (int)y;

                    y = top + cumSNlen[row + 1] * cellLength;
                    destinatePoint.X = (int)x;
                    destinatePoint.Y = (int)y;
                    gImage.DrawLine(linkPen, originPoint, destinatePoint);
                }                
            }
        }
        //draw South - North cell
        for (col = 0; col < SNSize; col++)
        {           
            for (row = 0; row < EWSize + 1; row++)
            {
                newtop = top + cumSNlen[row] * cellLength;
                newcelllen = cellLength * maxSNlen[row] / SNLinkLength[col, row];
                for (cell = 0; cell <= SNLinkLength[col, row]; cell++)
                {
                    x = left + (cumEWlen[col + 1] - 4) * cellLength;
                    y = newtop + cell * newcelllen;
                    originPoint.X = (int)x;
                    originPoint.Y = (int)y;

                    x = left + cumEWlen[col + 1] * cellLength;                    
                    destinatePoint.X = (int)x;
                    destinatePoint.Y = (int)y;
                    gImage.DrawLine(linkPen, originPoint, destinatePoint);
                }                
            }
        }      
        linkPen.Dispose();
        //draw vehicle
        Pen leftPen = new Pen(Color.Red, 1);//pen for left turning vehicle
        leftPen.EndCap = LineCap.ArrowAnchor;

        Pen aheadPen = new Pen(Color.Green, 1);//pen for left turning vehicle
        aheadPen.EndCap = LineCap.ArrowAnchor;

        Pen rightPen = new Pen(Color.Brown, 1);//pen for left turning vehicle
        rightPen.EndCap = LineCap.ArrowAnchor;

        int link,veh,sn;
        CLink pLink;
        CVehicle pVehicle;
        CIntersection pIntersection;
        int reveh;

        //Vehicle on east-west link
        for (link = 0; link < m_EastWestLink.Count; link++)
        {
            pLink = (CLink)m_EastWestLink[link];
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                // the distance to stopline
                col = pVehicle.ColIndex;
                if (pVehicle.Position < EWLinkLenIndex[link, pVehicle.ColIndex])
                {
                    col--;
                }
                if (col < SNSize)
                    sn = EWLinkLenIndex[link, col + 1] - 5 - pVehicle.Position;
                else sn = EWLinkLength[link, 0] - (pVehicle.Position - EWLinkLenIndex[link, col]+1);
                
                col = SNSize - col;
                if (sn < 0)
                {
                    x = left + (cumEWlen[col]+sn+1-0.2) * cellLength;
                    originPoint.X = (int)x;

                    x = left + (cumEWlen[col] + sn + 0.2) * cellLength;
                    destinatePoint.X = (int)x;
                }
                else
                {
                    newcelllen = cellLength * maxEWlen[col] / EWLinkLength[link, col];
                    x = left + cumEWlen[col] * cellLength;
                    x += newcelllen * (sn + 1 - 0.2);
                    originPoint.X = (int)x;
                    x -= newcelllen * 0.6;
                    destinatePoint.X = (int)x;
                }
                y = top + (cumSNlen[link + 1] - 2.5) * cellLength;
                originPoint.Y = (int)y;
                destinatePoint.Y = (int)y;

                if (sn == 0 && pVehicle.Movement == LEFT)
                {
                    y -= 0.2 * cellLength;                    
                    originPoint.Y = (int)y;
                    y += 0.4*cellLength;
                    destinatePoint.Y = (int)y;
                }
                else if (sn == 0 && pVehicle.Movement == RIGHT)
                {
                    y += 0.2 * cellLength;
                    originPoint.Y = (int)y;
                    y -= 0.4 * cellLength;
                    destinatePoint.Y = (int)y;
                }

                if(pVehicle.Movement==LEFT)
                    gImage.DrawLine(leftPen, originPoint, destinatePoint);
                else if(pVehicle.Movement==AHEAD)
                    gImage.DrawLine(aheadPen, originPoint, destinatePoint);
                else
                    gImage.DrawLine(rightPen, originPoint, destinatePoint);
            }

            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                // the distance to stopline
                col = pVehicle.ColIndex;
                if (pVehicle.Position < EWLinkLenIndex[link, pVehicle.ColIndex])
                {
                    col--;
                }
                if (col < SNSize)
                    sn = EWLinkLenIndex[link, col + 1] - 5 - pVehicle.Position;
                else sn = EWLinkLength[link, 0] - (pVehicle.Position - EWLinkLenIndex[link, col] + 1);

                col = SNSize - col;
                if (sn < 0)
                {
                    x = left + (cumEWlen[col] + sn + 1 - 0.2) * cellLength;
                    originPoint.X = (int)x;

                    x = left + (cumEWlen[col] + sn + 0.2) * cellLength;
                    destinatePoint.X = (int)x;
                }
                else
                {
                    newcelllen = cellLength * maxEWlen[col] / EWLinkLength[link, col];
                    x = left + cumEWlen[col] * cellLength;
                    x += newcelllen * (sn + 1 - 0.2);
                    originPoint.X = (int)x;
                    x -= newcelllen * 0.6;
                    destinatePoint.X = (int)x;
                }
                y = top + (cumSNlen[link + 1] - 3.5) * cellLength;
                originPoint.Y = (int)y;
                destinatePoint.Y = (int)y;

                if (sn == 0 && pVehicle.Movement == LEFT)
                {
                    y -= 0.2 * cellLength;
                    originPoint.Y = (int)y;
                    y += 0.4 * cellLength;
                    destinatePoint.Y = (int)y;
                }
                else if (sn == 0 && pVehicle.Movement == RIGHT)
                {
                    y += 0.2 * cellLength;
                    originPoint.Y = (int)y;
                    y -= 0.4 * cellLength;
                    destinatePoint.Y = (int)y;
                }

                if (pVehicle.Movement == LEFT)
                    gImage.DrawLine(leftPen, originPoint, destinatePoint);
                else if (pVehicle.Movement == AHEAD)
                    gImage.DrawLine(aheadPen, originPoint, destinatePoint);
                else
                    gImage.DrawLine(rightPen, originPoint, destinatePoint);
            }
        }

        //Vehicle on west-east link
        for (link = 0; link < m_WestEastLink.Count; link++)
        {
            pLink = (CLink)m_WestEastLink[link];
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                // the distance to stopline
                col = pVehicle.ColIndex;
                if (pVehicle.Position < WELinkLenIndex[link, pVehicle.ColIndex])
                {
                    col--;
                }
                if (col < SNSize)
                    sn = WELinkLenIndex[link, col + 1] - 5 - pVehicle.Position;
                else sn = EWLinkLength[link, SNSize] - (pVehicle.Position - WELinkLenIndex[link, col] + 1);
                if (sn < 0)
                {
                    x = left + (cumEWlen[col+1] - 5 - sn + 0.2) * cellLength;                   
                    originPoint.X = (int)x;

                    x = left + (cumEWlen[col+1] - 4 - sn - 0.2) * cellLength;
                    destinatePoint.X = (int)x;
                }
                else
                {
                    newcelllen = cellLength * maxEWlen[col] / EWLinkLength[link, col];
                    x = left + (cumEWlen[col] + maxEWlen[col]) * cellLength;
                    x -= newcelllen * (sn +1 - 0.2);                   
                    originPoint.X = (int)x;
                    x += newcelllen * 0.6;
                    destinatePoint.X = (int)x;
                }
                y = top + (cumSNlen[link + 1] - 1.5) * cellLength;
                originPoint.Y = (int)y;
                destinatePoint.Y = (int)y;

                if (sn == 0 && pVehicle.Movement == LEFT)
                {
                    y += 0.2 * cellLength;
                    originPoint.Y = (int)y;
                    y -= 0.4 * cellLength;
                    destinatePoint.Y = (int)y;
                }
                else if (sn == 0 && pVehicle.Movement == RIGHT)
                {
                    y -= 0.2 * cellLength;
                    originPoint.Y = (int)y;
                    y += 0.4 * cellLength;
                    destinatePoint.Y = (int)y;
                }

                if (pVehicle.Movement == LEFT)
                    gImage.DrawLine(leftPen, originPoint, destinatePoint);
                else if (pVehicle.Movement == AHEAD)
                    gImage.DrawLine(aheadPen, originPoint, destinatePoint);
                else
                    gImage.DrawLine(rightPen, originPoint, destinatePoint);
            }

            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                // the distance to stopline
                col = pVehicle.ColIndex;
                if (pVehicle.Position < WELinkLenIndex[link, pVehicle.ColIndex])
                {
                    col--;
                }
                if (col < SNSize)
                    sn = WELinkLenIndex[link, col + 1] - 5 - pVehicle.Position;
                else sn = EWLinkLength[link, SNSize] - (pVehicle.Position - WELinkLenIndex[link, col] + 1);
                if (sn < 0)
                {
                    x = left + (cumEWlen[col + 1] - 5 - sn + 0.2) * cellLength;
                    originPoint.X = (int)x;

                    x = left + (cumEWlen[col + 1] - 4 - sn - 0.2) * cellLength;
                    destinatePoint.X = (int)x;
                }
                else
                {
                    newcelllen = cellLength * maxEWlen[col] / EWLinkLength[link, col];
                    x = left + (cumEWlen[col] + maxEWlen[col]) * cellLength;
                    x -= newcelllen * (sn+1 - 0.2);
                    originPoint.X = (int)x;
                    x += newcelllen * 0.6;
                    destinatePoint.X = (int)x;
                }
                y = top + (cumSNlen[link + 1] - 0.5) * cellLength;
                originPoint.Y = (int)y;
                destinatePoint.Y = (int)y;

                if (sn == 0 && pVehicle.Movement == LEFT)
                {
                    y += 0.2 * cellLength;
                    originPoint.Y = (int)y;
                    y -= 0.4 * cellLength;
                    destinatePoint.Y = (int)y;
                }
                else if (sn == 0 && pVehicle.Movement == RIGHT)
                {
                    y -= 0.2 * cellLength;
                    originPoint.Y = (int)y;
                    y += 0.4 * cellLength;
                    destinatePoint.Y = (int)y;
                }

                if (pVehicle.Movement == LEFT)
                    gImage.DrawLine(leftPen, originPoint, destinatePoint);
                else if (pVehicle.Movement == AHEAD)
                    gImage.DrawLine(aheadPen, originPoint, destinatePoint);
                else
                    gImage.DrawLine(rightPen, originPoint, destinatePoint);
            }
        }

        //Vehicle on south-north link
        for (link = 0; link < m_SouthNorthLink.Count; link++)
        {
            pLink = (CLink)m_SouthNorthLink[link];
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                // the distance to stopline
                row = pVehicle.RowIndex;
                if (pVehicle.Position < SNLinkLenIndex[link, pVehicle.RowIndex])
                {
                    row--;
                }
                if (row < EWSize)
                    sn = SNLinkLenIndex[link, row + 1] - 5 - pVehicle.Position;
                else sn = SNLinkLength[link, 0] - (pVehicle.Position - SNLinkLenIndex[link, row] + 1);

                row = EWSize - row;                
                if (sn < 0)
                {
                    y = top + (cumSNlen[row] + sn + 1 - 0.2) * cellLength;
                    originPoint.Y = (int)y;

                    y = top + (cumSNlen[row] + sn + 0.2) * cellLength;
                    destinatePoint.Y = (int)y;
                }
                else
                {
                    newcelllen = cellLength * maxSNlen[row] / SNLinkLength[link, row];
                    y = top + cumSNlen[row] * cellLength;
                    y += newcelllen * (sn + 1 - 0.2);
                    originPoint.Y = (int)y;
                    y -= newcelllen * 0.6;
                    destinatePoint.Y = (int)y;
                }
                x = left + (cumEWlen[link + 1] - 1.5) * cellLength;
                originPoint.X = (int)x;
                destinatePoint.X = (int)x;

                if (sn == 0 && pVehicle.Movement == LEFT)
                {
                    x += 0.2 * cellLength;
                    originPoint.X = (int)x;
                    x -= 0.4 * cellLength;
                    destinatePoint.X = (int)x;
                }
                else if (sn == 0 && pVehicle.Movement == RIGHT)
                {
                    x -= 0.2 * cellLength;
                    originPoint.X = (int)x;
                    x += 0.4 * cellLength;
                    destinatePoint.X = (int)x;
                }

                if (pVehicle.Movement == LEFT)
                    gImage.DrawLine(leftPen, originPoint, destinatePoint);
                else if (pVehicle.Movement == AHEAD)
                    gImage.DrawLine(aheadPen, originPoint, destinatePoint);
                else
                    gImage.DrawLine(rightPen, originPoint, destinatePoint);
            }

            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                // the distance to stopline
                row = pVehicle.RowIndex;
                if (pVehicle.Position < SNLinkLenIndex[link, pVehicle.RowIndex])
                {
                    row--;
                }
                if (row < EWSize)
                    sn = SNLinkLenIndex[link, row + 1] - 5 - pVehicle.Position;
                else sn = SNLinkLength[link, 0] - (pVehicle.Position - SNLinkLenIndex[link, row] + 1);

                row = EWSize - row;
                if (sn < 0)
                {
                    y = top + (cumSNlen[row] + sn + 1 - 0.2) * cellLength;
                    originPoint.Y = (int)y;

                    y = top + (cumSNlen[row] + sn + 0.2) * cellLength;
                    destinatePoint.Y = (int)y;
                }
                else
                {
                    newcelllen = cellLength * maxSNlen[row] / SNLinkLength[link, row];
                    y = top + cumSNlen[row] * cellLength;
                    y += newcelllen * (sn + 1 - 0.2);
                    originPoint.Y = (int)y;
                    y -= newcelllen * 0.6;
                    destinatePoint.Y = (int)y;
                }
                x = left + (cumEWlen[link + 1] - 0.5) * cellLength;
                originPoint.X = (int)x;
                destinatePoint.X = (int)x;

                if (sn == 0 && pVehicle.Movement == LEFT)
                {
                    x += 0.2 * cellLength;
                    originPoint.X = (int)x;
                    x -= 0.4 * cellLength;
                    destinatePoint.X = (int)x;
                }
                else if (sn == 0 && pVehicle.Movement == RIGHT)
                {
                    x -= 0.2 * cellLength;
                    originPoint.X = (int)x;
                    x += 0.4 * cellLength;
                    destinatePoint.X = (int)x;
                }

                if (pVehicle.Movement == LEFT)
                    gImage.DrawLine(leftPen, originPoint, destinatePoint);
                else if (pVehicle.Movement == AHEAD)
                    gImage.DrawLine(aheadPen, originPoint, destinatePoint);
                else
                    gImage.DrawLine(rightPen, originPoint, destinatePoint);
            }
        }

        //Vehicle on north-south link
        for (link = 0; link < m_NorthSouthLink.Count; link++)
        {
            pLink = (CLink)m_NorthSouthLink[link];
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                // the distance to stopline
                row = pVehicle.RowIndex;
                if (pVehicle.Position < NSLinkLenIndex[link, pVehicle.RowIndex])
                {
                    row--;
                }
                if (row < EWSize)
                    sn = NSLinkLenIndex[link, row + 1] - 5 - pVehicle.Position;
                else sn = SNLinkLength[link, EWSize] - (pVehicle.Position - NSLinkLenIndex[link, row] + 1);
                if (sn < 0)
                {
                    y = top + (cumSNlen[row + 1] - 5 - sn + 0.2) * cellLength;
                    originPoint.Y = (int)y;

                    y = top + (cumSNlen[row + 1] - 4 - sn - 0.2) * cellLength;
                    destinatePoint.Y = (int)y;
                }
                else
                {
                    newcelllen = cellLength * maxSNlen[row] / SNLinkLength[link, row];
                    y = top + (cumSNlen[row] + maxSNlen[row]) * cellLength;
                    y -= newcelllen * (sn + 1 - 0.2);
                    originPoint.Y = (int)y;
                    y += newcelllen * 0.6;
                    destinatePoint.Y = (int)y;
                }
                x = left + (cumEWlen[link + 1] - 2.5) * cellLength;
                originPoint.X = (int)x;
                destinatePoint.X = (int)x;

                if (sn == 0 && pVehicle.Movement == LEFT)
                {
                    x -= 0.2 * cellLength;
                    originPoint.X = (int)x;
                    x += 0.4 * cellLength;
                    destinatePoint.X = (int)x;
                }
                else if (sn == 0 && pVehicle.Movement == RIGHT)
                {
                    x += 0.2 * cellLength;
                    originPoint.X = (int)x;
                    x -= 0.4 * cellLength;
                    destinatePoint.X = (int)x;
                }

                if (pVehicle.Movement == LEFT)
                    gImage.DrawLine(leftPen, originPoint, destinatePoint);
                else if (pVehicle.Movement == AHEAD)
                    gImage.DrawLine(aheadPen, originPoint, destinatePoint);
                else
                    gImage.DrawLine(rightPen, originPoint, destinatePoint);
            }

            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                // the distance to stopline
                row = pVehicle.RowIndex;
                if (pVehicle.Position < NSLinkLenIndex[link, pVehicle.RowIndex])
                {
                    row--;
                }
                if (row < EWSize)
                    sn = NSLinkLenIndex[link, row + 1] - 5 - pVehicle.Position;
                else sn = SNLinkLength[link, EWSize] - (pVehicle.Position - NSLinkLenIndex[link, row] + 1);
                if (sn < 0)
                {
                    y = top + (cumSNlen[row + 1] - 5 - sn + 0.2) * cellLength;
                    originPoint.Y = (int)y;

                    y = top + (cumSNlen[row + 1] - 4 - sn - 0.2) * cellLength;
                    destinatePoint.Y = (int)y;
                }
                else
                {
                    newcelllen = cellLength * maxSNlen[row] / SNLinkLength[link, row];
                    y = top + (cumSNlen[row] + maxSNlen[row]) * cellLength;
                    y -= newcelllen * (sn + 1 - 0.2);
                    originPoint.Y = (int)y;
                    y += newcelllen * 0.6;
                    destinatePoint.Y = (int)y;
                }
                x = left + (cumEWlen[link + 1] - 3.5) * cellLength;
                originPoint.X = (int)x;
                destinatePoint.X = (int)x;

                if (sn == 0 && pVehicle.Movement == LEFT)
                {
                    x -= 0.2 * cellLength;
                    originPoint.X = (int)x;
                    x += 0.4 * cellLength;
                    destinatePoint.X = (int)x;
                }
                else if (sn == 0 && pVehicle.Movement == RIGHT)
                {
                    x += 0.2 * cellLength;
                    originPoint.X = (int)x;
                    x -= 0.4 * cellLength;
                    destinatePoint.X = (int)x;
                }

                if (pVehicle.Movement == LEFT)
                    gImage.DrawLine(leftPen, originPoint, destinatePoint);
                else if (pVehicle.Movement == AHEAD)
                    gImage.DrawLine(aheadPen, originPoint, destinatePoint);
                else
                    gImage.DrawLine(rightPen, originPoint, destinatePoint);
            }
        }
        // vehicle in intersection
        for (row = 0; row < EWSize; row++ )
        {
            for (col = 0; col < SNSize; col++ )
            {
                pIntersection = (CIntersection)m_Intersection[row * SNSize + col];
                for (veh = 0; veh < pIntersection.m_Vehicle.Count; veh++ )
                {
                    pVehicle = (CVehicle)pIntersection.m_Vehicle[veh];
                    switch (pVehicle.Position)
                    {
                        case 1:// WE - SN
                            x = left + (cumEWlen[ col+ 1]-2.8)*cellLength;                            
                            y = top + (cumSNlen[row + 1] - 3.3) * cellLength;
                            originPoint.X = (int)x;
                            originPoint.Y = (int)y;

                            x = left + (cumEWlen[col + 1] - 2.2) * cellLength;
                            y = top + (cumSNlen[ row+ 1] - 3.7) * cellLength;

                            destinatePoint.X = (int)x;
                            destinatePoint.Y = (int)y;
                            break;
                        case 2:// NS - WE
                            x = left + (cumEWlen[col + 1] - 1.7) * cellLength;
                            y = top + (cumSNlen[ row+ 1] - 3.8) * cellLength;

                            originPoint.X = (int)x;
                            originPoint.Y = (int)y;

                            x = left + (cumEWlen[ col+ 1] - 1.3) * cellLength;
                            y = top + (cumSNlen[ row+ 1] - 3.2) * cellLength; 
                            
                            destinatePoint.X = (int)x;
                            destinatePoint.Y = (int)y;
                            break;

                        case 4: // WE-SN
                            x = left + (cumEWlen[ col+ 1] - 3.8) * cellLength;
                            y = top + (cumSNlen[row + 1] - 2.3) * cellLength;
                            originPoint.X = (int)x;
                            originPoint.Y = (int)y;

                            x = left + (cumEWlen[col + 1] - 3.2) * cellLength;
                            y = top + (cumSNlen[row + 1] - 2.7) * cellLength;

                            destinatePoint.X = (int)x;
                            destinatePoint.Y = (int)y;
                            break;
                        case 7:// NS - WE
                            x = left + (cumEWlen[col + 1] - 0.7) * cellLength;
                            y = top + (cumSNlen[ row+ 1] - 2.8) * cellLength;
                            originPoint.X = (int)x;
                            originPoint.Y = (int)y;
                            
                            x = left + (cumEWlen[col + 1] - 0.3) * cellLength;
                            y = top + (cumSNlen[ row+ 1] - 2.2) * cellLength;

                            destinatePoint.X = (int)x;
                            destinatePoint.Y = (int)y;
                            break;
                        case 8:// SN - EW
                            x = left + (cumEWlen[ col+ 1] - 3.3) * cellLength;
                            y = top + (cumSNlen[ row+ 1] - 1.2) * cellLength;
                            originPoint.X = (int)x;
                            originPoint.Y = (int)y;

                            x = left + (cumEWlen[ col+ 1] - 3.7) * cellLength;
                            y = top + (cumSNlen[ row+ 1] - 1.8) * cellLength;

                            destinatePoint.X = (int)x;
                            destinatePoint.Y = (int)y;
                            break;
                        case 11:// EW - NS
                            x = left + (cumEWlen[col + 1] - 0.2) * cellLength;
                            y = top + (cumSNlen[ row+ 1] - 1.7) * cellLength;
                            originPoint.X = (int)x;
                            originPoint.Y = (int)y;

                            x = left + (cumEWlen[ col+ 1] - 0.8) * cellLength;
                            y = top + (cumSNlen[ row+ 1] - 1.3) * cellLength;

                            destinatePoint.X = (int)x;
                            destinatePoint.Y = (int)y;
                            break;
                        case 13:// NS - WE
                            x = left + (cumEWlen[ col+ 1] - 2.3) * cellLength;
                            y = top + (cumSNlen[ row+ 1] - 0.2) * cellLength;
                            originPoint.X = (int)x;
                            originPoint.Y = (int)y;

                            x = left + (cumEWlen[col + 1] - 2.7) * cellLength;
                            y = top + (cumSNlen[ row+ 1] - 0.8) * cellLength;

                            destinatePoint.X = (int)x;
                            destinatePoint.Y = (int)y;
                            break;
                        case 14:// EW - NS
                            x = left + (cumEWlen[col + 1] - 1.2) * cellLength;
                            y = top + (cumSNlen[ row+ 1] - 0.7) * cellLength;
                            originPoint.X = (int)x;
                            originPoint.Y = (int)y;

                            x = left + (cumEWlen[ col+ 1] - 1.8) * cellLength;
                            y = top + (cumSNlen[ row+ 1] - 0.3) * cellLength;

                            destinatePoint.X = (int)x;
                            destinatePoint.Y = (int)y;
                            break;
                    }
                    if (pVehicle.Movement == LEFT)
                        gImage.DrawLine(leftPen, originPoint, destinatePoint);
                    else if (pVehicle.Movement == AHEAD)
                        gImage.DrawLine(aheadPen, originPoint, destinatePoint);
                    else
                        gImage.DrawLine(rightPen, originPoint, destinatePoint);
                }
            }
        }
 
        int radius=6;
        Point circlePoint=new Point();
        SolidBrush greenBrush = new SolidBrush(Color.Green);
        SolidBrush yellowBrush = new SolidBrush(Color.Yellow);
        SolidBrush redBrush = new SolidBrush(Color.Red);
        //signal
        for (row = 0; row < EWSize; row++)
        {
            for (col = 0; col < SNSize; col++)
            {
                pIntersection = (CIntersection)m_Intersection[row * NetworkSize + col];
                // signal for EastWest
                x = left + (cumEWlen[col + 1] - 4) * cellLength;
                y = top + (cumSNlen[row + 1] - 4) * cellLength;
             
                x -= 1.5 * radius;
                y -= 1.5 * radius;
                circlePoint.X = (int)x;
                circlePoint.Y = (int)y;
                if (SignalPhase[row,col] == 0)                           
                    gImage.FillEllipse(greenBrush, circlePoint.X - radius, circlePoint.Y - radius, 2 * radius, 2 * radius);                
                else
                    gImage.FillEllipse(redBrush, circlePoint.X - radius, circlePoint.Y - radius, 2 * radius, 2 * radius);

                //signal fot WestEast
                x = left + cumEWlen[col + 1] * cellLength;
                y = top + cumSNlen[row + 1] * cellLength;
                
                x += 1.5 * radius;
                y += 1.5 * radius;
                circlePoint.X = (int)x;
                circlePoint.Y = (int)y;
                if (SignalPhase[row, col] == 2)
                    gImage.FillEllipse(greenBrush, circlePoint.X - radius, circlePoint.Y - radius, 2 * radius, 2 * radius);                
                else
                    gImage.FillEllipse(redBrush, circlePoint.X - radius, circlePoint.Y - radius, 2 * radius, 2 * radius);

                //signal for Southnorth
                x = left + cumEWlen[col + 1] * cellLength;
                y = top + (cumSNlen[row + 1] - 4) * cellLength;
                                
                x += 1.5 * radius;
                y -= 1.5 * radius;
                circlePoint.X = (int)x;
                circlePoint.Y = (int)y;
                if (SignalPhase[row, col] == 1)
                    gImage.FillEllipse(greenBrush, circlePoint.X - radius, circlePoint.Y - radius, 2 * radius, 2 * radius);                
                else
                    gImage.FillEllipse(redBrush, circlePoint.X - radius, circlePoint.Y - radius, 2 * radius, 2 * radius);

                //signal for north south
                x = left + (cumEWlen[col + 1] - 4) * cellLength;
                y = top + cumSNlen[row + 1] * cellLength;
                x -= 1.5 * radius;
                y += 1.5 * radius;
                circlePoint.X = (int)x;
                circlePoint.Y = (int)y;
                if (SignalPhase[row, col] == 3)
                    gImage.FillEllipse(greenBrush, circlePoint.X - radius, circlePoint.Y - radius, 2 * radius, 2 * radius);                
                else
                    gImage.FillEllipse(redBrush, circlePoint.X - radius, circlePoint.Y - radius, 2 * radius, 2 * radius);
            }
        }
        return (bmp);
    }  
    public void SetSignalPhase(int interval)
    {
        int phasetime;
        int row, col;
        for (row = 0; row < EWSize; row++ )
        {
            for (col = 0; col < SNSize; col++)
            {
                phasetime = interval - PhaseDelay[row, col];
                while (phasetime < 0)
                {
                    phasetime += SignalPeriod[row, col];
                }
                phasetime = phasetime%SignalPeriod[row, col];
                if (phasetime >= EastBegTime[row, col] && phasetime <= EastEndTime[row, col]) SignalPhase[row, col] = 0;
                else if (phasetime >= SouthBegTime[row, col] && phasetime <= SouthEndTime[row, col]) SignalPhase[row, col] = 1;
                else if (phasetime >= WestBegTime[row, col] && phasetime <= WestEndTime[row, col]) SignalPhase[row, col] = 2;
                else if (phasetime >= NorthBegTime[row, col] && phasetime <= NorthEndTime[row, col]) SignalPhase[row, col] = 3;
                else SignalPhase[row, col] = -1;                     
            }
        }
    }
    public void EastWestVehicleNextMovement()
    {       

        int veh, reveh, link, rightveh;
        CVehicle pVehicle, pNextVehicle,  potherVehicle;             
        CLink pLink;
        int  dn, sn, rigthPosi;    
        bool bRedPhase;
        int speed;
        CLink pRightTurningLink;
        //*******************sort vehicle*************************************
        CVehiclePositionCompare pCompare = new CVehiclePositionCompare();        
        // East West
        for (link = 0; link < m_EastWestLink.Count; link++)
        {
            pLink = (CLink)m_EastWestLink[link];
            pLink.m_InnerVehicle.Sort(pCompare);
            pLink.m_OuterVehicle.Sort(pCompare);

            int[] dn1back = new int[pLink.m_InnerVehicle.Count];
            int[] dn2back = new int[pLink.m_OuterVehicle.Count];

            int[] dn1other = new int[pLink.m_InnerVehicle.Count];
            int[] dn2other = new int[pLink.m_OuterVehicle.Count];

            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                dn1back[veh] = 100;
                dn1other[veh] = 100;
            }
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                dn2back[reveh] = 100;
                dn2other[reveh] = 100;
            }
            veh = 0;
            reveh = 0;
            while (veh < pLink.m_InnerVehicle.Count && reveh < pLink.m_OuterVehicle.Count)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                potherVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.Position >= potherVehicle.Position)
                {
                    dn1back[veh] = pVehicle.Position - potherVehicle.Position - 1;
                    dn2other[reveh] = dn1back[veh];
                    reveh++;
                }
                else
                {
                    dn2back[reveh] = potherVehicle.Position - pVehicle.Position - 1;
                    dn1other[veh] = dn2back[reveh];
                    veh++;
                }
            }

            // vehicle of inner lane
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                //check whether the signal phase is red
                bRedPhase = false;
                if (pVehicle.ColIndex < SNSize)
                {
                    if (SignalPhase[link, SNSize - pVehicle.ColIndex - 1] != 0) // red phase
                        bRedPhase = true;
                }
                // the distance to stopline               
                if (pVehicle.ColIndex < SNSize)
                {
                    sn = EWLinkLenIndex[link, pVehicle.ColIndex + 1] - 5 - pVehicle.Position;//过停车线col++
                    if (sn < 0)
                    {
                        pVehicle.ColIndex++;
                        if (pVehicle.ColIndex < SNSize)
                            sn = EWLinkLenIndex[link, pVehicle.ColIndex + 1] - 5 - pVehicle.Position;
                        else
                            sn = 100;
                    }
                }
                else   sn = 100;
                // distance to ahead vehicle
                if (veh < pLink.m_InnerVehicle.Count - 1)
                {
                    pNextVehicle = (CVehicle)pLink.m_InnerVehicle[veh + 1];
                    dn = pNextVehicle.Position - pVehicle.Position - 1;
                }
                else dn = 100;
                //分车辆类型考虑
                if (pVehicle.Movement == AHEAD)// ahead vehicle
                {
                    // accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;

                    speed = pVehicle.Velocity + 1;
                    if (speed > vmax) speed = vmax;
                    // lane changing
                    if (sn > pLink.Channellen && dn1back[veh] > dSafe && dn < speed && dn1other[veh] > dn)
                    {
                        pVehicle.bLaneChange = true;                        
                        // decelerate                        
                        if (pVehicle.NextVelocity > dn1other[veh]) pVehicle.NextVelocity = dn1other[veh];                        
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;                        
                        //decelerate                       
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                        // consider signal control
                        if (bRedPhase && pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;                        
                    }
                    // random slow down
                    if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;                    
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }
                else if (pVehicle.Movement == LEFT)// left turning
                {
                    // do not lane changing
                    pVehicle.bLaneChange = false;
                    //accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                    if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                    if (sn != 0)
                    {
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                        // random slow down
                        if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                        //update position
                        if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                        pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                    }
                    else
                    {
                        if (bRedPhase)
                        {
                            pVehicle.NextVelocity = 0;
                            pVehicle.NextPosition = pVehicle.Position;
                        }
                        else// move into intersection
                        {
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = 11;
                            pVehicle.bIntoIntersection = true;
                        }
                    }
                }
                else //right turning 
                {
                    sn -= pLink.Channellen;
                    // consider lane changing
                    if (dn1back[veh] > dSafe && dn1other[veh] >= 0)
                    {
                        pVehicle.bLaneChange = true;
                        // accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        // decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn1other[veh]) pVehicle.NextVelocity = dn1other[veh];                       
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;
                        //accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        //decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                        // consider signal control
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;                        
                    }
                    //consider the special case
                    if (sn ==0)
                    {
                        for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
                        {
                            potherVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                            if (potherVehicle.Position == pVehicle.Position && potherVehicle.Movement == LEFT)
                            {
                                if (reveh + 1 < pLink.m_OuterVehicle.Count)
                                {
                                    pNextVehicle = (CVehicle)pLink.m_OuterVehicle[reveh + 1];
                                    dn = pNextVehicle.Position - potherVehicle.Position;
                                }
                                else dn = 100;
                                pVehicle.bLaneChange = true;
                                pVehicle.NextVelocity = pVehicle.Velocity + 1;
                                //decelerate
                                if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                                if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                            }
                        }
                    }
                    // random slow down
                    if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }
                //check destination
                if (veh == pLink.m_InnerVehicle.Count-1)
                {
                    if (pVehicle.Movement == AHEAD)
                    {
                        if (pVehicle.NextPosition >= EWLinkLenIndex[link, SNSize] + EWLinkLength[link, 0])
                        {
                            pLink.m_InnerVehicle.RemoveAt(veh);
                        }
                    }
                }
            }
            //*****************************************************************
            // vehicles of outer lane
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                //check whether the signal phase is red
                bRedPhase = false;
                if (pVehicle.ColIndex < SNSize)
                {
                    if (SignalPhase[link, SNSize - pVehicle.ColIndex - 1] != 0) // red phase
                        bRedPhase = true;
                }
                // the distance to stopline
                if (pVehicle.ColIndex < SNSize)
                {
                    sn = EWLinkLenIndex[link, pVehicle.ColIndex + 1] - 5 - pVehicle.Position;//过停车线col++
                    if (sn < 0)
                    {
                        pVehicle.ColIndex++;
                        if (pVehicle.ColIndex < SNSize)
                            sn = EWLinkLenIndex[link, pVehicle.ColIndex + 1] - 5 - pVehicle.Position;
                        else
                            sn = 100;
                    }
                }
                else sn = 100;
                // distance to ahead vehicle
                if (reveh < pLink.m_OuterVehicle.Count - 1)
                {
                    pNextVehicle = (CVehicle)pLink.m_OuterVehicle[reveh + 1];
                    dn = pNextVehicle.Position - pVehicle.Position - 1;
                }
                else dn = 100;
                //分车辆类型考虑
                if (pVehicle.Movement == AHEAD)// ahead vehicle
                {
                    // accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;

                    speed = pVehicle.Velocity + 1;
                    if (speed > vmax) speed = vmax;
                    // lane changing
                    if (sn > pLink.Channellen && dn2back[reveh] > dSafe && dn < speed && dn2other[reveh] > dn)
                    {
                        pVehicle.bLaneChange = true;
                        // decelerate                        
                        if (pVehicle.NextVelocity > dn2other[reveh]) pVehicle.NextVelocity = dn2other[reveh];
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;
                        //decelerate                       
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                        // consider signal control
                        if (bRedPhase && pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                    }
                    // random slow down
                    if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }
                else if (pVehicle.Movement == LEFT)// left turning
                {
                    sn -= pLink.Channellen;
                    // consider lane changing
                    if (dn2back[reveh] > dSafe && dn2other[reveh] >= 0)
                    {
                        pVehicle.bLaneChange = true;
                        // accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        // decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn2other[reveh]) pVehicle.NextVelocity = dn2other[reveh];
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;
                        //accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        //decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                        // consider signal control
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                    }
                    // random slow down
                    if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }
                else //right turning 
                {
                    // do not lane changing
                    pVehicle.bLaneChange = false;
                    //accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                    if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                    if (sn != 0)
                    {
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                        // random slow down
                        if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                        //update position
                        if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                        pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                    }
                    else
                    {
                        // can it be turning?                        
                        // move to south - north link
                        pRightTurningLink = (CLink)m_SouthNorthLink[SNSize - pVehicle.ColIndex -1];
                        rigthPosi = SNLinkLenIndex[SNSize - pVehicle.ColIndex -1, EWSize - link];
                        bool brigthTurning = true;
                        for (rightveh = 0; rightveh < pRightTurningLink.m_OuterVehicle.Count; rightveh++ )
                        {
                            potherVehicle = (CVehicle)pRightTurningLink.m_OuterVehicle[rightveh];
                            // the condition of cannot turning
                            if (potherVehicle.Position <= rigthPosi && potherVehicle.Position + potherVehicle.Velocity + 1 >= rigthPosi)
                            {
                                brigthTurning = false;
                                break;
                            }
                            if (potherVehicle.Position > rigthPosi) break;
                        }
                        if (brigthTurning)
                        {
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = rigthPosi;
                            pVehicle.bIntoIntersection = true;
                        }
                        else
                        {
                            pVehicle.NextVelocity = 0;
                            pVehicle.NextPosition = pVehicle.Position;
                            pVehicle.bIntoIntersection = false;
                        }
                    }
                }
                //check destination
                if (reveh == pLink.m_OuterVehicle.Count - 1)
                {
                    if (pVehicle.Movement == AHEAD)
                    {
                        if (pVehicle.NextPosition >= EWLinkLenIndex[link, SNSize] + EWLinkLength[link, 0])
                        {
                            pLink.m_OuterVehicle.RemoveAt(reveh);
                        }
                    }
                }
            }
            // the end
        }
    }
    public void WestEastVehicleNextMovement()
    {
        int veh, reveh, link, rightveh;
        CVehicle pVehicle, pNextVehicle, potherVehicle;
        CLink pLink;
        int dn, sn, rigthPosi;
        bool bRedPhase;
        int speed;
        CLink pRightTurningLink;
        //*******************sort vehicle*************************************
        CVehiclePositionCompare pCompare = new CVehiclePositionCompare();
        // West - East
        for (link = 0; link < m_WestEastLink.Count; link++)
        {
            pLink = (CLink)m_WestEastLink[link];
            pLink.m_InnerVehicle.Sort(pCompare);
            pLink.m_OuterVehicle.Sort(pCompare);

            int[] dn1back = new int[pLink.m_InnerVehicle.Count];
            int[] dn2back = new int[pLink.m_OuterVehicle.Count];

            int[] dn1other = new int[pLink.m_InnerVehicle.Count];
            int[] dn2other = new int[pLink.m_OuterVehicle.Count];

            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                dn1back[veh] = 100;
                dn1other[veh] = 100;
            }
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                dn2back[reveh] = 100;
                dn2other[reveh] = 100;
            }
            veh = 0;
            reveh = 0;
            while (veh < pLink.m_InnerVehicle.Count && reveh < pLink.m_OuterVehicle.Count)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                potherVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.Position >= potherVehicle.Position)
                {
                    dn1back[veh] = pVehicle.Position - potherVehicle.Position - 1;
                    dn2other[reveh] = dn1back[veh];
                    reveh++;
                }
                else
                {
                    dn2back[reveh] = potherVehicle.Position - pVehicle.Position - 1;
                    dn1other[veh] = dn2back[reveh];
                    veh++;
                }
            }
            // vehicle of inner lane
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                //check whether the signal phase is red
                bRedPhase = false;
                if (pVehicle.ColIndex < SNSize)
                {
                    if (SignalPhase[link, pVehicle.ColIndex] != 2) // red phase of West
                        bRedPhase = true;
                }
                // the distance to stopline               
                if (pVehicle.ColIndex < SNSize)
                {
                    sn = WELinkLenIndex[link, pVehicle.ColIndex + 1] - 5 - pVehicle.Position;//过停车线col++
                    if (sn < 0)
                    {
                        pVehicle.ColIndex++;
                        if (pVehicle.ColIndex < SNSize)
                            sn = WELinkLenIndex[link, pVehicle.ColIndex + 1] - 5 - pVehicle.Position;
                        else
                            sn = 100;
                    }
                }
                else sn = 100;
                // distance to ahead vehicle
                if (veh < pLink.m_InnerVehicle.Count - 1)
                {
                    pNextVehicle = (CVehicle)pLink.m_InnerVehicle[veh + 1];
                    dn = pNextVehicle.Position - pVehicle.Position - 1;
                }
                else dn = 100;
                //分车辆类型考虑
                if (pVehicle.Movement == AHEAD)// ahead vehicle
                {
                    // accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;

                    speed = pVehicle.Velocity + 1;
                    if (speed > vmax) speed = vmax;
                    // lane changing
                    if (sn > pLink.Channellen && dn1back[veh] > dSafe && dn < speed && dn1other[veh] > dn)
                    {
                        pVehicle.bLaneChange = true;
                        // decelerate                        
                        if (pVehicle.NextVelocity > dn1other[veh]) pVehicle.NextVelocity = dn1other[veh];
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;
                        //decelerate                       
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                        // consider signal control
                        if (bRedPhase && pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                    }
                    // random slow down
                    if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }
                else if (pVehicle.Movement == LEFT)// left turning
                {
                    // do not lane changing
                    pVehicle.bLaneChange = false;
                    //accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                    if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                    if (sn != 0)
                    {
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                        // random slow down
                        if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                        //update position
                        if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                        pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                    }
                    else
                    {
                        if (bRedPhase)
                        {
                            pVehicle.NextVelocity = 0;
                            pVehicle.NextPosition = pVehicle.Position;                            
                        }
                        else// move into intersection
                        {
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = 4;
                            pVehicle.bIntoIntersection = true;
                        }
                    }
                }
                else //right turning 
                {
                    sn -= pLink.Channellen;
                    // consider lane changing
                    if (dn1back[veh] > dSafe && dn1other[veh] >= 0)
                    {
                        pVehicle.bLaneChange = true;
                        // accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        // decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn1other[veh]) pVehicle.NextVelocity = dn1other[veh];
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;
                        //accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        //decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                        // consider signal control
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                    }
                    //consider the special case
                    if (sn == 0)
                    {
                        for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
                        {
                            potherVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                            if (potherVehicle.Position == pVehicle.Position && potherVehicle.Movement == LEFT)
                            {
                                if (reveh + 1 < pLink.m_OuterVehicle.Count)
                                {
                                    pNextVehicle = (CVehicle)pLink.m_OuterVehicle[reveh + 1];
                                    dn = pNextVehicle.Position - potherVehicle.Position;
                                }
                                else dn = 100;
                                pVehicle.bLaneChange = true;
                                pVehicle.NextVelocity = pVehicle.Velocity + 1;
                                //decelerate
                                if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                                if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                            }
                        }
                    }
                    // random slow down
                    if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }
                //check destination
                if (veh == pLink.m_InnerVehicle.Count - 1)
                {
                    if (pVehicle.Movement == AHEAD)
                    {
                        if (pVehicle.NextPosition >= WELinkLenIndex[link, SNSize] + EWLinkLength[link, SNSize])
                        {
                            pLink.m_InnerVehicle.RemoveAt(veh);
                        }
                    }
                }
            }
            //*****************************************************************
            // vehicles of outer lane
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                //check whether the signal phase is red
                bRedPhase = false;
                if (pVehicle.ColIndex < SNSize)
                {
                    if (SignalPhase[link, pVehicle.ColIndex] != 2) // red phase
                        bRedPhase = true;
                }
                // the distance to stopline    
                if (pVehicle.ColIndex < SNSize)
                {
                    sn = WELinkLenIndex[link, pVehicle.ColIndex + 1] - 5 - pVehicle.Position;//过停车线col++
                    if (sn < 0)
                    {
                        pVehicle.ColIndex++;
                        if (pVehicle.ColIndex < SNSize)
                            sn = WELinkLenIndex[link, pVehicle.ColIndex + 1] - 5 - pVehicle.Position;
                        else
                            sn = 100;
                    }
                }
                else sn = 100;
                // distance to ahead vehicle
                if (reveh < pLink.m_OuterVehicle.Count - 1)
                {
                    pNextVehicle = (CVehicle)pLink.m_OuterVehicle[reveh + 1];
                    dn = pNextVehicle.Position - pVehicle.Position - 1;
                }
                else dn = 100;
                //分车辆类型考虑
                if (pVehicle.Movement == AHEAD)// ahead vehicle
                {
                    // accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;

                    speed = pVehicle.Velocity + 1;
                    if (speed > vmax) speed = vmax;
                    // lane changing
                    if (sn > pLink.Channellen && dn2back[reveh] > dSafe && dn < speed && dn2other[reveh] > dn)
                    {
                        pVehicle.bLaneChange = true;
                        // decelerate                        
                        if (pVehicle.NextVelocity > dn2other[reveh]) pVehicle.NextVelocity = dn2other[reveh];
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;
                        //decelerate                       
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                        // consider signal control
                        if (bRedPhase && pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                    }
                    // random slow down
                    if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }
                else if (pVehicle.Movement == LEFT)// left turning
                {
                    sn -= pLink.Channellen;
                    // consider lane changing
                    if (dn2back[reveh] > dSafe && dn2other[reveh] >= 0)
                    {
                        pVehicle.bLaneChange = true;
                        // accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        // decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn2other[reveh]) pVehicle.NextVelocity = dn2other[reveh];
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;
                        //accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        //decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;                       
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                    }
                    // random slow down
                    if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }
                else //right turning 
                {
                    // do not lane changing
                    pVehicle.bLaneChange = false;
                    //accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                    if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                    if (sn != 0)
                    {
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                        // random slow down
                        if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                        //update position
                        if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                        pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                    }
                    else
                    {
                        // can it be turning?                        
                        // move to north - south link
                        pRightTurningLink = (CLink)m_NorthSouthLink[ pVehicle.ColIndex];
                        rigthPosi = NSLinkLenIndex[pVehicle.ColIndex, link+1];
                        bool brigthTurning = true;
                        for (rightveh = 0; rightveh < pRightTurningLink.m_OuterVehicle.Count; rightveh++)
                        {
                            potherVehicle = (CVehicle)pRightTurningLink.m_OuterVehicle[rightveh];
                            // the condition of cannot turning
                            if (potherVehicle.Position <= rigthPosi && potherVehicle.Position + potherVehicle.Velocity + 1 >= rigthPosi)
                            {
                                brigthTurning = false;
                                break;
                            }
                            if (potherVehicle.Position > rigthPosi) break;
                        }
                        if (brigthTurning)
                        {
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = rigthPosi;
                            pVehicle.bIntoIntersection = true;
                        }
                        else
                        {
                            pVehicle.NextVelocity = 0;
                            pVehicle.NextPosition = pVehicle.Position;
                            pVehicle.bIntoIntersection = false;
                        }
                    }
                }
                //check destination
                if (reveh == pLink.m_OuterVehicle.Count - 1)
                {
                    if (pVehicle.Movement == AHEAD)
                    {
                        if (pVehicle.NextPosition >= WELinkLenIndex[link, SNSize] + EWLinkLength[link, SNSize])
                        {
                            pLink.m_OuterVehicle.RemoveAt(reveh);
                        }
                    }
                }
            }
            // the end
        }
    }
    // south - north movement
    public void SouthNorthVehicleNextMovement()
    {        
        int veh, reveh, link, rightveh;
        CVehicle pVehicle, pNextVehicle, potherVehicle;

        CLink pLink;
        int dn, sn, rigthPosi;
        bool bRedPhase;
        int speed;
        CLink pRightTurningLink;        
        //*******************sort vehicle*************************************
        CVehiclePositionCompare pCompare = new CVehiclePositionCompare();
        // South North
        for (link = 0; link < m_SouthNorthLink.Count; link++)
        {
            pLink = (CLink)m_SouthNorthLink[link];
            pLink.m_InnerVehicle.Sort(pCompare);
            pLink.m_OuterVehicle.Sort(pCompare);

            int[] dn1back = new int[pLink.m_InnerVehicle.Count];
            int[] dn2back = new int[pLink.m_OuterVehicle.Count];

            int[] dn1other = new int[pLink.m_InnerVehicle.Count];
            int[] dn2other = new int[pLink.m_OuterVehicle.Count];

            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                dn1back[veh] = 100;
                dn1other[veh] = 100;
            }
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                dn2back[reveh] = 100;
                dn2other[reveh] = 100;
            }
            veh = 0;
            reveh = 0;
            while (veh < pLink.m_InnerVehicle.Count && reveh < pLink.m_OuterVehicle.Count)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                potherVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.Position >= potherVehicle.Position)
                {
                    dn1back[veh] = pVehicle.Position - potherVehicle.Position - 1;
                    dn2other[reveh] = dn1back[veh];
                    reveh++;
                }
                else
                {
                    dn2back[reveh] = potherVehicle.Position - pVehicle.Position - 1;
                    dn1other[veh] = dn2back[reveh];
                    veh++;
                }
            }

            // vehicle of inner lane
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                //check whether the signal phase is red
                bRedPhase = false;
                if (pVehicle.RowIndex < EWSize)//***//
                {
                    if (SignalPhase[EWSize - pVehicle.RowIndex - 1, link] != 1) // red phase //***//
                        bRedPhase = true;
                }
                // the distance to stopline
                if (pVehicle.RowIndex < EWSize)
                {
                    sn = SNLinkLenIndex[link, pVehicle.RowIndex + 1] - 5 - pVehicle.Position;//过停车线col++//***//
                    if (sn < 0)
                    {
                        pVehicle.RowIndex++;
                        if (pVehicle.RowIndex < EWSize)
                            sn = SNLinkLenIndex[link, pVehicle.RowIndex + 1] - 5 - pVehicle.Position;
                        else
                            sn = 100;
                    }
                }
                else sn = 100;
                // distance to ahead vehicle
                if (veh < pLink.m_InnerVehicle.Count - 1)
                {
                    pNextVehicle = (CVehicle)pLink.m_InnerVehicle[veh + 1];
                    dn = pNextVehicle.Position - pVehicle.Position - 1;
                }
                else dn = 100;
                //分车辆类型考虑
                if (pVehicle.Movement == AHEAD)// ahead vehicle
                {
                    // accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;

                    speed = pVehicle.Velocity + 1;
                    if (speed > vmax) speed = vmax;
                    // lane changing
                    if (sn > pLink.Channellen && dn1back[veh] > dSafe && dn < speed && dn1other[veh] > dn)
                    {
                        pVehicle.bLaneChange = true;
                        // decelerate                        
                        if (pVehicle.NextVelocity > dn1other[veh]) pVehicle.NextVelocity = dn1other[veh];
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;
                        //decelerate                       
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                        // consider signal control
                        if (bRedPhase && pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                    }
                    // random slow down
                    if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }
                else if (pVehicle.Movement == LEFT)// left turning
                {
                    // do not lane changing
                    pVehicle.bLaneChange = false;
                    //accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                    if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                    if (sn != 0)
                    {
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                        // random slow down
                        if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                        //update position
                        if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                        pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                    }
                    else
                    {
                        if (bRedPhase)
                        {
                            pVehicle.NextVelocity = 0;
                            pVehicle.NextPosition = pVehicle.Position;
                        }
                        else// move into intersection
                        {
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = 13;
                            pVehicle.bIntoIntersection = true;
                        }
                    }
                }
                else //right turning 
                {
                    sn -= pLink.Channellen;
                    // consider lane changing
                    if (dn1back[veh] > dSafe && dn1other[veh] >= 0)
                    {
                        pVehicle.bLaneChange = true;
                        // accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        // decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn1other[veh]) pVehicle.NextVelocity = dn1other[veh];
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;
                        //accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        //decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                        // consider signal control
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                    }
                    //consider the special case
                    if (sn == 0)
                    {
                        for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
                        {
                            potherVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                            if (potherVehicle.Position == pVehicle.Position && potherVehicle.Movement == LEFT)
                            {
                                if (reveh + 1 < pLink.m_OuterVehicle.Count)
                                {
                                    pNextVehicle = (CVehicle)pLink.m_OuterVehicle[reveh + 1];
                                    dn = pNextVehicle.Position - potherVehicle.Position;
                                }
                                else dn = 100;
                                pVehicle.bLaneChange = true;
                                pVehicle.NextVelocity = pVehicle.Velocity + 1;
                                //decelerate
                                if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                                if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                            }
                        }
                    }
                    // random slow down
                    if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }
                //check destination
                if (veh == pLink.m_InnerVehicle.Count - 1)
                {
                    if (pVehicle.Movement == AHEAD)
                    {
                        if (pVehicle.NextPosition >= SNLinkLenIndex[link, EWSize] + SNLinkLength[link, 0])
                        {
                            pLink.m_InnerVehicle.RemoveAt(veh);
                        }
                    }
                }
            }
            //*****************************************************************
            // vehicles of outer lane
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                //check whether the signal phase is red
                bRedPhase = false;
                if (pVehicle.RowIndex < EWSize)
                {
                    if (SignalPhase[EWSize - pVehicle.RowIndex - 1, link] != 1) // red phase
                        bRedPhase = true;
                }
                // the distance to stopline               
                if (pVehicle.RowIndex < EWSize)
                {
                    sn = SNLinkLenIndex[link, pVehicle.RowIndex + 1] - 5 - pVehicle.Position;//过停车线col++
                    if (sn < 0)
                    {
                        pVehicle.RowIndex++;
                        if (pVehicle.RowIndex < EWSize)
                            sn = SNLinkLenIndex[link, pVehicle.RowIndex + 1] - 5 - pVehicle.Position;
                        else
                            sn = 100;
                    }
                }
                else sn = 100;
                // distance to ahead vehicle
                if (reveh < pLink.m_OuterVehicle.Count - 1)
                {
                    pNextVehicle = (CVehicle)pLink.m_OuterVehicle[reveh + 1];
                    dn = pNextVehicle.Position - pVehicle.Position - 1;
                }
                else dn = 100;
                //分车辆类型考虑
                if (pVehicle.Movement == AHEAD)// ahead vehicle
                {
                    // accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;

                    speed = pVehicle.Velocity + 1;
                    if (speed > vmax) speed = vmax;
                    // lane changing
                    if (sn > pLink.Channellen && dn2back[reveh] > dSafe && dn < speed && dn2other[reveh] > dn)
                    {
                        pVehicle.bLaneChange = true;
                        // decelerate                        
                        if (pVehicle.NextVelocity > dn2other[reveh]) pVehicle.NextVelocity = dn2other[reveh];
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;
                        //decelerate                       
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                        // consider signal control
                        if (bRedPhase && pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                    }
                    // random slow down
                    if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }
                else if (pVehicle.Movement == LEFT)// left turning
                {
                    sn -= pLink.Channellen;
                    // consider lane changing
                    if (dn2back[reveh] > dSafe && dn2other[reveh] >= 0)
                    {
                        pVehicle.bLaneChange = true;
                        // accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        // decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn2other[reveh]) pVehicle.NextVelocity = dn2other[reveh];
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;
                        //accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        //decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                        // consider signal control
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                    }
                    // random slow down
                    if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }
                else //right turning 
                {
                    // do not lane changing
                    pVehicle.bLaneChange = false;
                    //accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                    if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                    if (sn != 0)
                    {
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                        // random slow down
                        if (pVehicle.NextVelocity>0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                        //update position
                        if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                        pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                    }
                    else
                    {
                        // can it be turning?                        
                        // move to west - east link
                        pRightTurningLink = (CLink)m_WestEastLink[EWSize - pVehicle.RowIndex - 1];
                        rigthPosi = WELinkLenIndex[EWSize - pVehicle.RowIndex - 1, link+1 ];
                        bool brigthTurning = true;
                        for (rightveh = 0; rightveh < pRightTurningLink.m_OuterVehicle.Count; rightveh++)
                        {
                            potherVehicle = (CVehicle)pRightTurningLink.m_OuterVehicle[rightveh];
                            // the condition of cannot turning
                            if (potherVehicle.Position <= rigthPosi && potherVehicle.Position + potherVehicle.Velocity + 1 >= rigthPosi)
                            {
                                brigthTurning = false;
                                break;
                            }
                            if (potherVehicle.Position > rigthPosi) break;
                        }
                        if (brigthTurning)
                        {
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = rigthPosi;
                            pVehicle.bIntoIntersection = true;
                        }
                        else
                        {
                            pVehicle.NextVelocity = 0;
                            pVehicle.NextPosition = pVehicle.Position;
                            pVehicle.bIntoIntersection = false;
                        }
                    }
                }
                //check destination
                if (reveh == pLink.m_OuterVehicle.Count - 1)
                {
                    if (pVehicle.Movement == AHEAD)
                    {
                        if (pVehicle.NextPosition >= SNLinkLenIndex[link, EWSize] + SNLinkLength[link, 0])
                        {
                            pLink.m_OuterVehicle.RemoveAt(reveh);
                        }
                    }
                }
            }
            // the end
        }
    }
    // north - south movement
    public void NorthSouthVehicleNextMovement()
    {       
        int veh, reveh, link, rightveh;
        CVehicle pVehicle, pNextVehicle, potherVehicle;

        CLink pLink;
        int dn, sn, rigthPosi;
        bool bRedPhase;
        int speed;
        CLink pRightTurningLink;       
        //*******************sort vehicle*************************************
        CVehiclePositionCompare pCompare = new CVehiclePositionCompare();
        // South North
        for (link = 0; link < m_NorthSouthLink.Count; link++)
        {
            pLink = (CLink)m_NorthSouthLink[link];
            pLink.m_InnerVehicle.Sort(pCompare);
            pLink.m_OuterVehicle.Sort(pCompare);

            int[] dn1back = new int[pLink.m_InnerVehicle.Count];
            int[] dn2back = new int[pLink.m_OuterVehicle.Count];

            int[] dn1other = new int[pLink.m_InnerVehicle.Count];
            int[] dn2other = new int[pLink.m_OuterVehicle.Count];

            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                dn1back[veh] = 100;
                dn1other[veh] = 100;
            }
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                dn2back[reveh] = 100;
                dn2other[reveh] = 100;
            }
            veh = 0;
            reveh = 0;
            while (veh < pLink.m_InnerVehicle.Count && reveh < pLink.m_OuterVehicle.Count)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                potherVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.Position >= potherVehicle.Position)
                {
                    dn1back[veh] = pVehicle.Position - potherVehicle.Position - 1;
                    dn2other[reveh] = dn1back[veh];
                    reveh++;
                }
                else
                {
                    dn2back[reveh] = potherVehicle.Position - pVehicle.Position - 1;
                    dn1other[veh] = dn2back[reveh];
                    veh++;
                }
            }

            // vehicle of inner lane
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                //check whether the signal phase is red
                bRedPhase = false;
                if (pVehicle.RowIndex < EWSize)//***//
                {
                    if (SignalPhase[pVehicle.RowIndex, link] != 3) // red phase //***//
                        bRedPhase = true;
                }
                // the distance to stopline               
                if (pVehicle.RowIndex < EWSize)
                {
                    sn = NSLinkLenIndex[link, pVehicle.RowIndex + 1] - 5 - pVehicle.Position;//过停车线col++//***//
                    if (sn < 0)
                    {
                        pVehicle.RowIndex++;
                        if (pVehicle.RowIndex < EWSize)
                            sn = NSLinkLenIndex[link, pVehicle.RowIndex + 1] - 5 - pVehicle.Position;
                        else
                            sn = 100;
                    }
                }
                else sn = 100; 

                // distance to ahead vehicle
                if (veh < pLink.m_InnerVehicle.Count - 1)
                {
                    pNextVehicle = (CVehicle)pLink.m_InnerVehicle[veh + 1];
                    dn = pNextVehicle.Position - pVehicle.Position - 1;
                }
                else dn = 100;
                //分车辆类型考虑
                if (pVehicle.Movement == AHEAD)// ahead vehicle
                {
                    // accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;

                    speed = pVehicle.Velocity + 1;
                    if (speed > vmax) speed = vmax;
                    // lane changing
                    if (sn > pLink.Channellen && dn1back[veh] > dSafe && dn < speed && dn1other[veh] > dn)
                    {
                        pVehicle.bLaneChange = true;
                        // decelerate                        
                        if (pVehicle.NextVelocity > dn1other[veh]) pVehicle.NextVelocity = dn1other[veh];
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;
                        //decelerate                       
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                        // consider signal control
                        if (bRedPhase && pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                    }
                    // random slow down
                    if (pVehicle.NextVelocity > 0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }
                else if (pVehicle.Movement == LEFT)// left turning
                {
                    // do not lane changing
                    pVehicle.bLaneChange = false;
                    //accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                    if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                    if (sn != 0)
                    {
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                        // random slow down
                        if (pVehicle.NextVelocity > 0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                        //update position
                        if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                        pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                    }
                    else
                    {
                        if (bRedPhase)
                        {
                            pVehicle.NextVelocity = 0;
                            pVehicle.NextPosition = pVehicle.Position;
                        }
                        else// move into intersection
                        {
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = 2;
                            pVehicle.bIntoIntersection = true;
                        }
                    }
                }
                else //right turning 
                {
                    sn -= pLink.Channellen;
                    // consider lane changing
                    if (dn1back[veh] > dSafe && dn1other[veh] >= 0)
                    {
                        pVehicle.bLaneChange = true;
                        // accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        // decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn1other[veh]) pVehicle.NextVelocity = dn1other[veh];
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;
                        //accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        //decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                        // consider signal control
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                    }
                    //consider the special case
                    if (sn == 0)
                    {
                        for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
                        {
                            potherVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                            if (potherVehicle.Position == pVehicle.Position && potherVehicle.Movement == LEFT)
                            {
                                if (reveh + 1 < pLink.m_OuterVehicle.Count)
                                {
                                    pNextVehicle = (CVehicle)pLink.m_OuterVehicle[reveh + 1];
                                    dn = pNextVehicle.Position - potherVehicle.Position;
                                }
                                else dn = 100;
                                pVehicle.bLaneChange = true;
                                pVehicle.NextVelocity = pVehicle.Velocity + 1;
                                //decelerate
                                if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                                if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                            }
                        }
                    }
                    // random slow down
                    if (pVehicle.NextVelocity > 0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }

                //check destination
                if (veh == pLink.m_InnerVehicle.Count - 1)
                {
                    if (pVehicle.Movement == AHEAD)
                    {
                        if (pVehicle.NextPosition >= NSLinkLenIndex[link, EWSize] + SNLinkLength[link, EWSize])
                        {
                            pLink.m_InnerVehicle.RemoveAt(veh);
                        }
                    }
                }
            }
            //*****************************************************************
            // vehicles of outer lane
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                //check whether the signal phase is red
                bRedPhase = false;
                if (pVehicle.RowIndex < EWSize)
                {
                    if (SignalPhase[pVehicle.RowIndex, link] != 3) // red phase
                        bRedPhase = true;
                }
                // the distance to stopline               
                if (pVehicle.RowIndex < EWSize)
                {
                    sn = NSLinkLenIndex[link, pVehicle.RowIndex + 1] - 5 - pVehicle.Position;//过停车线col++
                    if (sn < 0)
                    {
                        pVehicle.RowIndex++;
                        if (pVehicle.RowIndex < EWSize)
                            sn = NSLinkLenIndex[link, pVehicle.RowIndex + 1] - 5 - pVehicle.Position;
                        else
                            sn = 100;
                    }
                } 
                else sn = 100;
                // distance to ahead vehicle
                if (reveh < pLink.m_OuterVehicle.Count - 1)
                {
                    pNextVehicle = (CVehicle)pLink.m_OuterVehicle[reveh + 1];
                    dn = pNextVehicle.Position - pVehicle.Position - 1;
                }
                else dn = 100;
                //分车辆类型考虑
                if (pVehicle.Movement == AHEAD)// ahead vehicle
                {
                    // accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;

                    speed = pVehicle.Velocity + 1;
                    if (speed > vmax) speed = vmax;
                    // lane changing
                    if (sn > pLink.Channellen && dn2back[reveh] > dSafe && dn < speed && dn2other[reveh] > dn)
                    {
                        pVehicle.bLaneChange = true;
                        // decelerate                        
                        if (pVehicle.NextVelocity > dn2other[reveh]) pVehicle.NextVelocity = dn2other[reveh];
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;
                        //decelerate                       
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                        // consider signal control
                        if (bRedPhase && pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                    }
                    // random slow down
                    if (pVehicle.NextVelocity > 0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }
                else if (pVehicle.Movement == LEFT)// left turning
                {
                    sn -= pLink.Channellen;
                    // consider lane changing
                    if (dn2back[reveh] > dSafe && dn2other[reveh] >= 0)
                    {
                        pVehicle.bLaneChange = true;
                        // accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        // decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn2other[reveh]) pVehicle.NextVelocity = dn2other[reveh];
                    }
                    else
                    {
                        pVehicle.bLaneChange = false;
                        //accelerate
                        pVehicle.NextVelocity = pVehicle.Velocity + 1;
                        //decelerate
                        if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                        if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                        // consider signal control
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                    }
                    // random slow down
                    if (pVehicle.NextVelocity > 0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                    //update position
                    if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                    pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                }
                else //right turning 
                {
                    // do not lane changing
                    pVehicle.bLaneChange = false;
                    //accelerate
                    pVehicle.NextVelocity = pVehicle.Velocity + 1;
                    //decelerate
                    if (pVehicle.NextVelocity > vmax) pVehicle.NextVelocity = vmax;
                    if (pVehicle.NextVelocity > dn) pVehicle.NextVelocity = dn;
                    if (sn != 0)
                    {
                        if (pVehicle.NextVelocity > sn) pVehicle.NextVelocity = sn;
                        // random slow down
                        if (pVehicle.NextVelocity > 0 && Rand.NextDouble() < SlowRate) pVehicle.NextVelocity--;
                        //update position
                        if (pVehicle.NextVelocity < 0) pVehicle.NextVelocity = 0;
                        pVehicle.NextPosition = pVehicle.Position + pVehicle.NextVelocity;
                    }
                    else
                    {
                        // can it be turning?                        
                        // move to east - west link
                        pRightTurningLink = (CLink)m_EastWestLink[pVehicle.RowIndex];
                        rigthPosi = EWLinkLenIndex[pVehicle.RowIndex, SNSize - link];
                        bool brigthTurning = true;
                        for (rightveh = 0; rightveh < pRightTurningLink.m_OuterVehicle.Count; rightveh++)
                        {
                            potherVehicle = (CVehicle)pRightTurningLink.m_OuterVehicle[rightveh];
                            // the condition of cannot turning
                            if (potherVehicle.Position <= rigthPosi && potherVehicle.Position + potherVehicle.Velocity + 1 >= rigthPosi)
                            {
                                brigthTurning = false;
                                break;
                            }
                            if (potherVehicle.Position > rigthPosi) break;
                        }
                        if (brigthTurning)
                        {
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = rigthPosi;
                            pVehicle.bIntoIntersection = true;
                        }
                        else
                        {
                            pVehicle.NextVelocity = 0;
                            pVehicle.NextPosition = pVehicle.Position;
                            pVehicle.bIntoIntersection = false;
                        }
                    }
                }
                //check destination
                if (reveh == pLink.m_OuterVehicle.Count - 1)
                {
                    if (pVehicle.Movement == AHEAD)
                    {
                        if (pVehicle.NextPosition >= NSLinkLenIndex[link, EWSize] + SNLinkLength[link, EWSize])
                        {
                            pLink.m_OuterVehicle.RemoveAt(reveh);
                        }
                    }
                }
            }
            // the end
        }
    }
    public void IntersectionVehicleMovement()
    {
        int veh, row, col;
        CVehicle pVehicle;
        CIntersection pIntersection;
        for (row = 0; row < EWSize; row ++ )
        {
            for (col = 0; col < SNSize; col++ )
            {
                pIntersection = (CIntersection)m_Intersection[row * SNSize + col];
                for (veh = 0; veh < pIntersection.m_Vehicle.Count; veh++ )
                {
                    pVehicle =(CVehicle)pIntersection.m_Vehicle[veh];
                    switch (pVehicle.Position)
                    {
                        case 2:
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = 7;
                            break;

                        case 4:
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = 1;
                            break;

                        case 11:
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = 14;
                            break;
                        case 13:
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = 8;
                            break;

                        case 14:// North - south                           
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = NSLinkLenIndex[col,row+1];
                            pVehicle.bIntoIntersection = false;
                            break;

                        case 1:// South - North                            
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = SNLinkLenIndex[col, EWSize -row];
                            pVehicle.bIntoIntersection = false;
                            break;

                        case 8:// East - West                            
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = EWLinkLenIndex[row, SNSize - col];
                            pVehicle.bIntoIntersection = false;
                            break;

                        case 7:// East - West                            
                            pVehicle.NextVelocity = 1;
                            pVehicle.NextPosition = EWLinkLenIndex[row, col+1];
                            pVehicle.bIntoIntersection = false;
                            break;
                    }
                }
            }
        }
    }
    public void RandVehicleGeneration()
    {
        int link;
        CLink pLink;
        CVehicle pVehicle;
        int firtposi;
        double r;
        double pcv = 0.12;
        // East - West
        for (link = 0; link < m_EastWestLink.Count;link++ )
        {
            pLink = (CLink)m_EastWestLink[link];
            r = Rand.NextDouble();
            if (r < pcv)
            {
                pVehicle = new CVehicle();
                pVehicle.Position = -1;
                pVehicle.ColIndex = 0;
                pVehicle.Velocity = 3;
                pVehicle.RowIndex = -1;
                pVehicle.Movement = RandSetVehicleMovement();
                pLink.m_Invehicle.Add(pVehicle);
            }
            r = Rand.NextDouble();
            if (r < pcv)
            {
                pVehicle = new CVehicle();
                pVehicle.Position = -1;
                pVehicle.ColIndex = 0;
                pVehicle.Velocity = 3;
                pVehicle.RowIndex = -1;
                pVehicle.Movement = RandSetVehicleMovement();
                pLink.m_Invehicle.Add(pVehicle);
            }

            if (Rand.NextDouble() < 0.5)
            {

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);
                }
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                }
            }
            else
            {
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                }

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);
                }                
            }
        }

        //  West - East
        for (link = 0; link < m_WestEastLink.Count; link++)
        {
            pLink = (CLink)m_WestEastLink[link];
            r = Rand.NextDouble();
            if (r < pcv)
            {
                pVehicle = new CVehicle();
                pVehicle.Position = -1;
                pVehicle.ColIndex = 0;
                pVehicle.Velocity = 3;
                pVehicle.RowIndex = -1;
                pVehicle.Movement = RandSetVehicleMovement();
                pLink.m_Invehicle.Add(pVehicle);
            }
            r = Rand.NextDouble();
            if (r < pcv)
            {
                pVehicle = new CVehicle();
                pVehicle.Position = -1;
                pVehicle.ColIndex = 0;
                pVehicle.Velocity = 3;
                pVehicle.RowIndex = -1;
                pVehicle.Movement = RandSetVehicleMovement();
                pLink.m_Invehicle.Add(pVehicle);
            }

            if (Rand.NextDouble() < 0.5)
            {

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);
                }
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                }
            }
            else
            {
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                }

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);
                }
            }
        }

        //  South - North
        for (link = 0; link < m_SouthNorthLink.Count; link++)
        {
            pLink = (CLink)m_SouthNorthLink[link];
            r = Rand.NextDouble();
            if (r < pcv)
            {
                pVehicle = new CVehicle();
                pVehicle.Position = -1;
                pVehicle.ColIndex = -1;
                pVehicle.Velocity = 3;
                pVehicle.RowIndex = 0;
                pVehicle.Movement = RandSetVehicleMovement();
                pLink.m_Invehicle.Add(pVehicle);
            }
            r = Rand.NextDouble();
            if (r < pcv)
            {
                pVehicle = new CVehicle();
                pVehicle.Position = -1;
                pVehicle.ColIndex = -1;
                pVehicle.Velocity = 3;
                pVehicle.RowIndex = 0;
                pVehicle.Movement = RandSetVehicleMovement();
                pLink.m_Invehicle.Add(pVehicle);
            }

            if (Rand.NextDouble() < 0.5)
            {

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);
                }
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                }
            }
            else
            {
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                }

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);
                }
            }
        }

        //   North - South
        for (link = 0; link < m_NorthSouthLink.Count; link++)
        {
            pLink = (CLink)m_NorthSouthLink[link];
            r = Rand.NextDouble();
            if (r < pcv)
            {
                pVehicle = new CVehicle();
                pVehicle.Position = -1;
                pVehicle.ColIndex = -1;
                pVehicle.Velocity = 3;
                pVehicle.RowIndex = 0;
                pVehicle.Movement = RandSetVehicleMovement();
                pLink.m_Invehicle.Add(pVehicle);
            }
            r = Rand.NextDouble();
            if (r < pcv)
            {
                pVehicle = new CVehicle();
                pVehicle.Position = -1;
                pVehicle.ColIndex = -1;
                pVehicle.Velocity = 3;
                pVehicle.RowIndex = 0;
                pVehicle.Movement = RandSetVehicleMovement();
                pLink.m_Invehicle.Add(pVehicle);
            }

            if (Rand.NextDouble() < 0.5)
            {

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);
                }
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                }
            }
            else
            {
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                }

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);
                }
            }
        }
    }
    public void VehicleGeneration(int interval)
    {
        int link;
        CLink pLink;
        CVehicle pVehicle;
        int firtposi, veh;
        // East - West
        for (link = 0; link < m_EastWestLink.Count; link++)
        {
            pLink = (CLink)m_EastWestLink[link];
            for (veh = 0; veh < EWDemand[link, interval]; veh++)
            {
                pVehicle = new CVehicle();
                pVehicle.Position = -1;
                pVehicle.ColIndex = 0;
                pVehicle.Velocity = 3;
                pVehicle.RowIndex = -1;
                pVehicle.Movement = RandSetVehicleMovement();
                pLink.m_Invehicle.Add(pVehicle);
            }
            if (Rand.NextDouble() < 0.5)
            {

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);                    
                }
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                    
                }
            }
            else
            {
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                    
                }

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);
                    
                }
            }
        }

        //  West - East
        for (link = 0; link < m_WestEastLink.Count; link++)
        {
            pLink = (CLink)m_WestEastLink[link];
            for (veh = 0; veh < WEDemand[link, interval]; veh++)
            {
                pVehicle = new CVehicle();
                pVehicle.Position = -1;
                pVehicle.ColIndex = 0;
                pVehicle.Velocity = 3;
                pVehicle.RowIndex = 0;
                pVehicle.Movement = RandSetVehicleMovement();
                pLink.m_Invehicle.Add(pVehicle);
            }

            if (Rand.NextDouble() < 0.5)
            {

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);
                    
                }
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                    
                }
            }
            else
            {
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                    
                }

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);
                    
                }
            }
        }

        //  South - North
        for (link = 0; link < m_SouthNorthLink.Count; link++)
        {
            pLink = (CLink)m_SouthNorthLink[link];
            for (veh = 0; veh < SNDemand[link, interval]; veh++)
            {
                pVehicle = new CVehicle();
                pVehicle.Position = -1;
                pVehicle.ColIndex = 0;
                pVehicle.Velocity = 3;
                pVehicle.RowIndex = 0;
                pVehicle.Movement = RandSetVehicleMovement();
                pLink.m_Invehicle.Add(pVehicle);
            }
            if (Rand.NextDouble() < 0.5)
            {

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);
                    
                }
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                    
                }
            }
            else
            {
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                    
                }

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);
                    
                }
            }
        }

        //   North - South
        for (link = 0; link < m_NorthSouthLink.Count; link++)
        {
            pLink = (CLink)m_NorthSouthLink[link];
            for (veh = 0; veh < NSDemand[link, interval]; veh++)
            {
                pVehicle = new CVehicle();
                pVehicle.Position = -1;
                pVehicle.ColIndex = 0;
                pVehicle.Velocity = 3;
                pVehicle.RowIndex = 0;
                pVehicle.Movement = RandSetVehicleMovement();
                pLink.m_Invehicle.Add(pVehicle);
            }
            if (Rand.NextDouble() < 0.5)
            {

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);
                    
                }
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                    
                }
            }
            else
            {
                //load vehicle to outer lane
                if (pLink.m_OuterVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_OuterVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_OuterVehicle.Add(pVehicle);
                    
                }

                // load vehicle to inner lane
                if (pLink.m_InnerVehicle.Count > 0)
                {
                    pVehicle = (CVehicle)pLink.m_InnerVehicle[0];
                    firtposi = pVehicle.Position;
                }
                else firtposi = 100;

                if (pLink.m_Invehicle.Count > 0 && firtposi > 0)
                {
                    pVehicle = (CVehicle)pLink.m_Invehicle[0];
                    pLink.m_Invehicle.RemoveAt(0);
                    pVehicle.Position = 0;
                    pLink.m_InnerVehicle.Add(pVehicle);
                   
                }
            }
        }
    }   
    public void UpdateVehicles()
    {
        //vehicle keep moving
        int veh, link, reveh, row,col;
        CVehicle pVehicle;
        CLink pLink, pRightTurningLink;
        CIntersection pIntersection;
        // vehicle in intersection
        for (row = 0; row < EWSize; row++ )
        {
            for (col = 0; col < SNSize; col++ )
            {
                pIntersection = (CIntersection)m_Intersection[row * SNSize + col];
                for (veh = 0; veh < pIntersection.m_Vehicle.Count; veh++ )
                {
                    pVehicle = (CVehicle)pIntersection.m_Vehicle[veh];
                    if (pVehicle.bIntoIntersection)
                    {
                        pVehicle.Position = pVehicle.NextPosition;
                        pVehicle.Velocity = pVehicle.NextVelocity;
                    }
                }
            }
        }
        // East - West
        for (link = 0; link < m_EastWestLink.Count; link++)
        {
            pLink = (CLink)m_EastWestLink[link];
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++ )
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                if (!pVehicle.bLaneChange && !pVehicle.bIntoIntersection)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                }
            }
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (!pVehicle.bLaneChange && !pVehicle.bIntoIntersection)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                }
            }
            // lane changing vehicles
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];                
                if (pVehicle.bLaneChange)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                    pVehicle.bLaneChange = false;
                    pLink.m_InnerVehicle.RemoveAt(veh);
                    veh--;
                    pLink.m_OuterVehicle.Add(pVehicle);
                }
                else if (pVehicle.bIntoIntersection)
                {
                    // 
                    pIntersection = (CIntersection)m_Intersection[link*SNSize+SNSize-pVehicle.ColIndex-1];
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                    pVehicle.bLaneChange = false;
                    pLink.m_InnerVehicle.RemoveAt(veh);
                    
                    pIntersection.m_Vehicle.Add(pVehicle);
                    veh--;
                }                
            }
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.bLaneChange)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                    pVehicle.bLaneChange = false;
                    pLink.m_OuterVehicle.RemoveAt(reveh);
                    reveh--;
                    pLink.m_InnerVehicle.Add(pVehicle);
                }
            }
        }

        // West - East
        for (link = 0; link < m_WestEastLink.Count; link++)
        {
            pLink = (CLink)m_WestEastLink[link];
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                if (!pVehicle.bLaneChange && !pVehicle.bIntoIntersection)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                }
            }
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (!pVehicle.bLaneChange && !pVehicle.bIntoIntersection)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                }
            }
            // lane changing vehicles
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                if (pVehicle.bLaneChange)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                    pVehicle.bLaneChange = false;
                    pLink.m_InnerVehicle.RemoveAt(veh);
                    veh--;
                    pLink.m_OuterVehicle.Add(pVehicle);
                }
                else if (pVehicle.bIntoIntersection)
                {
                    // 
                    pIntersection = (CIntersection)m_Intersection[link * SNSize + pVehicle.ColIndex];
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;                  
                    pLink.m_InnerVehicle.RemoveAt(veh);
                    pIntersection.m_Vehicle.Add(pVehicle);
                    veh--;
                } 

            }
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.bLaneChange)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                    pVehicle.bLaneChange = false;
                    pLink.m_OuterVehicle.RemoveAt(reveh);
                    reveh--;
                    pLink.m_InnerVehicle.Add(pVehicle);
                }
            }
        }
        // South - North
        for (link = 0; link < m_SouthNorthLink.Count; link++)
        {
            pLink = (CLink)m_SouthNorthLink[link];
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                if (!pVehicle.bLaneChange && !pVehicle.bIntoIntersection)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                }
            }
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (!pVehicle.bLaneChange && !pVehicle.bIntoIntersection)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                }
            }
            // lane changing vehicles
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                if (pVehicle.bLaneChange)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                    pVehicle.bLaneChange = false;
                    pLink.m_InnerVehicle.RemoveAt(veh);
                    veh--;
                    pLink.m_OuterVehicle.Add(pVehicle);
                }
                else if (pVehicle.bIntoIntersection)
                {
                    // 
                    pIntersection = (CIntersection)m_Intersection[(EWSize - pVehicle.RowIndex-1) * SNSize + link];
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                    pLink.m_InnerVehicle.RemoveAt(veh);
                    pIntersection.m_Vehicle.Add(pVehicle);
                    veh--;
                } 

            }
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.bLaneChange)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                    pVehicle.bLaneChange = false;
                    pLink.m_OuterVehicle.RemoveAt(reveh);
                    reveh--;
                    pLink.m_InnerVehicle.Add(pVehicle);
                }
            }
        }
        // North - South
        for (link = 0; link < m_NorthSouthLink.Count; link++)
        {
            pLink = (CLink)m_NorthSouthLink[link];
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                if (!pVehicle.bLaneChange && !pVehicle.bIntoIntersection)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                }
            }
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (!pVehicle.bLaneChange && !pVehicle.bIntoIntersection)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                }
            }
            // lane changing vehicles
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                if (pVehicle.bLaneChange)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                    pVehicle.bLaneChange = false;
                    pLink.m_InnerVehicle.RemoveAt(veh);
                    veh--;
                    pLink.m_OuterVehicle.Add(pVehicle);
                }
                else if (pVehicle.bIntoIntersection)
                {
                    // 
                    pIntersection = (CIntersection)m_Intersection[ pVehicle.RowIndex * SNSize + link];
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                    pLink.m_InnerVehicle.RemoveAt(veh);
                    pIntersection.m_Vehicle.Add(pVehicle);
                    veh--;
                } 

            }
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.bLaneChange)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                    pVehicle.bLaneChange = false;
                    pLink.m_OuterVehicle.RemoveAt(reveh);
                    reveh--;
                    pLink.m_InnerVehicle.Add(pVehicle);
                }
            }
        }
        // right turning vehicles
        // East - West
        for (link = 0; link < m_EastWestLink.Count; link++)
        {
            pLink = (CLink)m_EastWestLink[link];            
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.bIntoIntersection)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                    pVehicle.bIntoIntersection = false;
                    pLink.m_OuterVehicle.RemoveAt(reveh);
                    reveh--;
                    pRightTurningLink = (CLink)m_SouthNorthLink[SNSize - pVehicle.ColIndex - 1];
                    pRightTurningLink.m_OuterVehicle.Add(pVehicle);
                    pVehicle.ColIndex = -1;
                    pVehicle.RowIndex = EWSize - link;
                    if (pVehicle.RowIndex == EWSize) pVehicle.Movement = AHEAD;
                    else pVehicle.Movement = RandSetVehicleMovement();
                }
            }
        }
        //////////////////////////////////////////////////////////////////////////
        // West - East
        for (link = 0; link < m_WestEastLink.Count; link++)
        {
            pLink = (CLink)m_WestEastLink[link];            
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.bIntoIntersection)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                    pVehicle.bIntoIntersection = false;
                    pLink.m_OuterVehicle.RemoveAt(reveh);
                    reveh--;
                    pRightTurningLink = (CLink)m_NorthSouthLink[pVehicle.ColIndex];
                    pRightTurningLink.m_OuterVehicle.Add(pVehicle);
                    pVehicle.ColIndex = -1;
                    pVehicle.RowIndex = link+1;
                    if (pVehicle.RowIndex == EWSize) pVehicle.Movement = AHEAD;
                    else pVehicle.Movement = RandSetVehicleMovement();
                }
            }
        }
        // South - North
        for (link = 0; link < m_SouthNorthLink.Count; link++)
        {
            pLink = (CLink)m_SouthNorthLink[link];
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.bIntoIntersection)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                    pVehicle.bIntoIntersection = false;
                    pLink.m_OuterVehicle.RemoveAt(reveh);
                    reveh--;
                    pRightTurningLink = (CLink)m_WestEastLink[EWSize - pVehicle.RowIndex - 1];
                    pRightTurningLink.m_OuterVehicle.Add(pVehicle);
                    pVehicle.RowIndex = -1;
                    pVehicle.ColIndex = link+1;
                    if (pVehicle.ColIndex == SNSize) pVehicle.Movement = AHEAD;
                    else pVehicle.Movement = RandSetVehicleMovement();
                }
            }
        }
        // North - South
        for (link = 0; link < m_NorthSouthLink.Count; link++)
        {
            pLink = (CLink)m_NorthSouthLink[link];
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.bIntoIntersection)
                {
                    pVehicle.Velocity = pVehicle.NextVelocity;
                    pVehicle.Position = pVehicle.NextPosition;
                    pVehicle.bIntoIntersection = false;
                    pLink.m_OuterVehicle.RemoveAt(reveh);
                    reveh--;
                    pRightTurningLink = (CLink)m_EastWestLink[pVehicle.RowIndex];
                    pRightTurningLink.m_OuterVehicle.Add(pVehicle);
                    pVehicle.RowIndex = -1;
                    pVehicle.ColIndex = SNSize-link;
                    if (pVehicle.ColIndex == SNSize) pVehicle.Movement = AHEAD;
                    else pVehicle.Movement = RandSetVehicleMovement();
                }
            }
        }
        // intersection vehicles move into links
        // vehicle in intersection
        pLink = null;
        for (row = 0; row < EWSize; row++)
        {
            for (col = 0; col < SNSize; col++)
            {
                pIntersection = (CIntersection)m_Intersection[row * SNSize + col];
                for (veh = 0; veh < pIntersection.m_Vehicle.Count; veh++)
                {
                    pVehicle = (CVehicle)pIntersection.m_Vehicle[veh];
                    if (!pVehicle.bIntoIntersection)// move into links
                    {                        
                        pIntersection.m_Vehicle.RemoveAt(veh);
                        veh--;
                        switch (pVehicle.Position)
                        {
                            case 14:// North - south
                                pLink = (CLink)m_NorthSouthLink[col];
                                pVehicle.ColIndex = -1;
                                pVehicle.RowIndex = row + 1;
                                if (pVehicle.RowIndex == EWSize) pVehicle.Movement = AHEAD;
                                else pVehicle.Movement = RandSetVehicleMovement();
                                break;

                            case 1:// South - North                            
                                pLink = (CLink)m_SouthNorthLink[col];
                                pVehicle.ColIndex = -1;
                                pVehicle.RowIndex = EWSize - row;
                                if (pVehicle.RowIndex == EWSize) pVehicle.Movement = AHEAD;
                                else pVehicle.Movement = RandSetVehicleMovement();
                                break;

                            case 8:// East - West                    
                                pLink = (CLink)m_EastWestLink[row];
                                pVehicle.ColIndex = SNSize - col;
                                pVehicle.RowIndex = -1;
                                if (pVehicle.ColIndex == SNSize) pVehicle.Movement = AHEAD;
                                else pVehicle.Movement = RandSetVehicleMovement();
                                break;

                            case 7:// West - East                
                                pLink = (CLink)m_WestEastLink[row];
                                pVehicle.ColIndex =  col+1;
                                pVehicle.RowIndex = -1;
                                if (pVehicle.ColIndex == SNSize) pVehicle.Movement = AHEAD;
                                else pVehicle.Movement = RandSetVehicleMovement();
                                break;
                        }
                        pVehicle.Position = pVehicle.NextPosition;
                        pVehicle.Velocity = pVehicle.NextVelocity;
                        pLink.m_InnerVehicle.Add(pVehicle);
                    }
                }
            }
        }
    }
    public void ModelPerformance(int interval)
    {
        SetSignalPhase(interval);
        EastWestVehicleNextMovement();
        WestEastVehicleNextMovement();
        SouthNorthVehicleNextMovement();
        NorthSouthVehicleNextMovement();
        IntersectionVehicleMovement();
        UpdateStatisticData(interval);
        UpdateVehicles();
        VehicleGeneration(interval);
    }
    public void UpdateStatisticData(int interval)
    {
        int row, col;
        int link, veh, reveh;
        CLink pLink;
        CVehicle pVehicle;       
        if (interval == 0)
        {
            for (row = 0; row < EWSize; row++)
            {
                for (col = 0; col < SNSize + 1; col++)
                {
                    EWCumlativeInflow[row, col, interval] = 0;
                    WECumlativeInflow[row, col, interval] = 0;

                    EWCumlativeOutflow[row, col, interval] = 0;
                    WECumlativeOutflow[row, col, interval] = 0;
                }
            }
            for (col = 0; col < SNSize; col++)
            {
                for (row = 0; row < EWSize + 1; row++)
                {
                    SNCumlativeInflow[col, row, interval] = 0;
                    NSCumlativeInflow[col, row, interval] = 0;

                    SNCumlativeOutflow[col, row, interval] = 0;
                    NSCumlativeOutflow[col, row, interval] = 0;
                }
            } 
        }
        else
        {           
            for (row = 0; row < EWSize; row++ )
            {
                for (col = 0; col < SNSize + 1;col++ )
                {
                    EWCumlativeInflow[row, col, interval] = EWCumlativeInflow[row, col, interval - 1];
                    WECumlativeInflow[row, col, interval] = WECumlativeInflow[row, col, interval - 1];

                    EWCumlativeOutflow[row, col, interval] = EWCumlativeOutflow[row, col, interval - 1];
                    WECumlativeOutflow[row, col, interval] = WECumlativeOutflow[row, col, interval - 1];
                }
            }

            for (col = 0; col < SNSize; col++)
            {
                for (row = 0; row < EWSize + 1; row++)
                {
                    SNCumlativeInflow[col, row, interval] = SNCumlativeInflow[col, row, interval - 1];
                    NSCumlativeInflow[col, row, interval] = NSCumlativeInflow[col, row, interval - 1];

                    SNCumlativeOutflow[col, row, interval] = SNCumlativeOutflow[col, row, interval - 1];
                    NSCumlativeOutflow[col, row, interval] = NSCumlativeOutflow[col, row, interval - 1];
                }
            } 
        }
        TotalVehicle[interval] = 0;
        StopTimes[interval] = 0;
        CongestionDelay[interval] = 0;
        int sumVelocity = 0;
        //////////////////////////////////////////////////////////////////////////
        int critposition;
       // East-West
        for (link = 0; link < m_EastWestLink.Count;link++ )
        {
            pLink = (CLink)m_EastWestLink[link];
            //////////////////////////////////////////////////////////////////////////
            TotalVehicle[interval] += pLink.m_InnerVehicle.Count;
            TotalVehicle[interval] += pLink.m_OuterVehicle.Count;
            for (veh = 0; veh < pLink.m_InnerVehicle.Count;veh++ )
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                if (pVehicle.NextVelocity == 0) StopTimes[interval]++;
                sumVelocity += pVehicle.NextVelocity;
                // calculate delay
                CongestionDelay[interval] += (vmax - pVehicle.NextVelocity) * 1.0 / vmax;

                for (col = 0; col < SNSize + 1;col++)
                {
                    if (pVehicle.Position <= EWLinkLenIndex[link,col] && pVehicle.NextPosition > EWLinkLenIndex[link,col])
                    {
                        EWCumlativeInflow[link, col, interval]++;
                       
                        break;
                    }                    
                    // determine outflow
                    if (pVehicle.Movement == AHEAD)
                    {
                        critposition = EWLinkLenIndex[link, col]+EWLinkLength[link, SNSize - col] -1;
                        if (pVehicle.Position <= critposition && pVehicle.NextPosition > critposition)
                        {
                            EWCumlativeOutflow[link, col, interval]++;
                            
                            break;
                        }                        
                    }
                    else if (pVehicle.Movement == LEFT)
                    {
                        critposition = EWLinkLenIndex[link, col] + EWLinkLength[link, SNSize - col] - 1;
                        if (pVehicle.Position == critposition && pVehicle.bIntoIntersection)
                        {
                            EWCumlativeOutflow[link, col, interval]++;
                            break;
                        }
                    }                    
                }
            }
            /////
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.NextVelocity == 0) StopTimes[interval]++;
                sumVelocity += pVehicle.NextVelocity;
                // calculate delay
                CongestionDelay[interval] += (vmax - pVehicle.NextVelocity) * 1.0 / vmax;
                for (col = 0; col < SNSize + 1; col++)
                {
                    if (pVehicle.Position <= EWLinkLenIndex[link, col] && pVehicle.NextPosition > EWLinkLenIndex[link, col])
                    {
                        EWCumlativeInflow[link, col, interval]++;
                        
                        break;
                    }
                    // determine outflow
                    critposition = EWLinkLenIndex[link, col] + EWLinkLength[link, SNSize - col] - 1;
                    if (pVehicle.Movement == AHEAD)                    {
                        
                        if (pVehicle.Position <= critposition && pVehicle.NextPosition > critposition)
                        {
                            EWCumlativeOutflow[link, col, interval]++;
                            break;
                        }
                    }
                    else if (pVehicle.Movement == RIGHT)
                    {                        
                        if (pVehicle.Position == critposition && pVehicle.bIntoIntersection)
                        {
                            EWCumlativeOutflow[link, col, interval]++;
                            break;
                        }
                    } 
                }
            }
        }
        // West-East
        for (link = 0; link < m_WestEastLink.Count; link++)
        {
            pLink = (CLink)m_WestEastLink[link];
            TotalVehicle[interval] += pLink.m_InnerVehicle.Count;
            TotalVehicle[interval] += pLink.m_OuterVehicle.Count;
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                if (pVehicle.NextVelocity == 0) StopTimes[interval]++;
                sumVelocity += pVehicle.NextVelocity;
                // calculate delay
                CongestionDelay[interval] += (vmax - pVehicle.NextVelocity) * 1.0 / vmax;
                for (col = 0; col < SNSize + 1; col++)
                {
                    if (pVehicle.Position <= WELinkLenIndex[link, col] && pVehicle.NextPosition > WELinkLenIndex[link, col])
                    {
                        WECumlativeInflow[link, col, interval]++;
                        
                        break;
                    }
                    // determine outflow
                    critposition = WELinkLenIndex[link, col] + EWLinkLength[link, col] - 1;
                    if (pVehicle.Movement == AHEAD)
                    {                        
                        if (pVehicle.Position <= critposition && pVehicle.NextPosition > critposition)
                        {
                            WECumlativeOutflow[link, col, interval]++;
                            break;
                        }
                    }
                    else if (pVehicle.Movement == LEFT)
                    {                        
                        if (pVehicle.Position == critposition && pVehicle.bIntoIntersection)
                        {
                            WECumlativeOutflow[link, col, interval]++;
                            break;
                        }
                    } 
                }
            }
            /////
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.NextVelocity == 0) StopTimes[interval]++;
                sumVelocity += pVehicle.NextVelocity;
                // calculate delay
                CongestionDelay[interval] += (vmax - pVehicle.NextVelocity) * 1.0 / vmax;
                for (col = 0; col < SNSize + 1; col++)
                {
                    if (pVehicle.Position <= WELinkLenIndex[link, col] && pVehicle.NextPosition > WELinkLenIndex[link, col])
                    {
                        WECumlativeInflow[link, col, interval]++;
                        
                        break;
                    }
                    // determine outflow
                    critposition = WELinkLenIndex[link, col] + EWLinkLength[link, col] - 1;
                    if (pVehicle.Movement == AHEAD)
                    {
                        if (pVehicle.Position <= critposition && pVehicle.NextPosition > critposition)
                        {
                            WECumlativeOutflow[link, col, interval]++;
                            break;
                        }
                    }
                    else if (pVehicle.Movement == RIGHT)
                    {
                        if (pVehicle.Position == critposition && pVehicle.bIntoIntersection)
                        {
                            WECumlativeOutflow[link, col, interval]++;
                            break;
                        }
                    } 
                }
            }
        }
        // South-North
        for (link = 0; link < m_SouthNorthLink.Count; link++)
        {
            pLink = (CLink)m_SouthNorthLink[link];
            TotalVehicle[interval] += pLink.m_InnerVehicle.Count;
            TotalVehicle[interval] += pLink.m_OuterVehicle.Count;
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                if (pVehicle.NextVelocity == 0) StopTimes[interval]++;
                sumVelocity += pVehicle.NextVelocity;
                // calculate delay
                CongestionDelay[interval] += (vmax - pVehicle.NextVelocity) * 1.0 / vmax;
                for (row = 0; row < EWSize + 1; row++)
                {
                    if (pVehicle.Position <= SNLinkLenIndex[link, row] && pVehicle.NextPosition > SNLinkLenIndex[link, row])
                    {
                        SNCumlativeInflow[link, row, interval]++;
                        
                        break;
                    }
                    // determine outflow
                    critposition = SNLinkLenIndex[link, row] + SNLinkLength[link, EWSize-row] - 1;
                    if (pVehicle.Movement == AHEAD)
                    {
                        if (pVehicle.Position <= critposition && pVehicle.NextPosition > critposition)
                        {
                            SNCumlativeOutflow[link, row, interval]++;
                            break;
                        }
                    }
                    else if (pVehicle.Movement == LEFT)
                    {
                        if (pVehicle.Position == critposition && pVehicle.bIntoIntersection)
                        {
                            SNCumlativeOutflow[link, row, interval]++;
                            break;
                        }
                    } 
                }
            }
            /////
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.NextVelocity == 0) StopTimes[interval]++;
                sumVelocity += pVehicle.NextVelocity;
                // calculate delay
                CongestionDelay[interval] += (vmax - pVehicle.NextVelocity) * 1.0 / vmax;
                for (row = 0; row < EWSize + 1; row++)
                {
                    if (pVehicle.Position <= SNLinkLenIndex[link, row] && pVehicle.NextPosition > SNLinkLenIndex[link, row])
                    {
                        SNCumlativeInflow[link, row, interval]++;
                        
                        break;
                    }
                    // determine outflow
                    critposition = SNLinkLenIndex[link, row] + SNLinkLength[link, EWSize - row] - 1;
                    if (pVehicle.Movement == AHEAD)
                    {
                        if (pVehicle.Position <= critposition && pVehicle.NextPosition > critposition)
                        {
                            SNCumlativeOutflow[link, row, interval]++;
                            break;
                        }
                    }
                    else if (pVehicle.Movement == RIGHT)
                    {
                        if (pVehicle.Position == critposition && pVehicle.bIntoIntersection)
                        {
                            SNCumlativeOutflow[link, row, interval]++;
                            break;
                        }
                    } 
                }
            }
        }
        // North-South
        for (link = 0; link < m_NorthSouthLink.Count; link++)
        {
            pLink = (CLink)m_NorthSouthLink[link];
            TotalVehicle[interval] += pLink.m_InnerVehicle.Count;
            TotalVehicle[interval] += pLink.m_OuterVehicle.Count;
            for (veh = 0; veh < pLink.m_InnerVehicle.Count; veh++)
            {
                pVehicle = (CVehicle)pLink.m_InnerVehicle[veh];
                if (pVehicle.NextVelocity == 0) StopTimes[interval]++;
                sumVelocity += pVehicle.NextVelocity;
                // calculate delay
                CongestionDelay[interval] += (vmax - pVehicle.NextVelocity) * 1.0 / vmax;
                for (row = 0; row < EWSize + 1; row++)
                {
                    if (pVehicle.Position <= NSLinkLenIndex[link, row] && pVehicle.NextPosition > NSLinkLenIndex[link, row])
                    {
                        NSCumlativeInflow[link, row, interval]++;
                        
                        break;
                    }

                    // determine outflow
                    critposition = NSLinkLenIndex[link, row] + SNLinkLength[link,  row] - 1;
                    if (pVehicle.Movement == AHEAD)
                    {
                        if (pVehicle.Position <= critposition && pVehicle.NextPosition > critposition)
                        {
                            NSCumlativeOutflow[link, row, interval]++;
                            break;
                        }
                    }
                    else if (pVehicle.Movement == LEFT)
                    {
                        if (pVehicle.Position == critposition && pVehicle.bIntoIntersection)
                        {
                            NSCumlativeOutflow[link, row, interval]++;
                            break;
                        }
                    } 
                }
            }
            /////
            for (reveh = 0; reveh < pLink.m_OuterVehicle.Count; reveh++)
            {
                pVehicle = (CVehicle)pLink.m_OuterVehicle[reveh];
                if (pVehicle.NextVelocity == 0) StopTimes[interval]++;
                sumVelocity += pVehicle.NextVelocity;
                // calculate delay
                CongestionDelay[interval] += (vmax - pVehicle.NextVelocity) * 1.0 / vmax;
                for (row = 0; row < EWSize + 1; row++)
                {
                    if (pVehicle.Position <= NSLinkLenIndex[link, row] && pVehicle.NextPosition > NSLinkLenIndex[link, row])
                    {
                        NSCumlativeInflow[link, row, interval]++;
                       
                        break;
                    }
                    // determine outflow
                    critposition = NSLinkLenIndex[link, row] + SNLinkLength[link, row] - 1;
                    if (pVehicle.Movement == AHEAD)
                    {
                        if (pVehicle.Position <= critposition && pVehicle.NextPosition > critposition)
                        {
                            NSCumlativeOutflow[link, row, interval]++;
                            break;
                        }
                    }
                    else if (pVehicle.Movement == RIGHT)
                    {
                        if (pVehicle.Position == critposition && pVehicle.bIntoIntersection)
                        {
                            NSCumlativeOutflow[link, row, interval]++;
                            break;
                        }
                    } 
                }
            }
        }
        int standardtime;
        // vehicles on link
        for (row = 0; row < EWSize; row++)
        {
            for (col = 0; col < SNSize; col++)
            {
                //East - West
                standardtime = interval - PhaseDelay[row, col];
                while (standardtime < 0)
                {
                    standardtime += SignalPeriod[row, col];
                }
                standardtime = standardtime % SignalPeriod[row, col];
                if (standardtime == EastBegTime[row, col])
                {
                    EWFlow[row, SNSize - col] = EWCumlativeInflow[row, SNSize - col, interval] - EWCumlativeOutflow[row, SNSize - col, interval];
                }
                else if (standardtime == SouthBegTime[row, col])
                {
                    SNFlow[col, EWSize - row] = SNCumlativeInflow[col, EWSize - row, interval] - SNCumlativeOutflow[col, EWSize - row, interval];
                }
                else if (standardtime == WestBegTime[row, col])
                {
                    WEFlow[row, col] = WECumlativeInflow[row, col, interval] - WECumlativeOutflow[row, col, interval];
                }
                else if (standardtime == NorthBegTime[row, col])
                {
                    NSFlow[col, row] = NSCumlativeInflow[col,  row, interval] - NSCumlativeOutflow[col,  row, interval];
                }
            }
        }
        /*for (row = 0; row < EWSize; row++ )
        {
            for (col = 0; col < SNSize; col++ )
            {
                pIntersection = (CIntersection)m_Intersection[row * SNSize + col];
                TotalVehicle[interval] += pIntersection.m_Vehicle.Count;
                sumVelocity += pIntersection.m_Vehicle.Count;
            }
        }*/
        if (TotalVehicle[interval] > 0)
            AverageVelocity[interval] = 27 * sumVelocity / TotalVehicle[interval];
        else
            AverageVelocity[interval] = 27 * vmax;
    }
    public void SeperateSetSignal(int interval)
    {
        int direct;
        double sumflow = 0;
        double phi;
        double[] rate = new double[4];
        int miniPeriod = 70, maxPeriod = 120;

        int row,col;
        int[] flow = new int[4];
        int[] greentime = new int[4];
        int[] freetime = new int[4];

        if (interval < 300) return;
        if (interval < PredictLength) return;
        int standinter;        
        for (row = 0; row < EWSize; row++)
        {
            for (col = 0; col < SNSize; col++)
            {
                standinter = interval - PhaseDelay[row, col];
                if (standinter % SignalPeriod[row, col] != 0) continue;
                //Get flow data
                freetime[0] = EWLinkLength[row, SNSize - col-1]/vmax;
                freetime[1] = SNLinkLength[col, EWSize - row - 1] / vmax;
                freetime[2] = EWLinkLength[row, col] / vmax;
                freetime[3] = SNLinkLength[col, row] / vmax;

                // East- West                
                flow[0] = EWCumlativeInflow[row, SNSize - col - 1, interval] - EWCumlativeOutflow[row, SNSize - col - 1, interval - PredictLength + freetime[0]];
                //South-North
                flow[1] = SNCumlativeInflow[col, EWSize - row - 1, interval] - SNCumlativeOutflow[col, EWSize - row - 1, interval - PredictLength + freetime[1]];
                // West-East
                flow[2] = WECumlativeInflow[row, col, interval] - WECumlativeOutflow[row, col, interval - PredictLength + freetime[2]];
                //North-South
                flow[3] = NSCumlativeInflow[col, row, interval] - NSCumlativeOutflow[col, row, interval - PredictLength + freetime[3]];


                //// East- West                
                //flow[0] = EWFlow[row, SNSize - col - 1];
                ////South-North
                //flow[1] = SNFlow[col, EWSize - row - 1] ;
                //// West-East
                //flow[2] = WEFlow[row, col] ;
                ////North-South
                //flow[3] = NSFlow[col, row] ;

                //// East- West
                //flow[0] = EWCumlativeInflow[row, SNSize - col - 1, interval] - EWCumlativeInflow[row, SNSize - col - 1, interval - PredictLength];
                ////South-North
                //flow[1] = SNCumlativeInflow[col, EWSize - row - 1, interval] - SNCumlativeInflow[col, EWSize - row - 1, interval - PredictLength];
                //// West-East
                //flow[2] = WECumlativeInflow[row, col, interval] - WECumlativeInflow[row, col, interval - PredictLength];
                ////North-South
                //flow[3] = NSCumlativeInflow[col, row, interval] - NSCumlativeInflow[col, row, interval - PredictLength];
                
                //determine signal
                sumflow = 0;
                for (direct = 0; direct < 4; direct++)
                {
                    if (flow[direct] <= 0) flow[direct] = 1;
                    sumflow += flow[direct];
                }
                for (direct = 0; direct < 4; direct++)
                    rate[direct] = flow[direct] / sumflow;
                phi = 1.0 * sumflow * 3600 / (Capacity * PredictLength);
                //SignalPeriod[row, col] = (int)((1.5 * 12 + 4) / (1 - phi) + 0.5);
                //if (phi > 1) SignalPeriod[row, col] = 1000;
                SignalPeriod[row, col] = MinimumSignalPeriod;

                if (SignalPeriod[row, col] < miniPeriod) SignalPeriod[row, col] = miniPeriod;
                else if (SignalPeriod[row, col] > maxPeriod) SignalPeriod[row, col] = maxPeriod;

                int validtime = SignalPeriod[row, col] - 12;
                bool[] bLess = new bool[4];

                for (direct = 0; direct < 4; direct++)
                {
                    bLess[direct] = false;
                    greentime[direct] = (int)((SignalPeriod[row, col] - 12) * rate[direct] + 0.5);
                    if (greentime[direct] < 12)
                    {
                        bLess[direct] = true;
                        greentime[direct] = 12;
                        validtime -= greentime[direct];
                    }
                }

                sumflow = 0;
                for (direct = 0; direct < 4; direct++)
                {
                    if(!bLess[direct])
                        sumflow += flow[direct];
                }
                for (direct = 0; direct < 4; direct++)
                    if(!bLess[direct])
                        rate[direct] = flow[direct] / sumflow;
                for (direct = 0; direct < 4; direct++)
                    if (!bLess[direct])
                        greentime[direct] = (int)(validtime * rate[direct] + 0.5);

                // determine phase
                EastBegTime[row, col] = 0;
                EastEndTime[row, col] = EastBegTime[row, col] + greentime[0] - 1;

                SouthBegTime[row, col] = EastEndTime[row, col] + 3;
                SouthEndTime[row, col] = SouthBegTime[row, col] + greentime[1] - 1;

                WestBegTime[row, col] = SouthEndTime[row, col] + 3;
                WestEndTime[row, col] = WestBegTime[row, col] + greentime[2] - 1;

                NorthBegTime[row, col] = WestEndTime[row, col] + 3;
                NorthEndTime[row, col] = NorthBegTime[row, col] + greentime[3] - 1;

                SignalPeriod[row, col] = NorthEndTime[row, col] + 4;

                PhaseDelay[row,col] = interval%SignalPeriod[row,col];
            }
        }
    }
    public void SetFixedSignal(int miniPeriod)
    {
        int direct;
        double[] rate = new double[4];       
        int row, col;
        int[] greentime = new int[4];
        for (row = 0; row < EWSize; row++)
        {
            for (col = 0; col < SNSize; col++)
            {
                SignalPeriod[row, col] = miniPeriod;
                for (direct = 0; direct < 4; direct++)
                {
                    rate[direct] = 0.25;
                    greentime[direct] = (int)((SignalPeriod[row, col] - 12) * rate[direct] + 0.5);
                }               
                // determine phase
                EastBegTime[row, col] = 0;
                EastEndTime[row, col] = EastBegTime[row, col] + greentime[0] - 1;

                SouthBegTime[row, col] = EastEndTime[row, col] + 4;
                SouthEndTime[row, col] = SouthBegTime[row, col] + greentime[1] - 1;

                WestBegTime[row, col] = SouthEndTime[row, col] + 4;
                WestEndTime[row, col] = WestBegTime[row, col] + greentime[2] - 1;

                NorthBegTime[row, col] = WestEndTime[row, col] + 4;
                NorthEndTime[row, col] = NorthBegTime[row, col] + greentime[3] - 1;

                SignalPeriod[row, col] = NorthEndTime[row, col] + 4;

                PhaseDelay[row, col] = (int)(SignalPeriod[row, col] * Rand.NextDouble());
                //PhaseDelay[row, col] = (row+col)*5;
            }
        }
    }
    public void SetFixedSignal()
    {
        int direct;      
        double[] rate = new double[4];
        int miniPeriod = 100;
        int row, col;        
        int[] greentime = new int[4];
        for (row = 0; row < EWSize; row++)
        {
            for (col = 0; col < SNSize; col++)
            {
                SignalPeriod[row, col] = miniPeriod;
                for (direct = 0; direct < 4; direct++)
                {
                    rate[direct] = 0.25;
                    greentime[direct] = (int)((SignalPeriod[row, col] - 12) * rate[direct] + 0.5);
                }
                // determine phase
                EastBegTime[row, col] = 0;
                EastEndTime[row, col] = EastBegTime[row, col] + greentime[0] - 1;

                SouthBegTime[row, col] = EastEndTime[row, col] + 4;
                SouthEndTime[row, col] = SouthBegTime[row, col] + greentime[1] - 1;

                WestBegTime[row, col] = SouthEndTime[row, col] + 4;
                WestEndTime[row, col] = WestBegTime[row, col] + greentime[2] - 1;

                NorthBegTime[row, col] = WestEndTime[row, col] + 4;
                NorthEndTime[row, col] = NorthBegTime[row, col] + greentime[3] - 1;

                SignalPeriod[row, col] = NorthEndTime[row, col] + 4;
              
            }
        }
    }
    public void DetermineOptimalFixedSignal()
    {
        MaxInterval = 7200;
        int index, num = 10;
        int interval, signalperiod;
        double sumdelay = 0;
        double sumVehicle = 0, averStop = 0;
        double averSpeed = 0;

        double[] speed = new double[num];
        for (index = 0; index < num; index++)
        {
            signalperiod = 70 + index * 4;
            InitialStatisticVariables();
            RemoveAllVehicles();
            SetFixedSignal();
            for (interval = 0; interval < MaxInterval; interval++)
            {
                NowTime = interval;
                ModelPerformance(interval);
            }
            sumVehicle = 0;
            averStop = 0;
            sumdelay = 0;
            averSpeed = 0;
            for (interval = 360; interval < MaxInterval; interval++)
            {
                sumVehicle += TotalVehicle[interval];
                averStop += StopTimes[interval];
                averSpeed += AverageVelocity[interval] * TotalVehicle[interval];
                sumdelay += CongestionDelay[interval];
            }
            sumdelay /= 3600;
            averStop /= sumVehicle;
            averSpeed /= sumVehicle;
            speed[index] = averSpeed;
        }
        index = 0;

    }
    public void SimulationWithFixedSignal()
    {
        int interval;
        double sumdelay = 0;
        MaxInterval = 7200;
        InitialStatisticVariables();
        RemoveAllVehicles();
        //SetLineSignal();
        //SetnoLineSignal();
        SetFixedSignal(MinimumSignalPeriod);     
        for (interval = 0; interval < MaxInterval;interval++)
        {
            NowTime = interval;
            ModelPerformance(interval);
        }
        double sumVehicle = 0, averStop = 0;
        double averSpeed = 0;
        for (interval = 360; interval < MaxInterval; interval++ )
        {
            sumVehicle += TotalVehicle[interval];
            averStop += StopTimes[interval];
            averSpeed += AverageVelocity[interval] * TotalVehicle[interval];
            sumdelay += CongestionDelay[interval];
        }
        sumdelay /= 3600;
        averStop /= sumVehicle;
        averSpeed /= sumVehicle;
        Matrix.Output(TotalVehicle, "TotalVehicle.txt");
        Matrix.Output(AverageVelocity, "AverageVelocity.txt");
        Matrix.Output(StopTimes, "StopTimes.txt");
        Matrix.Output(CongestionDelay, "CongestionDelay.txt");      
    }
    public void SimulationWithDynamicSignal()
    {
        int interval;
        double sumdelay = 0;
        MaxInterval = 7200;
        InitialStatisticVariables();
        RemoveAllVehicles();
        SetFixedSignal();
        for (interval = 0; interval < MaxInterval; interval++)
        {
            NowTime = interval;
            ModelPerformance(interval);
            SeperateSetSignal(interval);
        }
        double sumVehicle = 0, averStop = 0;
        double averSpeed = 0;
        for (interval = 360; interval < MaxInterval; interval++)
        {
            sumVehicle += TotalVehicle[interval];
            averStop += StopTimes[interval];
            averSpeed += AverageVelocity[interval] * TotalVehicle[interval];
            sumdelay += CongestionDelay[interval];
        }
        sumdelay /= 3600;
        averStop /= sumVehicle;
        averSpeed /= sumVehicle;
        Matrix.Output(TotalVehicle, "TotalVehicle.txt");
        Matrix.Output(AverageVelocity, "AverageVelocity.txt");
        Matrix.Output(StopTimes, "StopTimes.txt");
        Matrix.Output(CongestionDelay, "CongestionDelay.txt");
    }
    public void SetLineSignal()
    {
        PhaseDelay[0, 0] = 27;
        PhaseDelay[0, 1] = 0;

        //SignalPeriod[0, 0] = 111;
        //SignalPeriod[0, 1] = 111;

        EastBegTime[0, 0] = 0;
        EastEndTime[0, 0] = EastBegTime[0, 0] + 27 - 1;        

        WestBegTime[0, 0] = EastEndTime[0, 0] + 4;
        WestEndTime[0, 0] = WestBegTime[0, 0] + 27 - 1;

        SouthBegTime[0, 0] = WestEndTime[0, 0] + 4;
        SouthEndTime[0, 0] = SouthBegTime[0, 0] + 21 - 1;

        NorthBegTime[0, 0] = SouthEndTime[0, 0] + 4;
        NorthEndTime[0, 0] = NorthBegTime[0, 0] + 24 - 1;

        SignalPeriod[0, 0] = NorthEndTime[0, 0] + 4;

        EastBegTime[0, 1] = 0;
        EastEndTime[0, 1] = EastBegTime[0, 1] + 25 - 1;

        SouthBegTime[0, 1] = EastEndTime[0, 1] + 4;
        SouthEndTime[0, 1] = SouthBegTime[0, 1] + 29 - 1;

        NorthBegTime[0, 1] = SouthEndTime[0, 1] + 4;
        NorthEndTime[0, 1] = NorthBegTime[0, 1] + 21 - 1;

        WestBegTime[0, 1] = NorthEndTime[0, 1] + 4;
        WestEndTime[0, 1] = WestBegTime[0, 1] + 24 - 1;

        SignalPeriod[0, 1] = WestEndTime[0, 1] + 4;
    }
    public void SetnoLineSignal()
    {
        PhaseDelay[0, 0] = 0;
        PhaseDelay[0, 1] = 0;

        //SignalPeriod[0, 0] = 111;
        //SignalPeriod[0, 1] = 111;

        EastBegTime[0, 0] = 0;
        EastEndTime[0, 0] = EastBegTime[0, 0] + 24 - 1;

        WestBegTime[0, 0] = EastEndTime[0, 0] + 4;
        WestEndTime[0, 0] = WestBegTime[0, 0] + 26 - 1;

        SouthBegTime[0, 0] = WestEndTime[0, 0] + 4;
        SouthEndTime[0, 0] = SouthBegTime[0, 0] + 18 - 1;

        NorthBegTime[0, 0] = SouthEndTime[0, 0] + 4;
        NorthEndTime[0, 0] = NorthBegTime[0, 0] + 22 - 1;

        SignalPeriod[0, 0] = NorthEndTime[0, 0] + 4;

        EastBegTime[0, 1] = 0;
        EastEndTime[0, 1] = EastBegTime[0, 1] + 25 - 1;

        SouthBegTime[0, 1] = EastEndTime[0, 1] + 4;
        SouthEndTime[0, 1] = SouthBegTime[0, 1] + 29 - 1;

        NorthBegTime[0, 1] = SouthEndTime[0, 1] + 4;
        NorthEndTime[0, 1] = NorthBegTime[0, 1] + 21 - 1;

        WestBegTime[0, 1] = NorthEndTime[0, 1] + 4;
        WestEndTime[0, 1] = WestBegTime[0, 1] + 24 - 1;

        SignalPeriod[0, 1] = WestEndTime[0, 1] + 4;
    }
}
