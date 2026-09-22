
#include <iostream>
#include <fstream>
#include <cmath>
#include <cstdlib>
#include <sys/timeb.h>
using namespace std;

// type definition
class CPoliceCar{
public:
	void selectpk4();
	void selectpk5();
	void selectpk3();
	CPoliceCar(int i=-1);				// constructor
	void filewrite(ofstream &fout);		// write the present position into file
	void selectpk1();					// appoint fommer 3 car to secure red points
	void move();						// change state
	void checker();						// update the checker array
	int iscross() {return state;}		// 1: at crossroad(also initial value), 0: in the inner part of the road
	int getnum() {return dir[0];}       // return position number, when at crossroad
	void setred(int i) {red = i;}			// appoint this car to secure red points
private:
	int dir[2];							// direction defined by the number of start and end point
	double loclen;						// length travelled in the segment of road
	int state;							// 1: at crossroad(also initial value), 0: in the inner part of the road
	int red;							// 1: control by red, 0: unconstraint
};

// Global variates
int const gMAX = 10000;			 // used for allocate a large memory
int const gpointnum = 307;       // number of point
int const gcarnum = 10;			 // number of cars
int const gexnum = 2074;
int const groadnum = 458;
int const gtotalnum = gpointnum+gexnum;
	
	// Notes: the nearer to 1, the better
double const gpara3 = 0.995;		// used in problem 3 : 0.999

//CPoliceCar gcar[gcarnum] = {12, 112, 260, 146, 58, 195, 24, 276, 29, 20, 116, 210, 285, 111, 202};          // car information
//CPoliceCar gcar[gcarnum] = {12, 112, 260, 146, 58, 195, 24, 276, 29, 20, 116, 210, 285, 111};
//CPoliceCar gcar[gcarnum] = {42, 105, 130, 78, 83, 207, 256, 297, 20, 4, 225, 168, 293, 26, 263, 50, 254, 59}; // solution for problem 1(number begin at 0)
//CPoliceCar gcar[gcarnum] = {42, 105, 130, 78, 83, 207, 256, 297, 20, 4, 225, 168, 293, 26, 263, 50, 254, 59, 58, 195, 24, 276, 29, 20, 116, 210, 285, 111}; // solution for problem 1(number begin at 0)
//CPoliceCar gcar[gcarnum] = {102, 276, 122, 8, 35, 66, 91, 130, 192, 254, 286, 207, 7};
//CPoliceCar gcar[gcarnum] = {42, 104, 130, 78, 83, 207, 256, 284, 20, 140};
CPoliceCar gcar[gcarnum];
int const ginterval = 10;			// time interval
double const gvpatrol = 20./3.6;	// patrol velocity
double tiaode = 150.;
double const gvhelp = 40./3.6*tiaode/120.;		// help velocity
int const grednum = 3;				// number of VIP points
	// neighborhood information
int gnbpos[gpointnum];            // beginning position in the list of neighborhood
int gnepos[gpointnum];            // terminal position in the list of neighborhood 
int gnlist[gMAX];                 // list of neighborhood information

int gnbpos2[gpointnum];
int gnepos2[gpointnum];
int gnlist2[5*1024*1024];

	// map information
int gcrpos[gpointnum][2];           // position of cross roads
int gadj[gpointnum][gpointnum];     // adjacent relation
double gdist[gpointnum][gpointnum]; // distances between every pair 

double gdist2[gexnum][gpointnum]; // distances between crossroads and new points

int groad[groadnum][4];

	// recording (potential value for valuating index)
int gerrnum = 0;
int gnumpatrol[gtotalnum];          // number of patrols for each point
int gpopulation[gpointnum];         // density of population
double gcrate;                      // present cover rate
int gchecker[gtotalnum];            // 1 to indicate there is a car near, 0 is the oposite
int gchecker_old[gtotalnum];
int gred[grednum] = {0, 0, 0};      // number of cars can cover the ith VIP point (1st(5112,4806), 2nd(9126,4266), 3rd(7434,1332))
int gred_old[grednum] = {0, 0, 0};
int gredneighbor[grednum][gpointnum];

void init_infor(); // initial information (initial car position, neighborhood information, map information, recording(zero))
double cal_crate();
void check_old(int num);
void init_carpos(int num); // give random position 
int rnd(int n=1000);       // uniform (0, n) random variate 
void init_redn();          // initialize the red neighborhood
void Dijkstra(int k, double weight[310][310]);

