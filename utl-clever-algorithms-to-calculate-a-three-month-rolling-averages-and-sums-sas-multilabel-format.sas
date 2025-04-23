%let pgm=utl-clever-algorithms-to-calculate-a-three-month-rolling-averages-and-sums-sas-multilabel-format;

%stop_submission;

Clever algorithms to calculate a three month rolling averages and sums sas multilabel format

        CONTENTS

            1 sas multilabel
            2 r zoo language
            3 r python excel sql
              for python & excel see
              https://tinyurl.com/4e6yaap8 (same code)

github
https://tinyurl.com/y939f4x8
https://github.com/rogerjdeangelis/utl-clever-algorithms-to-calculate-a-three-month-rolling-averages-and-sums-sas-multilabel-format

github
https://tinyurl.com/bdetys6h
https://communities.sas.com/t5/SAS-Programming/Computing-moving-average-by-group-and-year/m-p/825266#M325961

/**************************************************************************************************************************/
/*   INPUT               |       PROCESS                     |      OUTPUT                                                */
/*   =====               |       ======                      |      ======                                                */
/*                       |                                   |                                                            */
/*                       |                 ROLLING           |                                                            */
/*                       |                 THREE             |                                                            */
/*                       |                 MONTHS            |                   VALUE_    VALUE_                         */
/* MONTH    VALUE        | MONTH    VALUE  SUM               |  MONTH    NOBS     MEAN       SUM                          */
/*                       |                                   |                                                            */
/*    1       11         |    1       11 -                   |  01-03      3       12        36                           */
/*    2       12         |    2       12  |- 11+12+23 36     |  02-04      3       13        39                           */
/*    3       13         |    3       13 - | 12+13+24 39     |  03-05      3       14        42                           */
/*    4       14         |    4       14   -                 |  04-06      3       15        45                           */
/*    5       15         |    5       15                     |  05-07      3       16        48                           */
/*    6       16         |    6       16                     |  06-08      3       17        51                           */
/*    7       17         |    7       17                     |  07-09      3       18        54                           */
/*    8       18         |    8       18                     |  08-10      3       19        57                           */
/*    9       19         |    9       19                     |  09-11      3       20        60                           */
/*   10       20         |   10       20                     |  10-12      3       21        63                           */
/*   11       21         |   11       21                     |                                                            */
/*   12       22         |   12       22                     |                                                            */
/*                       |                                   |                                                            */
/* data have;            |                                   |                                                            */
/*   input month value;  | 1 SAS MULTILABEL                  |                                                            */
/* cards4;               | ================                  |                   VALUE_    VALUE_                         */
/* 01 11                 |                                   |  MONTH    NOBS     MEAN       SUM                          */
/* 02 12                 | proc format;                      |                                                            */
/* 03 13                 |  value roltre (multilabel)        |  01-03      3       12        36                           */
/* 04 14                 |   1-3   = "01-03"                 |  02-04      3       13        39                           */
/* 05 15                 |   2-4   = "02-04"                 |  03-05      3       14        42                           */
/* 06 16                 |   3-5   = "03-05"                 |  04-06      3       15        45                           */
/* 07 17                 |   4-6   = "04-06"                 |  05-07      3       16        48                           */
/* 08 18                 |   5-7   = "05-07"                 |  06-08      3       17        51                           */
/* 09 19                 |   6-8   = "06-08"                 |  07-09      3       18        54                           */
/* 10 20                 |   7-9   = "07-09"                 |  08-10      3       19        57                           */
/* 11 21                 |   8-10  = "08-10"                 |  09-11      3       20        60                           */
/* 12 22                 |   9-11  = "09-11"                 |  10-12      3       21        63                           */
/* ;;;;                  |  10-12  = "10-12"                 |                                                            */
/* run;quit;             | ;                                 |                                                            */
/*                       | run;quit;                         |                                                            */
/*                       |                                   |                                                            */
/*                       | ods output summary=want ;         |                                                            */
/*                       | proc means data=have              |                                                            */
/*                       |  nway mean sum ;                  |                                                            */
/*                       |   class month / mlf;              |                                                            */
/*                       |   var value;                      |                                                            */
/*                       |   format month roltre.;           |                                                            */
/*                       | run;quit;                         |                                                            */
/*                       |                                   |                                                            */
/*                       | ----------------------------------|------------------------------------------------------------*/
/*                       |                                   |                                                            */
/*                       | 2 R ZOO LANGUAGE                  | R                                                          */
/*                       | ================                  |                                                            */
/*                       |                                   | MONTH VALUE  sum3 mean3                                    */
/*                       | %utl_rbeginx;                     |                                                            */
/*                       | parmcards4;                       |     3    13    36    12                                    */
/*                       | library(haven)                    |     4    14    39    13                                    */
/*                       | library(zoo)                      |     5    15    42    14                                    */
/*                       | source("c:/oto/fn_tosas9x.R")     |     6    16    45    15                                    */
/*                       | have<-read_sas(                   |     7    17    48    16                                    */
/*                       |  "d:/sd1/have.sas7bdat")          |     8    18    51    17                                    */
/*                       |                                   |     9    19    54    18                                    */
/*                       | have$sum3 <- rollsum(             |    10    20    57    19                                    */
/*                       |    have$VALUE                     |    11    21    60    20                                    */
/*                       |    ,k = 3                         |    12    22    63    21                                    */
/*                       |    ,fill = NA                     |                                                            */
/*                       |    ,align = "right")              | SAS                                                        */
/*                       |                                   |                                                            */
/*                       | have$mean3 <- rollmean(           | ROWNAMES    MONTH    VALUE    SUM3    MEAN3                */
/*                       |    have$VALUE                     |                                                            */
/*                       |    ,k = 3                         |     1          3       13      36       12                 */
/*                       |    ,fill = NA                     |     2          4       14      39       13                 */
/*                       |    ,align = "right")              |     3          5       15      42       14                 */
/*                       | want<-have[3:12,]                 |     4          6       16      45       15                 */
/*                       | want                              |     5          7       17      48       16                 */
/*                       | fn_tosas9x(                       |     6          8       18      51       17                 */
/*                       |       inp    = want               |     7          9       19      54       18                 */
/*                       |      ,outlib ="d:/sd1/"           |     8         10       20      57       19                 */
/*                       |      ,outdsn ="want"              |     9         11       21      60       20                 */
/*                       |      )                            |    10         12       22      63       21                 */
/*                       | ;;;;                              |                                                            */
/*                       | %utl_rendx;                       |                                                            */
/*                       |                                   |                                                            */
/*                       | proc print data=sd1.want;         |                                                            */
/*                       | run;quit;                         |                                                            */
/*                       |                                   |                                                            */
/*                       | ----------------------------------|------------------------------------------------------------*/
/*                       |                                   |                                                            */
/*                       | 3 R PYTHON EXCEL SQL              | R                                                          */
/*                       |   for python & excel see          |                                                            */
/*                       |   https://tinyurl.com/4e6yaap8    | MONTH VALUE  sum3 mean3                                    */
/*                       |                                   |                                                            */
/*                       | %utl_rbeginx;                     |     3    13    36    12                                    */
/*                       | parmcards4;                       |     4    14    39    13                                    */
/*                       | library(haven)                    |     5    15    42    14                                    */
/*                       | library(sqldf)                    |     6    16    45    15                                    */
/*                       | source("c:/oto/fn_tosas9x.R")     |     7    17    48    16                                    */
/*                       | have<-read_sas(                   |     8    18    51    17                                    */
/*                       |  "d:/sd1/have.sas7bdat")          |     9    19    54    18                                    */
/*                       | have                              |    10    20    57    19                                    */
/*                       | want<-sqldf("                     |    11    21    60    20                                    */
/*                       | select                            |    12    22    63    21                                    */
/*                       |     month                         |                                                            */
/*                       |    ,value                         | SAS                                                        */
/*                       |    ,avg(value) over (             |                                                            */
/*                       |         order by month            | ROWNAMES    MONTH    VALUE    SUM3    MEAN3                */
/*                       |         rows between 2 preceding  |                                                            */
/*                       |            and current row        |     1          3       13      36       12                 */
/*                       |     ) as mean3                    |     2          4       14      39       13                 */
/*                       |    ,sum(value) over (             |     3          5       15      42       14                 */
/*                       |         order by month            |     4          6       16      45       15                 */
/*                       |         rows between 2 preceding  |     5          7       17      48       16                 */
/*                       |           and current row         |     6          8       18      51       17                 */
/*                       |     ) as mean3                    |     7          9       19      54       18                 */
/*                       | from have                         |     8         10       20      57       19                 */
/*                       | order by month                    |     9         11       21      60       20                 */
/*                       | ")[3:12,]                         |    10         12       22      63       21                 */
/*                       | want                              |                                                            */
/*                       | fn_tosas9x(                       |                                                            */
/*                       |       inp    = want               |                                                            */
/*                       |      ,outlib ="d:/sd1/"           |                                                            */
/*                       |      ,outdsn ="want"              |                                                            */
/*                       |      )                            |                                                            */
/*                       | ;;;;                              |                                                            */
/*                       | %utl_rendx;                       |                                                            */
/*                       |                                   |                                                            */
/*                       | proc print data=sd1.want;         |                                                            */
/*                       | run;quit;                         |                                                            */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

