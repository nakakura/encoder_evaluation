#set terminal qt
set datafile separator ","
set encoding utf8
set key right bottom
set key R
set yrang [0:1.05]
set terminal eps enhanced color font "IPAexMincho,14" size 5.0, 6.0
set output "cdf.eps"
set xtics ("0" 0, "10" 10, "20" 20, "30" 30, "40" 40, "50" 50, "60" 60, "70" 70)
set xrange [0:70]
set bmargin 3
set xlabel "処理時間(ms)"
set ylabel "CDF(x)"
plot  	"cdf.csv" u 1:(1./100.) smooth cumulative with lp dt (20,10) pt 1 lw 2 ps 0.5 lc 7 title "x264-avdec", \
	"cdf.csv" u 2:(1./100.) smooth cumulative with lp dt (20,10) pt 1 lw 2 ps 0.5 lc 4 title "oh264-avdec", \
	"cdf.csv" u 3:(1./100.) smooth cumulative with lp dt (30,10,5,10) pt 2 lw 2 ps 0.5 lc 4 title "oh264-oh264", \
      	"cdf.csv" u 4:(1./100.) smooth cumulative with lp pt 7 lw 2 ps 0.5 lc 4 title "oh264-nvh264", \
	"cdf.csv" u 5:(1./100.) smooth cumulative with lp dt (20,10) pt 1 lw 2 ps 0.5 lc 17 title "oh264(no op)-avdec", \
	"cdf.csv" u 6:(1./100.) smooth cumulative with lp dt (20,10) pt 1 lw 2 ps 0.5 lc 6 title "nvh264(ps3)-avdec", \
	"cdf.csv" u 7:(1./100.) smooth cumulative with lp pt 7 lw 2 ps 0.5 lc 6 title "nvh264(ps3)-nvh264", \
      	"cdf.csv" u 8:(1./100.) smooth cumulative with lp pt 6 lw 2 ps 0.5 lc 3 title "nvh264(ps5)-nvh264", \
	"cdf.csv" u 9:(1./100.) smooth cumulative with lp pt 5 lw 2 ps 0.5 lc 2 title "nvh265(ps3)-nvh265", \
	"cdf.csv" u 10:(1./100.) smooth cumulative with lp pt 4 lw 2 ps 0.5 lc 10 title "nvh265(ps5)-nvh265", \