int ptime = 0;
int totaltime = 4*60*60;
int main()
{
	int i;	

	ofstream f1("carpos.txt"), f2("cover_rate.txt"), f3("patrol_effect.txt");
	init_infor();
	while (ptime <= totaltime) {
		if (ptime%60 == 0)
			f1 << ptime/60;
		
		for (i=0; i<gcarnum; ++i) {
			gcar[i].checker();
			if (ptime%60 == 0)
				gcar[i].filewrite(f1);
			if (gcar[i].iscross() == 1) {
				check_old(i);
				gcar[i].selectpk5();
			}
		}
		gcrate = cal_crate();
				
		f2 << gcrate << "\n";
		for (i=0; i<gcarnum; ++i) {
			gcar[i].move();
		}
		ptime += ginterval;
		if (ptime%60 == 0)
			f1 << endl;
		memset(gchecker, 0, sizeof(gchecker));
	}
	for (i=0; i<gtotalnum; ++i) {
		f3 << gnumpatrol[i] << "\n";
	}
//	cout << endl << gerrnum << endl;
	f1.close();
	f2.close();
	f3.close(); 

	return 0;
}

// realization of functions
void init_infor()
{
	int i, j, k;
	int temp;

	//initial the neighborhood of red points
	init_redn();
	
	// initial random car position
	init_carpos(gcarnum);

	// initial condition of red points
	for (i=0; i<gcarnum; ++i) {
		for (j=0; j<grednum; ++j) {
			temp = gredneighbor[j][0];
			for (k=1; k<=temp; ++k) {
				if (gredneighbor[j][k] == gcar[i].getnum()) {
					gred[j] += 1;
				}
			}
		}
	}
	// road information
	ifstream fin("road.txt");
	for (i=0; i<groadnum; ++i) 
		fin >> groad[i][0] >> groad[i][1] >> groad[i][2] >> groad[i][3];
	fin.close();
	// population information
	fin.open("poplation.txt");
	for (i=0; i<gpointnum; ++i) {
		fin >> gpopulation[i];
	}
	fin.close();
	// neighborhood information
	ifstream fin1("c1.txt"), fin2("c2.txt"), fin3("linyu.txt");
	for (i=0; i<gpointnum; ++i) {
		fin1 >> gnbpos[i];
		gnbpos[i] -= 1;
		fin2 >> gnepos[i];
		gnepos[i] -= 1;
	}

	fin1.close();
	fin2.close();
	for (i=0; i<=gnepos[gpointnum-1]; ++i) {               
		fin3 >> gnlist[i];
		gnlist[i] -= 1;									
	}
	fin3.close();

	fin1.open("n_c1_0.txt");
	fin2.open("n_c2_0.txt");
	fin3.open("n_linyu_0.txt");

	for (i=0; i<gpointnum; ++i) {
		fin1 >> gnbpos2[i];
		fin2 >> gnepos2[i];
	}

	fin1.close();
	fin2.close();
	for (i=0; i<=gnepos2[gpointnum-1]; ++i) {               
		fin3 >> gnlist2[i];
	}
	fin3.close();


	// map information
	fin1.open("jiaochakou.txt");
	fin2.open("adj.txt");
	fin3.open("dist.txt");
	for (i=0; i<gpointnum; ++i) {
		fin1 >> gcrpos[i][0] >> gcrpos[i][1];
	}
	for (i=0; i<gpointnum; ++i) {
		for (j=0; j<gpointnum; ++j) {
			fin2 >> gadj[i][j];
			fin3 >> gdist[i][j];
		}
	}
	fin1.close();
	fin2.close();
	fin3.close();
	fin.open("new_dist.txt");
	for (i=0; i<gexnum; ++i) {
		for (j=0; j<gpointnum; ++j) {
			fin >> gdist2[i][j];
		}
	}
	fin.close();
	// recording
	for (i=0; i<gtotalnum; ++i) {
		gnumpatrol[i] = 0;
	}
	gcrate = 0.;
	// car information
		// set by hand
/*	gcar[0].setred(0);
	gcar[1].setred(1);
	gcar[2].setred(2);
*/
		// set automatically
	for (i=0; i<grednum; ++i) {
		temp = gredneighbor[i][0];
		for (j=0; j<gcarnum; ++j) {
			for (k=1; k<=temp; ++k) {
				if (gredneighbor[i][k] == gcar[j].getnum()) {
					gcar[j].setred(i);
					k = -1;
					break;
				}
			}
			if (k == -1)
				break;
		}
		if (k != -1) {
			cout << "Err: No." << i+1 << " is not secured!\n";
			exit(1);
		}
	}
}

