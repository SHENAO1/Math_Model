#pragma once

#include "calculate.h"
#include <cmath>
#include <algorithm>
#include "geometry.h"

namespace 数学建模D 
{
	using namespace std;
	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;
	using namespace System::Drawing::Drawing2D;

	calculate calc;
	vector<SEGMENT> S;

	public ref class FrmMain : public System::Windows::Forms::Form
	{
	public:

		System::Drawing::Graphics^ graphics;

		FrmMain(void)
		{
			InitializeComponent();

			graphics = Graphics::FromHwnd(this->panel1->Handle);
		}

	protected:
		/// <summary>
		/// 清理所有正在使用的资源。
		/// </summary>
		~FrmMain()
		{
			if (components)
			{
				delete components;
			}
		}
	private: System::Windows::Forms::Panel^  panel1;
	protected: 
	private: System::Windows::Forms::Button^  button1;
	private: System::Windows::Forms::Button^  button2;
	private: System::Windows::Forms::StatusStrip^  statusStrip1;
	private: System::Windows::Forms::ToolStripStatusLabel^  toolStripStatusLabel1;
	private: System::Windows::Forms::TextBox^  textBox1;
	private: System::Windows::Forms::Button^  button3;
	private: System::Windows::Forms::Button^  btnPatrol1;



	private: System::Windows::Forms::Button^  button7;
	private: System::Windows::Forms::ToolStripStatusLabel^  toolStripStatusLabel2;
	private: System::Windows::Forms::Button^  button8;
	private: System::Windows::Forms::Button^  button9;


	private: System::Windows::Forms::Button^  button6;
	private: System::Windows::Forms::Button^  button4;


	private:
		/// <summary>
		/// 必需的设计器变量。
		/// </summary>
		System::ComponentModel::Container ^components;

	#pragma region 窗体设计代码
		/// <summary>
		/// 设计器支持所需的方法 - 不要
		/// 使用代码编辑器修改此方法的内容。
		/// </summary>
		void InitializeComponent(void)
		{
			this->panel1 = (gcnew System::Windows::Forms::Panel());
			this->button1 = (gcnew System::Windows::Forms::Button());
			this->button2 = (gcnew System::Windows::Forms::Button());
			this->statusStrip1 = (gcnew System::Windows::Forms::StatusStrip());
			this->toolStripStatusLabel1 = (gcnew System::Windows::Forms::ToolStripStatusLabel());
			this->toolStripStatusLabel2 = (gcnew System::Windows::Forms::ToolStripStatusLabel());
			this->textBox1 = (gcnew System::Windows::Forms::TextBox());
			this->button3 = (gcnew System::Windows::Forms::Button());
			this->btnPatrol1 = (gcnew System::Windows::Forms::Button());
			this->button7 = (gcnew System::Windows::Forms::Button());
			this->button8 = (gcnew System::Windows::Forms::Button());
			this->button9 = (gcnew System::Windows::Forms::Button());
			this->button6 = (gcnew System::Windows::Forms::Button());
			this->button4 = (gcnew System::Windows::Forms::Button());
			this->statusStrip1->SuspendLayout();
			this->SuspendLayout();
			// 
			// panel1
			// 
			this->panel1->BackColor = System::Drawing::SystemColors::Window;
			this->panel1->BorderStyle = System::Windows::Forms::BorderStyle::FixedSingle;
			this->panel1->Location = System::Drawing::Point(144, 12);
			this->panel1->Name = L"panel1";
			this->panel1->Size = System::Drawing::Size(636, 520);
			this->panel1->TabIndex = 0;
			this->panel1->Paint += gcnew System::Windows::Forms::PaintEventHandler(this, &FrmMain::panel1_Paint);
			this->panel1->MouseMove += gcnew System::Windows::Forms::MouseEventHandler(this, &FrmMain::panel1_MouseMove);
			this->panel1->MouseClick += gcnew System::Windows::Forms::MouseEventHandler(this, &FrmMain::panel1_MouseClick);
			// 
			// button1
			// 
			this->button1->Location = System::Drawing::Point(21, 44);
			this->button1->Name = L"button1";
			this->button1->Size = System::Drawing::Size(98, 26);
			this->button1->TabIndex = 1;
			this->button1->Text = L"重要位置区域";
			this->button1->UseVisualStyleBackColor = true;
			this->button1->Click += gcnew System::EventHandler(this, &FrmMain::button1_Click);
			// 
			// button2
			// 
			this->button2->Location = System::Drawing::Point(21, 12);
			this->button2->Name = L"button2";
			this->button2->Size = System::Drawing::Size(98, 26);
			this->button2->TabIndex = 2;
			this->button2->Text = L"绘制地图";
			this->button2->UseVisualStyleBackColor = true;
			this->button2->Click += gcnew System::EventHandler(this, &FrmMain::button2_Click);
			// 
			// statusStrip1
			// 
			this->statusStrip1->Items->AddRange(gcnew cli::array< System::Windows::Forms::ToolStripItem^  >(2) {this->toolStripStatusLabel1, 
				this->toolStripStatusLabel2});
			this->statusStrip1->Location = System::Drawing::Point(0, 544);
			this->statusStrip1->Name = L"statusStrip1";
			this->statusStrip1->Size = System::Drawing::Size(792, 22);
			this->statusStrip1->TabIndex = 3;
			this->statusStrip1->Text = L"statusStrip1";
			// 
			// toolStripStatusLabel1
			// 
			this->toolStripStatusLabel1->Name = L"toolStripStatusLabel1";
			this->toolStripStatusLabel1->Size = System::Drawing::Size(53, 17);
			this->toolStripStatusLabel1->Text = L"覆盖率: ";
			// 
			// toolStripStatusLabel2
			// 
			this->toolStripStatusLabel2->Name = L"toolStripStatusLabel2";
			this->toolStripStatusLabel2->Size = System::Drawing::Size(0, 17);
			// 
			// textBox1
			// 
			this->textBox1->Location = System::Drawing::Point(3, 290);
			this->textBox1->MaxLength = 33554432;
			this->textBox1->Multiline = true;
			this->textBox1->Name = L"textBox1";
			this->textBox1->ScrollBars = System::Windows::Forms::ScrollBars::Vertical;
			this->textBox1->Size = System::Drawing::Size(138, 242);
			this->textBox1->TabIndex = 4;
			// 
			// button3
			// 
			this->button3->Location = System::Drawing::Point(21, 76);
			this->button3->Name = L"button3";
			this->button3->Size = System::Drawing::Size(98, 24);
			this->button3->TabIndex = 5;
			this->button3->Text = L"划分区域";
			this->button3->UseVisualStyleBackColor = true;
			this->button3->Click += gcnew System::EventHandler(this, &FrmMain::button3_Click);
			// 
			// btnPatrol1
			// 
			this->btnPatrol1->Location = System::Drawing::Point(21, 106);
			this->btnPatrol1->Name = L"btnPatrol1";
			this->btnPatrol1->Size = System::Drawing::Size(98, 24);
			this->btnPatrol1->TabIndex = 6;
			this->btnPatrol1->Text = L"巡逻方案1";
			this->btnPatrol1->UseVisualStyleBackColor = true;
			this->btnPatrol1->Click += gcnew System::EventHandler(this, &FrmMain::btnPatrol1_Click);
			// 
			// button7
			// 
			this->button7->Location = System::Drawing::Point(21, 197);
			this->button7->Name = L"button7";
			this->button7->Size = System::Drawing::Size(98, 25);
			this->button7->TabIndex = 9;
			this->button7->Text = L"隐蔽巡逻方案2";
			this->button7->UseVisualStyleBackColor = true;
			this->button7->Click += gcnew System::EventHandler(this, &FrmMain::button7_Click);
			// 
			// button8
			// 
			this->button8->Location = System::Drawing::Point(21, 136);
			this->button8->Name = L"button8";
			this->button8->Size = System::Drawing::Size(98, 24);
			this->button8->TabIndex = 10;
			this->button8->Text = L"巡逻方案2";
			this->button8->UseVisualStyleBackColor = true;
			this->button8->Click += gcnew System::EventHandler(this, &FrmMain::button8_Click);
			// 
			// button9
			// 
			this->button9->Location = System::Drawing::Point(21, 166);
			this->button9->Name = L"button9";
			this->button9->Size = System::Drawing::Size(98, 25);
			this->button9->TabIndex = 11;
			this->button9->Text = L"隐蔽巡逻方案1";
			this->button9->UseVisualStyleBackColor = true;
			this->button9->Click += gcnew System::EventHandler(this, &FrmMain::button9_Click);
			// 
			// button6
			// 
			this->button6->Location = System::Drawing::Point(21, 259);
			this->button6->Name = L"button6";
			this->button6->Size = System::Drawing::Size(98, 25);
			this->button6->TabIndex = 12;
			this->button6->Text = L"加速后巡逻方案";
			this->button6->UseVisualStyleBackColor = true;
			this->button6->Click += gcnew System::EventHandler(this, &FrmMain::button6_Click);
			// 
			// button4
			// 
			this->button4->Location = System::Drawing::Point(21, 228);
			this->button4->Name = L"button4";
			this->button4->Size = System::Drawing::Size(98, 25);
			this->button4->TabIndex = 13;
			this->button4->Text = L"10辆车巡逻方案";
			this->button4->UseVisualStyleBackColor = true;
			this->button4->Click += gcnew System::EventHandler(this, &FrmMain::button4_Click);
			// 
			// FrmMain
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 12);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(792, 566);
			this->Controls->Add(this->button4);
			this->Controls->Add(this->button6);
			this->Controls->Add(this->button9);
			this->Controls->Add(this->button8);
			this->Controls->Add(this->button7);
			this->Controls->Add(this->btnPatrol1);
			this->Controls->Add(this->button3);
			this->Controls->Add(this->textBox1);
			this->Controls->Add(this->statusStrip1);
			this->Controls->Add(this->button2);
			this->Controls->Add(this->button1);
			this->Controls->Add(this->panel1);
			this->FormBorderStyle = System::Windows::Forms::FormBorderStyle::FixedSingle;
			this->MaximizeBox = false;
			this->Name = L"FrmMain";
			this->Text = L"数学建模D";
			this->Load += gcnew System::EventHandler(this, &FrmMain::FrmMain_Load);
			this->statusStrip1->ResumeLayout(false);
			this->statusStrip1->PerformLayout();
			this->ResumeLayout(false);
			this->PerformLayout();

		}
	#pragma endregion

