using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public class UdpReceiver
    {

        public static bool udp_flag = false;
        public static DateTime udp_time;
        public static bool image_flag = false;
        public static DateTime image_time;

        public static void test()
        {
            //バインドするローカルIPとポート番号
            string localIpString = "0.0.0.0";
            System.Net.IPAddress localAddress =
                System.Net.IPAddress.Parse(localIpString);
            int localPort = 10001;

            //UdpClientを作成し、ローカルエンドポイントにバインドする
            System.Net.IPEndPoint localEP =
                new System.Net.IPEndPoint(localAddress, localPort);
            System.Net.Sockets.UdpClient udp =
                new System.Net.Sockets.UdpClient(localEP);

            for (; ; )
            {
                //データを受信する
                System.Net.IPEndPoint remoteEP = null;
                byte[] rcvBytes = udp.Receive(ref remoteEP);

                //データを文字列に変換する
                string rcvMsg = System.Text.Encoding.UTF8.GetString(rcvBytes);
                UdpReceiver.udp_time = DateTime.Now;
                UdpReceiver.udp_flag = true;
                //"exit"を受信したら終了
                if (rcvMsg.Equals("exit"))
                {
                    break;
                }
            }

            //UdpClientを閉じる
            udp.Close();

            Console.WriteLine("終了しました。");
            Console.ReadLine();
        }
    }

    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            Console.WriteLine("start");
            Task.Run(() =>
            {
                this.timer1_Tick();
            });
            Task.Run(() =>
            {
                UdpReceiver.test();
            });
            Task.Run(() =>
            {
                this.check();            
            });
        }

        private void check()
        {
            using (System.IO.StreamWriter file =
            new System.IO.StreamWriter(@"log.txt", true))
            {
                while (true)
                {
                    System.Threading.Thread.Sleep(1);
                    if (UdpReceiver.udp_flag && UdpReceiver.image_flag)
                    {
                        UdpReceiver.udp_flag = false;
                        UdpReceiver.image_flag = false;
                        long elapsedTicks = UdpReceiver.image_time.Ticks - UdpReceiver.udp_time.Ticks;
                        file.WriteLine("{0:N0}", elapsedTicks * 100);
                        file.Flush();
                    }
                }
            }
        }

        private void timer1_Tick()
        {
            Bitmap myBitmap = new Bitmap(1, 1);
            bool flag = false;

            while (true)
            {
                int X = System.Windows.Forms.Cursor.Position.X;
                int Y = System.Windows.Forms.Cursor.Position.Y;

                Graphics g = Graphics.FromImage(myBitmap);
                g.CopyFromScreen(new Point(X, Y), new Point(0, 0), new Size(1, 1));

                Color _Color = myBitmap.GetPixel(0, 0);

                if (_Color.R > 200 && _Color.G < 30 && _Color.B < 30)
                {
                    if (flag) continue;
                    else
                    {
                        flag = true;
                        UdpReceiver.image_time = DateTime.Now;
                        UdpReceiver.image_flag = true;
                    }

                }
                else
                {
                    flag = false;
                }

                Cursor.Current = Cursors.Default;
            }

        }

    }
}