double cal_crate()
{
	int i, count=0;
	double res;
	for (i=0; i<gtotalnum; ++i) {
		if (gchecker[i] > 0)
			count++;
	}
	res = (double)count/(gtotalnum);
	return res;
}

// realization of class CPoliceCar
CPoliceCar::CPoliceCar(int i)
{
//	dir[0] = dir[1] = i-1;
	dir[0] = dir[1] = i;
	loclen = 0.;
	state = 1;
	red = -1;
}

void CPoliceCar::move()
{
	// move a step
	double step = ginterval*gvpatrol;
	loclen += step;
	if (fabs(loclen-gdist[dir[0]][dir[1]]) < .5*step) {
		loclen = 0;
		dir[0] = dir[1];
		state = 1;
	}
}

void CPoliceCar::filewrite(ofstream &fout)
{
	double c;
	if (state == 0) {
		c = loclen/gdist[dir[0]][dir[1]];
	}
	else
		c = 0.;
	fout << ",(" << int(gcrpos[dir[0]][0]+(gcrpos[dir[1]][0]-gcrpos[dir[0]][0])*c) << "," << int(gcrpos[dir[0]][1]+(gcrpos[dir[1]][1]-gcrpos[dir[0]][1])*c) << ")";
}

void CPoliceCar::checker()
{
	int i, j;
	double radius = gvhelp*180.;
	for (i=gnbpos[dir[0]]; i<=gnepos[dir[0]]; ++i) {
		j = gnlist[i];
		if ((gdist[j][dir[0]]+loclen <= radius) || (gdist[j][dir[1]]+gdist[dir[0]][dir[1]]-loclen <= radius)) {
			gchecker[j] = 1;
		}
	}
	for (i=gnbpos[dir[1]]; i<=gnepos[dir[1]]; ++i) {
		j = gnlist[i];
		if ((gdist[j][dir[0]]+loclen <= radius) || (gdist[j][dir[1]]+gdist[dir[0]][dir[1]]-loclen <= radius)) {
			gchecker[j] = 1;
		}
	}

	for (i=gnbpos2[dir[0]]; i<=gnepos2[dir[0]]; ++i) {
		j = gnlist2[i];
		if ((gdist2[j][dir[0]]+loclen <= radius) || (gdist2[j][dir[1]]+gdist[dir[0]][dir[1]]-loclen <= radius)) {
			gchecker[j+gpointnum] = 1;
		}
	}
	for (i=gnbpos2[dir[1]]; i<=gnepos2[dir[1]]; ++i) {
		j = gnlist2[i];
		if ((gdist2[j][dir[0]]+loclen <= radius) || (gdist2[j][dir[1]]+gdist[dir[0]][dir[1]]-loclen <= radius)) {
			gchecker[j+gpointnum] = 1;
		}
	}
}

void check_old(int num)
{
	int i, j, k, temp;
	int temp_checker[gtotalnum]; // recording the original gchecker[]

	for (i=0; i<gtotalnum; ++i)
		temp_checker[i] = gchecker[i];
	
	memset(gchecker_old, 0, sizeof(gchecker_old));	
	memset(gred_old, 0, sizeof(gred_old));	

	memset(gchecker, 0, sizeof(gchecker));

	for (i=0; i<gcarnum; ++i) {
		if (i == num) continue;
		gcar[i].checker();
	}
	// compute gchecker_old[]
	for (i=0; i<gtotalnum; ++i) {
		gchecker_old[i] = gchecker[i];
		gchecker[i] = temp_checker[i];
	}
	// compute gred_old[]
	for (i=0; i<gcarnum; ++i) {
		if (i == num) continue;
		for (j=0; j<grednum; ++j) {
			temp = gredneighbor[j][0];
			for (k=1; k<=temp; ++k) {
				if (gredneighbor[j][k] == gcar[i].getnum()) {
					gred_old[j] += 1;
				}
			}
		}
	}
}

