using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace NetworkCA
{
    public partial class Form1 : Form
    {
        CNetwork pNetwork;       
        int NowTime;
        bool bPause;
        int RunInterval;
        public Form1()
        {
            InitializeComponent();
            SetStyle(ControlStyles.UserPaint, true);
            SetStyle(ControlStyles.AllPaintingInWmPaint, true); // 禁止擦除背景.
            SetStyle(ControlStyles.DoubleBuffer, true); // 双缓冲
            this.WindowState = FormWindowState.Maximized;
            pNetwork = new CNetwork();
            pNetwork.NetworkGeneration(2,3, 4);
            //pNetwork.RandomGenerateLinkLength();
            pNetwork.ReadLinkLength("LinkLength23.txt");
            pNetwork.SetFixedSignal(86);
            //pNetwork.SetLineSignal();
            pNetwork.SetSignalPhase(0);
            pNetwork.ReadTrafficDemand("demand23.txt");             
            bPause = false;
            RunInterval = 50;
        }

        private void Form1_Paint(object sender, PaintEventArgs e)
        {
            e.Graphics.FillRectangle(Brushes.White, this.ClientRectangle);
            Rectangle MapRect = new Rectangle(ClientRectangle.Left + ClientRectangle.Width / 32,
                ClientRectangle.Top + ClientRectangle.Height / 32, ClientRectangle.Width - ClientRectangle.Width / 16,
                ClientRectangle.Height - ClientRectangle.Height / 16);
            Bitmap bmp = null;
            bmp = pNetwork.DrawVehicularNetwork(MapRect);

            e.Graphics.DrawImage(bmp, MapRect);
            bmp.Dispose();
        }

        private void PropagateTimer_Tick(object sender, EventArgs e)
        {            
            pNetwork.ModelPerformance(NowTime);
            //pNetwork.SeperateSetSignal(NowTime);
            NowTime++;
            pNetwork.NowTime = NowTime;            
            if (NowTime >= pNetwork.MaxInterval)
            {
                PropagateTimer.Stop();
            }
            this.Invalidate();
        }

        private void startToolStripMenuItem_Click(object sender, EventArgs e)
        {
            PropagateTimer.Interval = RunInterval;
            PropagateTimer.Start();
            NowTime = 0;
            pNetwork.NowTime = NowTime;
            pNetwork.InitialStatisticVariables();
            //pNetwork.VehicleInitialization(0.3);
            this.Invalidate();
        }

        private void endToolStripMenuItem_Click(object sender, EventArgs e)
        {
            PropagateTimer.Stop();
            this.Invalidate();
        }

        private void pasueToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (this.bPause)
            {
                pauseToolStripMenuItem.Text = "Pause";
                PropagateTimer.Interval = PropagateTimer.Interval = RunInterval;
                bPause = false;

            }
            else
            {
                pauseToolStripMenuItem.Text = "Continue";
                PropagateTimer.Interval = int.MaxValue;
                bPause = true;
            }
        }

        private void testToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //pNetwork.SimulationWithFixedSignal();
            pNetwork.SimulationWithDynamicSignal();
            
        }

        private void fixedToolStripMenuItem_Click(object sender, EventArgs e)
        {
            pNetwork.SimulationWithFixedSignal();
            //pNetwork.DetermineOptimalFixedSignal();
        }
    }
}