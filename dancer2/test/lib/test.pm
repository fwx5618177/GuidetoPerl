package test;

use Dancer2;
use  Net::SSH2;
use  Data::Dumper;

our $VERSION = '0.1';

my  $envMon  = {
     NST => {
         '192.168.1.100'  => [  'user' ,  'passwd', 'port'  ],
         '192.168.1.101'  => [  'user' ,  'passwd', 'port'  ],
           '192.168.1.102'  => [  'user' , 'passwd', 'port' ],
    },
};

sub  mon {
     my  (  $host ,  $user ,  $passwd ,  $env  ) =  @_ ;
     my  @monArr ;
     my  $monOut ;
     my  $ssh2  = Net::SSH2->new();
     my  $row ;

     $ssh2 -> connect ( "$host" ) or  die  "$!" ;
     if  (  $ssh2 ->auth_password(  "$user" ,  "$passwd"  ) ) {
         my  $chan  =  $ssh2 ->channel();
         # $chan->blocking(1);
         $chan ->shell();
         
         #monitor memory useage 这款是监控内存,因为linux/unix内存机制都是有多少用多少,所以就去掉了
         print $chan "svmon -G\n";
         #
         # while(<$chan>){
         # if(/^memory\s+([\d.]+)\s+([\d.]+)\s+([\d.]+)/){
         # push @{$monOut->{'memory'}},sprintf"%0.2f",$2/$1*100;
         # }
         #}

         #monitor disk data

         print  $chan  "df -g\n" ;

         while  (< $chan >) {
             if  (/^\S+\s+([\d.]+)\s+([\d.]+)\s+(\d+)%\s+[^\/]+(\S+)$/) {
                 # push @monArr, $3, $1, $2;
                 if  ( $3 > 80 ) {
                     push  @{  $monOut ->{ 'disk' } }, $4, $1, $2,
                         '<div class="jindu_r"><div style="width:'
                       . $3 .  '%">'
                       . $3
                       .  '%</div></div>' ;
                     ++ $row ;
                 }
        #以下是根据自己需要,如果想监控所有硬盘就去掉注释,我这块只监控大于80%已用空间
         #else{
         # push @{$monOut->{'disk'}},$4,$1,$2,
         # '<div class="jindu_g"><div style="width:'.$3.'%">'.$3.'%</div></div>';
         #}
             }
         }

         unless  (  @{  $monOut ->{ 'disk' } } ) {
             push  @{  $monOut ->{ 'disk' } },  'normal' ,  'normal' ,  'normal' ,  'normal' ;
             $row  = 1;
         }

         # monitor cpu data
         print  $chan  "iostat\n" ;
         while  (< $chan >) {
             if  (/^\s+\S+\s+\S+\s+(\S+)\s+(\S+)\s+(\S+)\s+([\d.]+)/) {
                 push  @{  $monOut ->{ 'cpu' } }, $1, $2, $3, $4;
             }
         }

         $monOut ->{ 'ip' } =  $host ;
         $monOut ->{ 'env' } =  $env ;
         $monOut ->{ 'row' } =  $row ;
     }
     $monOut ;
}

get '/' => sub {
    # template 'index' => { 'title' => 'test' };
    return 'hi';
};

get '/env' => sub {
    my  $monitorOut ;
         my  $env  = params->{env};
         $env  =  uc ( $env );
         if  (  $envMon ->{ $env } ) {
             for  (  keys  %{  $envMon ->{ $env } } ) {
                 push  @ $monitorOut ,
                   mon(
                     $_ ,
                     $envMon ->{ $env }->{ $_ }[0],
                     $envMon ->{ $env }->{ $_ }[1],  $env
                   );
             }
       

        print $monitorOut;
             return  $monitorOut;
         }
};

true;