void CPoliceCar::selectpk1()
{
	// Update: gnumpatrol[]
	int i, j, tt, k;
	gnumpatrol[dir[0]] += 1; 

	// Find next point
		// Red points
	int connect[2][10];				// record adjacent point number
	int temp_checker[gtotalnum];
	for (i=0; i<gtotalnum; ++i) 
		temp_checker[i] = gchecker_old[i];

	for (i=0; i<10; ++i) {
		connect[1][i] = 1;
	}
	// adjacent constraint
	int count=0;
	for (i=0; i<gpointnum; ++i) {
		if (gadj[dir[0]][i] == 1) {			//?? wait to improve ?????????????
			connect[0][count] = i;
			count++;
		}
	}
	// red point constraint
	if (red != -1) {
		tt = gredneighbor[red][0];
		for (i=0; i<count; ++i) {
			for (j=1; j<=tt; ++j) {
				if (gredneighbor[red][j] == connect[0][i]) {
					j = -1;
					break;
				}
			}
			if (j != -1) {
				connect[1][i] = 0;
			}
		}
	}
	// maximal cover rate
	double rate, media=-1.;
	int pos=-1;
	int hh;
	for (k=0; k<count; ++k) {
		if (connect[1][k]==1) {
			hh = connect[0][k];
			for (i=gnbpos[hh]; i<=gnepos[hh]; ++i) {
				temp_checker[gnlist[i]] = 1;
			}
			for (i=gnbpos2[hh]; i<=gnepos2[hh]; ++i) {
				temp_checker[gnlist2[i]+gpointnum] = 1;
			}
			rate = 0.;
			for (i=0; i<gtotalnum; ++i) {
				if (temp_checker[i] == 1)
					rate += 1.;
			}
			rate = rate/(gtotalnum);
			if (rate > media) {
				media = rate;
				pos = k;
			}

			for (i=0; i<gtotalnum; ++i) 
				temp_checker[i] = gchecker_old[i];
		}
	}
	if (pos == -1) {
		cout << "Impossible!\n" << ptime << endl << red << endl;
		exit(1);
	}
	dir[1] = connect[0][pos];
	state = 0;
	// update the patrol rate inside the road
	for (i=0; i<groadnum; ++i) {
		if (((groad[i][0] == dir[0]) && (groad[i][1] == dir[1])) 
			|| ((groad[i][0] == dir[1]) && (groad[i][1] == dir[0]))) {
			for (j=groad[i][2]; j<groad[i][3]; ++j) {
				gnumpatrol[j+gpointnum] += 1;
			}
		}
	}
}