data have;
  input month value;
cards4;
01 11
02 12
03 13
04 14
05 15
06 16
07 17
08 18
09 19
10 20
11 21
12 22
;;;;
run;quit;

/**************************************************************************************************************************/
/* MONTH    VALUE                                                                                                         */
/*                                                                                                                        */
/*    1       11                                                                                                          */
/*    2       12                                                                                                          */
/*    3       13                                                                                                          */
/*    4       14                                                                                                          */
/*    5       15                                                                                                          */
/*    6       16                                                                                                          */
/*    7       17                                                                                                          */
/*    8       18                                                                                                          */
/*    9       19                                                                                                          */
/*   10       20                                                                                                          */
/*   11       21                                                                                                          */
/*   12       22                                                                                                          */
/**************************************************************************************************************************/

/*                                   _ _   _ _       _          _
/ |  ___  __ _ ___   _ __ ___  _   _| | |_(_) | __ _| |__   ___| |
| | / __|/ _` / __| | `_ ` _ \| | | | | __| | |/ _` | `_ \ / _ \ |
| | \__ \ (_| \__ \ | | | | | | |_| | | |_| | | (_| | |_) |  __/ |
|_| |___/\__,_|___/ |_| |_| |_|\__,_|_|\__|_|_|\__,_|_.__/ \___|_|

*/

