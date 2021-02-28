#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#define amp_sz 1000
#define amp_min 0.7
#define amp_max 1.3

#define phi_min 0.0
#define phi_max 1.0/8.0
#define phi_sz  1000

#define n_sz 16

#define valmin -1.0
#define valmax 0.9921875

typedef double (*funct_cvt)(double);
typedef double (*funct_sig)(double,double,int);
void d_linspace(double* arr, int sz, double vmin,double vmax){
    double inc=(vmax-vmin)/(sz*1.0);
    for(int i=0;i<sz;++i){
        arr[i]=vmin+i*inc;
    }
}
double snr(double a,double phi,funct_cvt pf_cvt,funct_sig pf_sig){
    double ssig[n_sz];
    for(int i=0;i<n_sz;++i){
        ssig[i]=pf_sig(a,phi,i);
    }
    double poww=0;
    double snrr=0;
    for(int i=0;i<n_sz;++i){
        poww+=ssig[i]*ssig[i];
        double tmp=(ssig[i]-pf_cvt(ssig[i]));
        snrr+=tmp*tmp;
    }
    
    return poww/snrr;
}

double sym(double a,double phi,funct_cvt pf_cvt,funct_sig pf_sig){
    double ssig[n_sz];
    for(int i=0;i<n_sz;++i){
        ssig[i]=pf_cvt(pf_sig(a,phi,i));
    }
    double sum=0;
    for(int i=0;i<n_sz;++i){
        sum+=ssig[i];
    }
    return (16.0-abs(sum));
}

static double f_cos(double a,double phi,int n){
    return (a*cos((n*1.0)*M_PI_4/2.0+phi*M_PI));
}
static double f_saw(double a,double phi,int n){
    return a*(1.0-phi-n*0.125);
}
static double quant_floor(double val){
    double ret=floor(val*pow(2.0,7.0))/pow(2.0,7.0);
    return (
        ret<valmin
        ?   valmin
        :   ret>valmax
            ?   valmax
            :   ret
    );
}
static double quant_ceil(double val){
    double ret=ceil(val*pow(2.0,7.0))/pow(2.0,7.0);
    return (
        ret<valmin
        ?   valmin
        :   ret>valmax
            ?   valmax
            :   ret
    );
}
typedef struct{
    double amp;
    double phi;
    double vsnr;
    int ind_win;
} t_result;

static const char* quant_name[2]={"floor","ceil"};

int main( int argc , char** argv ){

    double amp  [amp_sz];
    double phi  [phi_sz];

    d_linspace( amp, amp_sz, amp_min, amp_max );
    d_linspace( phi, phi_sz, phi_min, phi_max );

    t_result    res[2];
    funct_cvt   tcvt[2] ={/*quant_ceil,*/quant_floor};
    funct_sig   tsig[2] ={f_cos,f_saw};
    
    for(                int sig     = 0   ;  sig     < 2       ;  ++sig      ){
        res[sig].vsnr=0.0;
        for(            int quant   = 0   ;  quant   < 1       ;  ++quant    ){
            for(        int ind_amp = 0   ;  ind_amp < amp_sz  ;  ++ind_amp  ){
                for(    int ind_phi = 0   ;  ind_phi < phi_sz  ;  ++ind_phi  ){

                    double tmp = snr( amp[ind_amp] , phi[ind_phi] , tcvt[quant] , tsig[sig] );
                    tmp*=sym(amp[ind_amp] , phi[ind_phi] , tcvt[quant] , tsig[sig] );

                    if( tmp > res[sig].vsnr ){
                        res[sig].vsnr=tmp;
                        res[sig].amp=amp[ind_amp];
                        res[sig].phi=phi[ind_phi];
                        res[sig].ind_win=quant;
                    }
                    
                }
            }
        }
    }

    double ssig[n_sz];
    for(int i=0;i<n_sz;++i){
        ssig[i]=tcvt[res[0].ind_win](f_cos(res[0].amp,res[0].phi,i));
    }
    double sssig[n_sz];
    for(int i=0;i<n_sz;++i){
        sssig[i]=tcvt[res[1].ind_win](f_saw(res[0].amp,res[0].phi,i));
        printf("%lf\n",sssig[i]*pow(2.0,7.0));
    }

    for(int i=0;i<2;++i){
        printf("amp: %lf\t\tphase: %lf\n",res[i].amp,res[i].phi);
    }
    return EXIT_SUCCESS;




}