void CPoliceCar::selectpk3()
{
	// Update: gnumpatrol[]
	int i, j, tt, k;
	gnumpatrol[dir[0]] += 1; 
	double ratearray[10];

	// Find next point
		// Red points
	int connect[2][10];				// record adjacent point number
	int temp_checker[gtotalnum];
	for (i=0; i<gtotalnum; ++i) 
		temp_checker[i] = gchecker_old[i];

	for (i=0; i<10; ++i) {
		connect[1][i] = 1;
	}
	// adjacent constraint
	int count=0;
	for (i=0; i<gpointnum; ++i) {
		if (gadj[dir[0]][i] == 1) {			//?? wait to improve ?????????????
			connect[0][count] = i;
			count++;
		}
	}
	// red point constraint
	if (red != -1) {
		tt = gredneighbor[red][0];
		for (i=0; i<count; ++i) {
			for (j=1; j<=tt; ++j) {
				if (gredneighbor[red][j] == connect[0][i]) {
					j = -1;
					break;
				}
			}
			if (j != -1) {
				connect[1][i] = 0;
			}
		}
	}
	// cover rate constraint
	double rate, rate0;
	int hh;
		// calculate rate0
	hh = dir[0];
	for (i=gnbpos[hh]; i<=gnepos[hh]; ++i) {
		temp_checker[gnlist[i]] = 1;
	}
	for (i=gnbpos2[hh]; i<=gnepos2[hh]; ++i) {
		temp_checker[gnlist2[i]+gpointnum] = 1;
	}
	rate = 0.;
	for (i=0; i<gtotalnum; ++i) {
		if (temp_checker[i] == 1)
			rate += 1.;
	}
	rate0 = rate/gtotalnum;
	for (i=0; i<gtotalnum; ++i) 
		temp_checker[i] = gchecker_old[i];

		// calculate ratearray[]
	for (k=0; k<count; ++k) {
		hh = connect[0][k];
		for (i=gnbpos[hh]; i<=gnepos[hh]; ++i) {
			temp_checker[gnlist[i]] = 1;
		}
		for (i=gnbpos2[hh]; i<=gnepos2[hh]; ++i) {
			temp_checker[gnlist2[i]+gpointnum] = 1;
		}
		rate = 0.;
		for (i=0; i<gtotalnum; ++i) {
			if (temp_checker[i] == 1)
				rate += 1.;
		}
		rate = rate/gtotalnum;
		ratearray[k] = rate;
		for (i=0; i<gtotalnum; ++i) 
			temp_checker[i] = gchecker_old[i];
	}
	// maximal optional value
	double media = -9.2559631349318e+061, optv;
	double res;
	int pos = -1;
	for (k=0; k<count; ++k) {
		if ((connect[1][k] == 1) && (ratearray[k]-0.9 >= -1e-3)) {
			// absolute value
//			res = ((double)gnumpatrol[connect[0][k]])/gpopulation[connect[0][k]];
//			optv = gpara3*ratearray[k]-(1-gpara3)*(double(ptime)/totaltime)*res;
//			optv = exp(gpara3*ratearray[k]-(1-gpara3)*(double(ptime)/totaltime)*res);
			// relative value
			res = ((double)gnumpatrol[connect[0][k]]*gpopulation[dir[0]])/(gpopulation[connect[0][k]]*(double)gnumpatrol[dir[0]]);
			optv = gpara3*ratearray[k]/rate0-(1-gpara3)*(double(ptime)/totaltime)*res;
			// 3rd kind of index
//			res = ((double)gnumpatrol[connect[0][k]]*gpopulation[dir[0]])/(gpopulation[connect[0][k]]*(double)gnumpatrol[dir[0]]);
//			optv = gpara3*log(ratearray[k])/log(rate0)-(1-gpara3)*(double(ptime)/totaltime)*res;
			// 4th kind of index
//			res = ((double)gnumpatrol[connect[0][k]]*gpopulation[dir[0]])/(gpopulation[connect[0][k]]*(double)gnumpatrol[dir[0]]);
//			optv = gpara3*log(ratearray[k]/rate0)-(1-gpara3)*(double(ptime)/totaltime)*res;
			if (optv > media) {
				media = optv;
				pos = k;
			}
		}
	}
	if (pos == -1) {
		gerrnum++;
		media = -9.2559631349318e+061;
		pos = -1;
		for (k=0; k<count; ++k) {
			if ((connect[1][k] == 1) && (ratearray[k] > media)) {
				media = optv;
				pos = k;
			}
		}
	}
	dir[1] = connect[0][pos];
	state = 0;
	// update the patrol rate inside the road
	for (i=0; i<groadnum; ++i) {
		if (((groad[i][0] == dir[0]) && (groad[i][1] == dir[1])) 
			|| ((groad[i][0] == dir[1]) && (groad[i][1] == dir[0]))) {
			for (j=groad[i][2]; j<groad[i][3]; ++j) {
				gnumpatrol[j+gpointnum] += 1;
			}
		}
	}
}