	#pragma region 自定义函数
	private:
		
		float multiples;
		float offset_x;
		float offset_y;
		static const float interval = 10.0f;

		void Paint_Init()
		{
			multiples = (float)min(((double)this->panel1->Width - 2.0 * interval) / MAX_WIDTH, ((double)this->panel1->Height - 2.0 * interval) / MAX_HEIGHT);
			offset_x = ((float)this->panel1->Width - multiples * (float)MAX_WIDTH) / 2.0f;
			offset_y = ((float)this->panel1->Height + multiples * (float)MAX_HEIGHT) / 2.0f;

			graphics->Clear(Color::White);
		}

		//绘制点
		void Paint_Point(const POINT& p)
		{
			int x = (int)((float)p.x * multiples + offset_x);
			int y = (int)((float)p.y * -multiples + offset_y);

			SolidBrush^ sbrush = gcnew SolidBrush(Color::Red); 
			graphics->FillRectangle(sbrush, x, y, 3, 3);
		}

		//绘制线
		void Paint_Line(Color color, const POINT& A, const POINT& B)
		{
			float x1 = (float)A.x * multiples + offset_x;
			float y1 = (float)A.y * -multiples + offset_y;			
			float x2 = (float)B.x * multiples + offset_x;
			float y2 = (float)B.y * -multiples + offset_y;

			graphics->DrawLine(gcnew Pen(color), x1, y1, x2, y2);
		}

