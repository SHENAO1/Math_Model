#pragma once

struct MouseControl
	{
		/// <summary>
		/// 鼠标控制参数
		/// </summary>
		const int MOUSEEVENTF_LEFTDOWN = 0x2;
		const int MOUSEEVENTF_LEFTUP = 0x4;
		const int MOUSEEVENTF_MIDDLEDOWN = 0x20;
		const int MOUSEEVENTF_MIDDLEUP = 0x40;
		const int MOUSEEVENTF_MOVE = 0x1;
		const int MOUSEEVENTF_ABSOLUTE = 0x8000;
		const int MOUSEEVENTF_RIGHTDOWN = 0x8;
		const int MOUSEEVENTF_RIGHTUP = 0x10;

		/// <summary>
		/// 鼠标的位置
		/// </summary>
		private struct PONITAPI
		{
			public int x, y;
		}

		[DllImport("user32.dll")]
		private static extern int GetCursorPos(ref PONITAPI p);

		[DllImport("user32.dll")]
		private static extern int SetCursorPos(int x, int y);

		[DllImport("user32.dll")]
		private static extern int mouse_event(int dwFlags, int dx, int dy, int cButtons, int dwExtraInfo);

		public void move(int x, int y)
		{
			PONITAPI p = new PONITAPI();

			p.x = x; 
			p.y = y;

			SetCursorPos(p.x, p.y);
		}

		public void click()
		{
			PONITAPI p = new PONITAPI();
			GetCursorPos(ref p);
			mouse_event(MOUSEEVENTF_LEFTDOWN, p.x, p.y, 0, 0);
			mouse_event(MOUSEEVENTF_LEFTUP, p.x, p.y, 0, 0);
		}
	}