void CPoliceCar::selectpk5()	// Problem 5
{
	// Update: gnumpatrol[]
	int i, j, tt, k;
	gnumpatrol[dir[0]] += 1; 
	double ratearray[10];

	// Find next point
		// Red points
	int connect[2][10];				// record adjacent point number
	int temp_checker[gtotalnum];
	for (i=0; i<gtotalnum; ++i) 
		temp_checker[i] = gchecker_old[i];

	for (i=0; i<10; ++i) {
		connect[1][i] = 1;
	}
	// adjacent constraint
	int count=0;
	for (i=0; i<gpointnum; ++i) {
		if (gadj[dir[0]][i] == 1) {	
			connect[0][count] = i;
			count++;
		}
	}
	// red point constraint
	if (red != -1) {
		tt = gredneighbor[red][0];
		for (i=0; i<count; ++i) {
			for (j=1; j<=tt; ++j) {
				if (gredneighbor[red][j] == connect[0][i]) {
					j = -1;
					break;
				}
			}
			if (j != -1) {
				connect[1][i] = 0;
			}
		}
	}
	// cover rate constraint
	double rate, rate0;
	int hh;
		// calculate rate0
	hh = dir[0];
	for (i=gnbpos[hh]; i<=gnepos[hh]; ++i) {
		temp_checker[gnlist[i]] = 1;
	}
	for (i=gnbpos2[hh]; i<=gnepos2[hh]; ++i) {
		temp_checker[gnlist2[i]+gpointnum] = 1;
	}
	rate = 0.;
	for (i=0; i<gtotalnum; ++i) {
		if (temp_checker[i] == 1)
			rate += 1.;
	}
	rate0 = rate/gtotalnum;
	for (i=0; i<gtotalnum; ++i) 
		temp_checker[i] = gchecker_old[i];

		// calculate ratearray[]
	for (k=0; k<count; ++k) {
		hh = connect[0][k];
		for (i=gnbpos[hh]; i<=gnepos[hh]; ++i) {
			temp_checker[gnlist[i]] = 1;
		}
		for (i=gnbpos2[hh]; i<=gnepos2[hh]; ++i) {
			temp_checker[gnlist2[i]+gpointnum] = 1;
		}
		rate = 0.;
		for (i=0; i<gtotalnum; ++i) {
			if (temp_checker[i] == 1)
				rate += 1.;
		}
		rate = rate/gtotalnum;
		ratearray[k] = rate;
		for (i=0; i<gtotalnum; ++i) 
			temp_checker[i] = gchecker_old[i];
	}
	// maximal optional value
	double media = -9.2559631349318e+061, optv;
	double res;
	int pos = -1;
	for (k=0; k<count; ++k) {
		if (connect[1][k] == 1) {
			// absolute value
//			res = ((double)gnumpatrol[connect[0][k]])/gpopulation[connect[0][k]];
//			optv = gpara3*ratearray[k]-(1-gpara3)*(double(ptime)/totaltime)*res;
//			optv = exp(gpara3*ratearray[k]-(1-gpara3)*(double(ptime)/totaltime)*res);
			// relative value
			res = ((double)gnumpatrol[connect[0][k]]*gpopulation[dir[0]])/(gpopulation[connect[0][k]]*(double)gnumpatrol[dir[0]]);
			optv = gpara3*ratearray[k]/rate0-(1-gpara3)*(double(ptime)/totaltime)*res;
			// 3rd kind of index
//			res = ((double)gnumpatrol[connect[0][k]]*gpopulation[dir[0]])/(gpopulation[connect[0][k]]*(double)gnumpatrol[dir[0]]);
//			optv = gpara3*log(ratearray[k])/log(rate0)-(1-gpara3)*(double(ptime)/totaltime)*res;
			// 4th kind of index
//			res = ((double)gnumpatrol[connect[0][k]]*gpopulation[dir[0]])/(gpopulation[connect[0][k]]*(double)gnumpatrol[dir[0]]);
//			optv = gpara3*log(ratearray[k]/rate0)-(1-gpara3)*(double(ptime)/totaltime)*res;
			if (optv > media) {
				media = optv;
				pos = k;
			}
		}
	}
	if (pos == -1) {
		cout << ptime << "Impossible!\n";
		exit(0);
	}
	dir[1] = connect[0][pos];
	state = 0;
	// update the patrol rate inside the road
	for (i=0; i<groadnum; ++i) {
		if (((groad[i][0] == dir[0]) && (groad[i][1] == dir[1])) 
			|| ((groad[i][0] == dir[1]) && (groad[i][1] == dir[0]))) {
			for (j=groad[i][2]; j<groad[i][3]; ++j) {
				gnumpatrol[j+gpointnum] += 1;
			}
		}
	}
}

void init_carpos(int num)
{
	if (num < 3) {
		cout << "Err: Too small!\n";
		exit(0);
	}
	int *p = new int [num];
	timeb ptime;
	int res, i, j;
	for (i=0; i<num; ++i) {
		while (1) {
			ftime(&ptime);	
			srand(ptime.millitm);
			if (i<3) {
				res = rand()%gredneighbor[i][0]+1;
				p[i] = gredneighbor[i][res];
				break;
			}
			else
				res = rand()%gpointnum;
			for (j=0; j<i; ++j) {
				if (p[j] == res) {
					j = -1;
					break;
				}
			}
			if (j != -1) {
				p[i] = res;
				break;
			}
		}
	}
	for (i=0; i<num; ++i)
		gcar[i] = CPoliceCar(p[i]);
	delete []p;
}