	#pragma endregion

	private: 
		
		int nCar;

		System::Void FrmMain_Load(System::Object^  sender, System::EventArgs^  e) 
		{
			calc.data.Input();
			calc.Init();
			Paint_Init();
			
			nCar = 0;
			this->textBox1->Text = "";
			S.clear();

			for(size_t i = 0; i < calc.data.roads.size(); i ++)
			{
				int a = calc.data.roads[i].a;
				int b = calc.data.roads[i].b;
				SEGMENT s(calc.data.points[a], calc.data.points[b]);
				S.push_back(s);
			}
		}
	private:
		//绘制离3个重要点最近的区域
		System::Void button1_Click(System::Object^  sender, System::EventArgs^  e) 
		{
			calc.Calc_Special_Point();
			for(int i = 0; i < 3; i ++)
			{
				for(size_t j = 0; j < calc.S[i].size(); j ++)
				{
					Paint_Line(Color::Yellow, calc.S[i][j].a, calc.S[i][j].b);
				}
			}
		}
	private: 
		//绘制地图
		System::Void button2_Click(System::Object^  sender, System::EventArgs^  e) 
		{
			for(int i = 0; i < calc.data.n; i ++)
			{
				Paint_Point(calc.data.points[i]);
			}
			for(int i = 0; i < calc.data.n; i ++)
			{
				for(int j = i + 1; j < calc.data.n; j ++)
				{
					if(calc.data.bConnect[i][j])
					{
						Paint_Line(Color::Black, calc.data.points[i], calc.data.points[j]);
					}
				}
			}
 
			nCar = 0;
			this->textBox1->Text = "";
			S.clear();
			for(size_t i = 0; i < calc.data.roads.size(); i ++)
			{
				int a = calc.data.roads[i].a;
				int b = calc.data.roads[i].b;
				SEGMENT s(calc.data.points[a], calc.data.points[b]);
				S.push_back(s);
			}
			this->toolStripStatusLabel1->Text = "覆盖率: ";			
		}
	private: 
		System::Void panel1_Paint(System::Object^  sender, System::Windows::Forms::PaintEventArgs^  e) 
		{
			graphics->Clear(Color::White);
			for(int i = 0; i < calc.data.n; i ++)
			{
				Paint_Point(calc.data.points[i]);
			}
			for(int i = 0; i < calc.data.n; i ++)
			{
				for(int j = i + 1; j < calc.data.n; j ++)
				{
					if(calc.data.bConnect[i][j])
					{
						Paint_Line(Color::Black, calc.data.points[i], calc.data.points[j]);
					}
				}
			}
			for(int i = 0; i < 3; i ++)
			{
				for(size_t j = 0; j < calc.S[i].size(); j ++)
				{
					Paint_Line(Color::Yellow, calc.S[i][j].a, calc.S[i][j].b);
				}
			}
		}
	private: 
		System::Void panel1_MouseClick(System::Object^  sender, System::Windows::Forms::MouseEventArgs^  e) 
		{
			POINT p;
			p.x = ((double)e->X - (double)offset_x) / multiples;
			p.y = ((double)e->Y - (double)offset_y) / -multiples;

			//若单击鼠标左键
			if(e->Button == System::Windows::Forms::MouseButtons::Left)
			{
				vector<SEGMENT> S1;

				int id;
				POINT I;
				calc.Shortest_Road(p, id, I);
				S1 = calc.Cover_Region1(I, id, 180.0 * V2);
			
				for(size_t i = 0; i < S1.size(); i ++)
				{
					Paint_Line(Color::Blue, S1[i].a, S1[i].b);
				}

				nCar ++;
				this->textBox1->Text += nCar.ToString() + " " + I.x.ToString("0.00") + " " + I.y.ToString("0.00") + "\r\n";

				S = Differ_Segments1(S, S1);

				double l = 0.0;
				for(size_t i = 0; i < S.size(); i ++)
				{
					l += Distance(S[i].a, S[i].b);
				}
				double r = (calc.totalLength - l) / calc.totalLength;
				this->toolStripStatusLabel1->Text = "覆盖率: " + r.ToString("0.00%");
			}
			//若单击鼠标右键
			else if(e->Button == System::Windows::Forms::MouseButtons::Right)
			{
				vector<SEGMENT> S1;

				int id;
				POINT I;
				calc.Shortest_Road(p, id, I);
				int a = calc.data.roads[id].a;
				int b = calc.data.roads[id].b;
				Paint_Line(Color::Red, calc.data.points[a], calc.data.points[b]);
				
				nCar ++;
				this->textBox1->Text += nCar.ToString() + " " + id.ToString() + "\r\n";
			}
		}
	private: 
		//划分区域
		System::Void button3_Click(System::Object^  sender, System::EventArgs^  e) 
		{
			Color color;
			for(size_t i = 0; i < calc.data.regions.size(); i ++)
			{
				if(i <= 2) color = Color::Yellow;
				else if(i == 3) color = Color::Red;
				else if(i == 4) color = Color::Brown;
				else if(i == 5) color = Color::Blue;
				else if(i == 6) color = Color::Green;
				else if(i == 7) color = Color::Blue;
				else if(i == 8) color = Color::Green;
				else if(i == 9) color = Color::Red;
				else if(i == 10) color = Color::Blue;
				else if(i == 11) color = Color::Red;
				else if(i == 12) color = Color::Green;
				else if(i == 13) color = Color::Brown;

				for(size_t j = 0; j < calc.data.regions[i].roads_id.size(); j ++)
				{
					int road_id = calc.data.regions[i].roads_id[j];
					int a = calc.data.roads[road_id].a;
					int b = calc.data.roads[road_id].b;
					Paint_Line(color, calc.data.points[a], calc.data.points[b]);
				}
			}
		}
	private: 
		System::Void btnPatrol1_Click(System::Object^  sender, System::EventArgs^  e) 
		{
			this->textBox1->Text = "巡逻方案1：\r\n"
				+ "1.考虑道路上的每个点事件发生的概率相同\r\n"
				+ "2.给每条道路i一个权值vi,初始时vi为0\r\n"
				+ "3.当警车访问完一条道路后将这条道路的vi值加1"
				+ "4.当警车到达交叉口时，选择vi值最小的道路行进";
			calc.Patrol1(calc.rCar1, calc.nCar1);
			MessageBox::Show("重点区域平均响应时间: " + calc.A.ToString("0.00") + "（分）\r\n" 
				+ "非重点区域平均响应时间: " + calc.B.ToString("0.00") + "（分）\r\n" 
				+ "道路覆盖率(震慑性): " + calc.Z.ToString("0.00%") + "\r\n"
				+ "重点区域事件被及时处理的概率：" + calc.P1.ToString("0.00%") + "\r\n"
				+ "非重点区域事件被及时处理的概率：" + calc.P2.ToString("0.00%") + "\r\n"
				+ "隐蔽性指标为: " + calc.H.ToString("0.00") + "\r\n"
				+ "经济指标：" + calc.J.ToString("0.00"));

			MessageBox::Show("已将巡逻方案保存到文件\"1038417-Result3.txt\"");
		}
	private: 
		System::Void button7_Click(System::Object^  sender, System::EventArgs^  e) 
		{
			this->textBox1->Text = "增加隐蔽性后的巡逻方案2：\r\n"
				+ "当警车到达交叉口时，用一定的概率选择一条的道路行进，每条道路被选择的概率由vi值决定，vi值越小被访问的概率越大";

			calc.Patrol2(calc.rCar2, calc.nCar2);
			MessageBox::Show("重点区域平均响应时间: " + calc.A.ToString("0.00") + "（分）\r\n" 
				+ "非重点区域平均响应时间: " + calc.B.ToString("0.00") + "（分）\r\n" 
				+ "道路覆盖率(震慑性): " + calc.Z.ToString("0.00%") + "\r\n"
				+ "重点区域事件被及时处理的概率：" + calc.P1.ToString("0.00%") + "\r\n"
				+ "非重点区域事件被及时处理的概率：" + calc.P2.ToString("0.00%") + "\r\n"
				+ "隐蔽性指标为: " + calc.H.ToString("0.00") + "\r\n"
				+ "经济指标：" + calc.J.ToString("0.00"));
		}

