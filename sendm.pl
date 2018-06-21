#!/afs/isis/pkg/perl/bin/perl
use warnings;
use Mail::Sendmail;

# SEND MAIL SCRIPT 

#$mailprog = 'sendmail';
#$nr = "no_reply\@email.unc.edu";
$cgiurl = "index.pl";  # un-rem for production
#$cgiurl = "http://www.unc.edu/usr-bin/dcayers/LS/CAL/TEST/leaveX.pl"; # rem for production
#$attachment = 'leave.ics'; # un-rem for production
#$attachment = 'leaveX.ics'; # rem for production

    open TMP, "<", "tempinfo.txt" || die "Can't open tempinfo.txt\n"; # un-rem for production
	#open TMP, "<", "tempinfoX.txt"; # rem for production
    @fields = <TMP>;
    close TMP;
   $fields[5] =~ s/T/ /;
   $fields[6] =~ s/T/ /;
   chomp ($fields[3]);
   chomp ($fields[4]);
   $super = $fields[3];
   
    my %mail = ( To      => $fields[4],
            From    => $super,
            Message => "This is a very short message"
           );

  sendmail(%mail) or die $Mail::Sendmail::error;

  print "OK. Log says:\n", $Mail::Sendmail::log;
         
   print "Content-type: text/html\n\n";
   print "<html><head><title>LEAVE REQUEST SENT</title></head>\n";
   print "<body><FONT SIZE = 5><b>LEAVE REQUEST SENT</b></FONT><br><br>";
   print "<FONT SIZE = 4><b>ENTERED:</b>\&nbsp\;\&nbsp\; $fields[0]<br><br>";
   print "<b>PID:</b>  $fields[1]<br><br>";
   print "<b>NAME:</b>  $fields[2]<br><br>";
   print "<b>BEGIN:</b>  $fields[5]<br><br>";
   print "<b>END:</b>  $fields[6]<br><br>";
   print "<b>TYPE:</b>  $fields[7]<br><br>";
   print "<b>COMMENTS:</b>  $fields[8]<br><br>";
   print "<a href=\"$cgiurl\">ENTER ANOTHER REQUEST</a><br><br>\n";
   print "</body></html>\n";
   exit;