void CPoliceCar::selectpk4() // Problem 4
{
	// Update: gnumpatrol[]
	int i, j, tt, k;
	gnumpatrol[dir[0]] += 1; 
	double ratearray[10];
	double rank[10];

	// Find next point
		// Red points
	int connect[2][10];				// record adjacent point number
	int temp_checker[gtotalnum];
	for (i=0; i<gtotalnum; ++i) 
		temp_checker[i] = gchecker_old[i];

	for (i=0; i<10; ++i) {
		connect[1][i] = 1;
	}
	// adjacent constraint
	int count=0;
	for (i=0; i<gpointnum; ++i) {
		if (gadj[dir[0]][i] == 1) {			//?? wait to improve ?????????????
			connect[0][count] = i;
			count++;
		}
	}
	// red point constraint
	if (red != -1) {
		tt = gredneighbor[red][0];
		for (i=0; i<count; ++i) {
			for (j=1; j<=tt; ++j) {
				if (gredneighbor[red][j] == connect[0][i]) {
					j = -1;
					break;
				}
			}
			if (j != -1) {
				connect[1][i] = 0;
			}
		}
	}
	// cover rate constraint
	double rate, rate0;
	int hh;
		// calculate rate0
	hh = dir[0];
	for (i=gnbpos[hh]; i<=gnepos[hh]; ++i) {
		temp_checker[gnlist[i]] = 1;
	}
	for (i=gnbpos2[hh]; i<=gnepos2[hh]; ++i) {
		temp_checker[gnlist2[i]+gpointnum] = 1;
	}
	rate = 0.;
	for (i=0; i<gtotalnum; ++i) {
		if (temp_checker[i] == 1)
			rate += 1.;
	}
	rate0 = rate/gtotalnum;
	for (i=0; i<gtotalnum; ++i) 
		temp_checker[i] = gchecker_old[i];

		// calculate ratearray[]
	for (k=0; k<count; ++k) {
		hh = connect[0][k];
		for (i=gnbpos[hh]; i<=gnepos[hh]; ++i) {
			temp_checker[gnlist[i]] = 1;
		}
		for (i=gnbpos2[hh]; i<=gnepos2[hh]; ++i) {
			temp_checker[gnlist2[i]+gpointnum] = 1;
		}
		rate = 0.;
		for (i=0; i<gtotalnum; ++i) {
			if (temp_checker[i] == 1)
				rate += 1.;
		}
		rate = rate/gtotalnum;
		ratearray[k] = rate;
		for (i=0; i<gtotalnum; ++i) 
			temp_checker[i] = gchecker_old[i];
	}
	// maximal optional value
	double res, optv, media;
	int pos;
	optv = 0.;
	for (k=0; k<count; ++k) {
		if ((connect[1][k] == 1) && (ratearray[k]-0.9 >= -1e-3)) {
			// absolute value
//			res = ((double)gnumpatrol[connect[0][k]])/gpopulation[connect[0][k]];
//			rank[k] = exp(gpara3*ratearray[k]-(1-gpara3)*(double(ptime)/totaltime)*res);   ///////////////?????????????????????
			// relative value
			res = ((double)gnumpatrol[connect[0][k]]*gpopulation[dir[0]])/(gpopulation[connect[0][k]]*(double)gnumpatrol[dir[0]]);
			rank[k] = exp(gpara3*ratearray[k]/rate0-(1-gpara3)*(double(ptime)/totaltime)*res);
			// 3rd kind of index
//			res = ((double)gnumpatrol[connect[0][k]]*gpopulation[dir[0]])/(gpopulation[connect[0][k]]*(double)gnumpatrol[dir[0]]);
//			rank[k] = exp(gpara3*log(ratearray[k])/log(rate0)-(1-gpara3)*(double(ptime)/totaltime)*res);
			// 4th kind of index
//			res = ((double)gnumpatrol[connect[0][k]]*gpopulation[dir[0]])/(gpopulation[connect[0][k]]*(double)gnumpatrol[dir[0]]);
//			rank[k] = exp(gpara3*log(ratearray[k]/rate0)-(1-gpara3)*(double(ptime)/totaltime)*res);
			optv += rank[k];
		}
	}
	if (fabs(optv) <= 1e-5) {
		gerrnum++;
		media = -9.2559631349318e+061;
		pos = -1;
		for (k=0; k<count; ++k) {
			if ((connect[1][k] == 1) && (ratearray[k] > media)) {
				media = ratearray[k];
				pos = k;
			}
		}
	}
	else {
		res = 0.;
		for (k=0; k<count; ++k) {
			if ((connect[1][k] == 1) && (ratearray[k]-0.9 >= -1e-3)) {
				rank[k] = rank[k]/optv;
				res += rank[k];
				rank[k] = res;
			}
		}
		optv = rnd(1000)/1000.;
		for (k=count-1; k>=0; --k) {
			if ((connect[1][k] == 1) && (ratearray[k]-0.9 >= -1e-3) && (rank[k] >= optv)) {
				pos = k;
			}
		}
	}

	dir[1] = connect[0][pos];
	state = 0;
	// update the patrol rate inside the road
	for (i=0; i<groadnum; ++i) {
		if (((groad[i][0] == dir[0]) && (groad[i][1] == dir[1])) 
			|| ((groad[i][0] == dir[1]) && (groad[i][1] == dir[0]))) {
			for (j=groad[i][2]; j<groad[i][3]; ++j) {
				gnumpatrol[j+gpointnum] += 1;
			}
		}
	}
}