	private: 
		System::Void panel1_MouseMove(System::Object^  sender, System::Windows::Forms::MouseEventArgs^  e) 
		{
			POINT p;
			p.x = ((double)e->X - (double)offset_x) / multiples;
			p.y = ((double)e->Y - (double)offset_y) / -multiples;
			this->toolStripStatusLabel2->Text = "  " + p.x.ToString("0.00") + " " + p.y.ToString("0.00");
		}
	private: 
		System::Void button8_Click(System::Object^  sender, System::EventArgs^  e) 
		{
			this->textBox1->Text = "巡逻方案2：\r\n"
			+ "1.考虑每个区域发生事件的概率不同\r\n"
			+ "2.具体巡逻方案同1";

			calc.Patrol1(calc.rCar2, calc.nCar2);
			MessageBox::Show("重点区域平均响应时间: " + calc.A.ToString("0.00") + "（分）\r\n" 
				+ "非重点区域平均响应时间: " + calc.B.ToString("0.00") + "（分）\r\n" 
				+ "道路覆盖率(震慑性): " + calc.Z.ToString("0.00%") + "\r\n"
				+ "重点区域事件被及时处理的概率：" + calc.P1.ToString("0.00%") + "\r\n"
				+ "非重点区域事件被及时处理的概率：" + calc.P2.ToString("0.00%") + "\r\n"
				+ "隐蔽性指标为: " + calc.H.ToString("0.00") + "\r\n"
				+ "经济指标：" + calc.J.ToString("0.00"));
			MessageBox::Show("已将巡逻方案保存到文件\"1038417-Result3.txt\"");

		}
	private: 
		System::Void button9_Click(System::Object^  sender, System::EventArgs^  e)
		{
			this->textBox1->Text = "增加隐蔽性后的巡逻方案1：\r\n"
				+ "当警车到达交叉口时，用一定的概率选择一条的道路行进，每条道路被选择的概率由vi值决定，vi值越小被访问的概率越大";
			calc.Patrol2(calc.rCar1, calc.nCar1);
			MessageBox::Show("重点区域平均响应时间: " + calc.A.ToString("0.00") + "（分）\r\n" 
				+ "非重点区域平均响应时间: " + calc.B.ToString("0.00") + "（分）\r\n" 
				+ "道路覆盖率(震慑性): " + calc.Z.ToString("0.00%") + "\r\n"
				+ "重点区域事件被及时处理的概率：" + calc.P1.ToString("0.00%") + "\r\n"
				+ "非重点区域事件被及时处理的概率：" + calc.P2.ToString("0.00%") + "\r\n"
				+ "隐蔽性指标为: " + calc.H.ToString("0.00") + "\r\n"
				+ "经济指标：" + calc.J.ToString("0.00"));

		}
	private: 
		System::Void button6_Click(System::Object^  sender, System::EventArgs^  e)
		{
			this->textBox1->Text = "接警后速度为50km/h的巡逻方案\r\n"
				+ "具体方案同增加隐蔽性后的巡逻方案1";
			calc.Patrol3(calc.rCar3, calc.nCar3);
			MessageBox::Show("重点区域平均响应时间: " + calc.A.ToString("0.00") + "（分）\r\n" 
				+ "非重点区域平均响应时间: " + calc.B.ToString("0.00") + "（分）\r\n" 
				+ "道路覆盖率(震慑性): " + calc.Z.ToString("0.00%") + "\r\n"
				+ "重点区域事件被及时处理的概率：" + calc.P1.ToString("0.00%") + "\r\n"
				+ "非重点区域事件被及时处理的概率：" + calc.P2.ToString("0.00%") + "\r\n"
				+ "隐蔽性指标为: " + calc.H.ToString("0.00") + "\r\n"
				+ "经济指标：" + calc.J.ToString("0.00"));
			MessageBox::Show("已将巡逻方案保存到文件\"1038417-Result6.txt\"");
		}
	private: 
		System::Void button4_Click(System::Object^  sender, System::EventArgs^  e) 
		{
			this->textBox1->Text = "10辆车的巡逻方案\r\n";
			calc.Patrol4();
			MessageBox::Show("重点区域平均响应时间: " + calc.A.ToString("0.00") + "（分）\r\n" 
				+ "非重点区域平均响应时间: " + calc.B.ToString("0.00") + "（分）\r\n" 
				+ "道路覆盖率(震慑性): " + calc.Z.ToString("0.00%") + "\r\n"
				+ "重点区域事件被及时处理的概率：" + calc.P1.ToString("0.00%") + "\r\n"
				+ "非重点区域事件被及时处理的概率：" + calc.P2.ToString("0.00%") + "\r\n"
				+ "隐蔽性指标为: " + calc.H.ToString("0.00") + "\r\n"
				+ "经济指标：" + calc.J.ToString("0.00"));
			MessageBox::Show("已将巡逻方案保存到文件\"1038417-Result5.txt\"");
		}
	};
}