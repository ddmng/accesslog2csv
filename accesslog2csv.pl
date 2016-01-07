#!/usr/bin/perl

# 
# @file
# Converter tool, from Apache Common Log file to CSV.
# 
# All code is released under the GNU General Public License.
# See COPYRIGHT.txt and LICENSE.txt.
#

if ("$ARGV[0]" =~ /^-h|--help$/) {
  print "Usage: $0 access_log_file > csv_output_file.csv\n";
  print "   Or, $0 < access_log_file > csv_output_file.csv\n";
  print "   Or, $0 < access_log_file > csv_output_file.csv 2> invalid_lines.txt\n";
  exit(0);
}

%MONTHS = ( 'Jan' => '01', 'Feb' => '02', 'Mar' => '03', 'Apr' => '04', 'May' => '05', 'Jun' => '06',
  'Jul' => '07', 'Aug' => '08', 'Sep' => '09', 'Oct' => '10', 'Nov' => '11', 'Dec' => '12' );

print STDOUT "\"Host\",\"Log Name\",\"Date Time\",\"Time Zone\",\"Method\",\"URL\",\"Response Code\",\"Bytes Sent\",\"Referer\",\"User Agent\"\n";
$line_no = 0;

while (<>) {
  ++$line_no;
  if (/^([\w\.:-]+)\s+([\w\.:-]+)\s+([\w\.-]+)\s+\[(\d+)\/(\w+)\/(\d+):(\d+):(\d+):(\d+)\s?([\w:\+-]+)]\s+"(\w+)\s+(\S+)\s+HTTP\/1\.\d"\s+(\d+)\s+([\d-]+)((\s+"([^"]+)"\s+")?([^"]+)")?$/) {
    $host = $1;
    $other = $2;
    $logname = $3;
    $day = $4;
    $month = $MONTHS{$5};
    $year = $6;
    $hour = $7;
    $min = $8;
    $sec = $9;
    $tz = $10;
    $method = $11;
    $url = $12;
    $code = $13;
    if ($14 eq '-') {
      $bytesd = 0;
    } else {
      $bytesd = $14;
    }
    $referer = $17;
    $ua = $18;

    print STDOUT "\"$host\",\"$logname\",\"$year-$month-$day $hour:$min:$sec\",\"GMT$tz\",\"$method\",\"$url\",$code,$bytesd,\"$referer\"\,\"$ua\"\n";
  } else {
    if (/^([\w\.:-]+),\s*([\w\.:-]+),\s*([\w\.:-]+)\s*([\w\.:-]+)\s+([\w\.-]+)\s+\[(\d+)\/(\w+)\/(\d+):(\d+):(\d+):(\d+)\s?([\w:\+-]+)]\s+"(\w+)\s+(\S+)\s+HTTP\/1\.\d"\s+(\d+)\s+([\d-]+)((\s+"([^"]+)"\s+")?([^"]+)")?$/) {
      $host1 = $1;
      $host2 = $2;
      $host3 = $3;
      $other = $4;
      $logname = $5;
      $day = $6;
      $month = $MONTHS{$7};
      $year = $8;
      $hour = $9;
      $min = $10;
      $sec = $11;
      $tz = $12;
      $method = $13;
      $url = $14;
      $code = $15;
      if ($16 eq '-') {
        $bytesd = 0;
      } else {
        $bytesd = $16;
      }
      $referer = $19;
      $ua = $20;

      print STDOUT "\"$host1\",\"$logname\",\"$year-$month-$day $hour:$min:$sec\",\"GMT$tz\",\"$method\",\"$url\",$code,$bytesd,\"$referer\"\,\"$ua\"\n";
      print STDOUT "\"$host2\",\"$logname\",\"$year-$month-$day $hour:$min:$sec\",\"GMT$tz\",\"$method\",\"$url\",$code,$bytesd,\"$referer\"\,\"$ua\"\n";
      print STDOUT "\"$host3\",\"$logname\",\"$year-$month-$day $hour:$min:$sec\",\"GMT$tz\",\"$method\",\"$url\",$code,$bytesd,\"$referer\"\,\"$ua\"\n";
    } else {
          if (/^([\w\.:-]+),\s*([\w\.:-]+)\s*([\w\.:-]+)\s+([\w\.-]+)\s+\[(\d+)\/(\w+)\/(\d+):(\d+):(\d+):(\d+)\s?([\w:\+-]+)]\s+"(\w+)\s+(\S+)\s+HTTP\/1\.\d"\s+(\d+)\s+([\d-]+)((\s+"([^"]+)"\s+")?([^"]+)")?$/) {
      $host1 = $1;
      $host2 = $2;
      $other = $3;
      $logname = $4;
      $day = $5;
      $month = $MONTHS{$6};
      $year = $7;
      $hour = $8;
      $min = $9;
      $sec = $10;
      $tz = $11;
      $method = $12;
      $url = $13;
      $code = $14;
      if ($15 eq '-') {
        $bytesd = 0;
      } else {
        $bytesd = $15;
      }
      $referer = $18;
      $ua = $19;

      print STDOUT "\"$host1\",\"$logname\",\"$year-$month-$day $hour:$min:$sec\",\"GMT$tz\",\"$method\",\"$url\",$code,$bytesd,\"$referer\"\,\"$ua\"\n";
      print STDOUT "\"$host2\",\"$logname\",\"$year-$month-$day $hour:$min:$sec\",\"GMT$tz\",\"$method\",\"$url\",$code,$bytesd,\"$referer\"\,\"$ua\"\n";
    } else {
      print STDERR "Invalid Line at $line_no: $_";
    }
    }
  } 
}