int rnd(int n)
{
	timeb ptime;
	ftime(&ptime);
	static int last = ptime.millitm;
	srand(last);
	last = rand()%n+1;

	return last;
}

void init_redn()
{
	int cross[310][2];
	double weight[310][310];
	const double INF = 858993460;
	int i, j, k, ploc;
	double distance, plen;
	cross[307][0] = 5112; cross[307][1] = 4806;
	cross[308][0] = 9126; cross[308][1] = 4266;
	cross[309][0] = 7434; cross[309][1] = 1332;
	for (i=0; i<310; ++i) {
		weight[i][i] = 0.;
		for (j=i+1; j<310; ++j)
			weight[i][j] = INF;
	}
	ifstream fin("jiaochakou2.txt");
	for (i=0; i<307; ++i)
		fin >> cross[i][0] >> cross[i][1];
	fin.close();
	
	fin.open("daolu2.txt");
	for (i=0; i<458; ++i) {
		fin >> j; fin >> k;
		weight[j-1][k-1] = sqrt(double((cross[j-1][0]-cross[k-1][0])*(cross[j-1][0]-cross[k-1][0])+(cross[j-1][1]-cross[k-1][1])*(cross[j-1][1]-cross[k-1][1])));
	}

	for (i=307; i<310; ++i) {
		plen = INF;
		ploc = -1;
		for (j=0; j<307; ++j) {
			distance = sqrt(double((cross[j][0]-cross[i][0])*(cross[j][0]-cross[i][0])+(cross[j][1]-cross[i][1])*(cross[j][1]-cross[i][1])));
			if (distance < plen) {
				plen = distance;
				ploc = j;
			}
		}
		weight[ploc][i] = plen;
	}
	for (i=0; i<310; ++i)
		for (j=0; j<i; ++j)
			weight[i][j] = weight[j][i];
	fin.close();
	for (i=307; i<310; ++i) {
		Dijkstra(i, weight);
	}
}

void Dijkstra(int k, double weight[310][310])
{
	const double INF = 858993460;
	struct node
	{
		node* p;
		double len;
		int num;
		bool s;
	};
	struct node city[310];
	double min;
	int i, j, minloc, step=0;
	for (i=0; i<310; ++i) {
		city[i].p = NULL;
		city[i].len = INF;
		city[i].s = false;
		city[i].num = i+1;
	}
	city[k].len = 0;
	city[k].s = 1;
	while(step < 309) {
		for (i=0; i<310; ++i) {
			if (city[i].s == false) {
				for (j=0; j<310; ++j) {
					if ((city[j].len + weight[j][i] < city[i].len) && (city[j].s == true)) {
						city[i].len = city[j].len + weight[j][i];
						city[i].p = &city[j];
					}
				}
			}
		}
		min = INF;
		for (i=0; i<310; ++i)
		{
			if (city[i].s == false && city[i].len < min) {
				min = city[i].len;
				minloc = i;
			}
		}
		city[minloc].s = true;
		step++;
	}//end of while
	int cc = 0;
	for (i=0; i<310; ++i) {	
		if ((i != k) && (city[i].len < 2*60*gvhelp)) {
			cc++;
			gredneighbor[k-307][cc] = city[i].num-1;
		}
	}
	gredneighbor[k-307][0] = cc;
}