proc format;
 value roltre (multilabel)
  1-3   = "01-03"
  2-4   = "02-04"
  3-5   = "03-05"
  4-6   = "04-06"
  5-7   = "05-07"
  6-8   = "06-08"
  7-9   = "07-09"
  8-10  = "08-10"
  9-11  = "09-11"
 10-12  = "10-12"
;
run;quit;

ods output summary=want ;
proc means data=have
 nway mean sum ;
  class month / mlf;
  var value;
  format month roltre.;
run;quit;

/**************************************************************************************************************************/
/*                         VALUE_    VALUE_                                                                               */
/* Obs    MONTH    NOBS     MEAN       SUM                                                                                */
/*                                                                                                                        */
/*   1    01-03      3       12        36                                                                                 */
/*   2    02-04      3       13        39                                                                                 */
/*   3    03-05      3       14        42                                                                                 */
/*   4    04-06      3       15        45                                                                                 */
/*   5    05-07      3       16        48                                                                                 */
/*   6    06-08      3       17        51                                                                                 */
/*   7    07-09      3       18        54                                                                                 */
/*   8    08-10      3       19        57                                                                                 */
/*   9    09-11      3       20        60                                                                                 */
/*  10    10-12      3       21        63                                                                                 */
/**************************************************************************************************************************/

/*___                            _
|___ \   _ __   _______   ___   | | __ _ _ __   __ _ _   _  __ _  __ _  ___
  __) | | `__| |_  / _ \ / _ \  | |/ _` | `_ \ / _` | | | |/ _` |/ _` |/ _ \
 / __/  | |     / / (_) | (_) | | | (_| | | | | (_| | |_| | (_| | (_| |  __/
|_____| |_|    /___\___/ \___/  |_|\__,_|_| |_|\__, |\__,_|\__,_|\__, |\___|
                                               |___/             |___/
*/

%utl_rbeginx;
parmcards4;
library(haven)
library(zoo)
source("c:/oto/fn_tosas9x.R")
have<-read_sas(
 "d:/sd1/have.sas7bdat")

have$sum3 <- rollsum(
   have$VALUE
   ,k = 3
   ,fill = NA
   ,align = "right")

have$mean3 <- rollmean(
   have$VALUE
   ,k = 3
   ,fill = NA
   ,align = "right")
want<-have[3:12,]
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/* R                        | SAS                                                                                         */
/* MONTH VALUE  sum3 mean3  | ROWNAMES    MONTH    VALUE    SUM3    MEAN3                                                 */
/*                          |                                                                                             */
/*     3    13    36    12  |     1          3       13      36       12                                                  */
/*     4    14    39    13  |     2          4       14      39       13                                                  */
/*     5    15    42    14  |     3          5       15      42       14                                                  */
/*     6    16    45    15  |     4          6       16      45       15                                                  */
/*     7    17    48    16  |     5          7       17      48       16                                                  */
/*     8    18    51    17  |     6          8       18      51       17                                                  */
/*     9    19    54    18  |     7          9       19      54       18                                                  */
/*    10    20    57    19  |     8         10       20      57       19                                                  */
/*    11    21    60    20  |     9         11       21      60       20                                                  */
/*    12    22    63    21  |    10         12       22      63       21                                                  */
/**************************************************************************************************************************/

/*____                      _   _                                     _            _
|___ /   _ __   _ __  _   _| |_| |__   ___  _ __     _____  _____ ___| | ___  __ _| |
  |_ \  | `__| | `_ \| | | | __| `_ \ / _ \| `_ \   / _ \ \/ / __/ _ \ |/ __|/ _` | |
 ___) | | |    | |_) | |_| | |_| | | | (_) | | | | |  __/>  < (_|  __/ |\__ \ (_| | |
|____/  |_|    | .__/ \__, |\__|_| |_|\___/|_| |_|  \___/_/\_\___\___|_||___/\__, |_|
               |_|    |___/                                                     |_|

*/

%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
have<-read_sas(
 "d:/sd1/have.sas7bdat")
have
want<-sqldf("
select
    month
   ,value
   ,avg(value) over (
        order by month
        rows between 2 preceding
           and current row
    ) as mean3
   ,sum(value) over (
        order by month
        rows between 2 preceding
          and current row
    ) as mean3
from have
order by month
")[3:12,]
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="rwant"
     )
;;;;
%utl_rendx;

proc print data=sd1.rwant;
run;quit;

/**************************************************************************************************************************/
/* R                        | SAS                                                                                         */
/* MONTH VALUE  sum3 mean3  | ROWNAMES    MONTH    VALUE    SUM3    MEAN3                                                 */
/*                          |                                                                                             */
/*     3    13    36    12  |     1          3       13      36       12                                                  */
/*     4    14    39    13  |     2          4       14      39       13                                                  */
/*     5    15    42    14  |     3          5       15      42       14                                                  */
/*     6    16    45    15  |     4          6       16      45       15                                                  */
/*     7    17    48    16  |     5          7       17      48       16                                                  */
/*     8    18    51    17  |     6          8       18      51       17                                                  */
/*     9    19    54    18  |     7          9       19      54       18                                                  */
/*    10    20    57    19  |     8         10       20      57       19                                                  */
/*    11    21    60    20  |     9         11       21      60       20                                                  */
/*    12    22    63    21  |    10         12       22      63       21                                                  */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
