#!/afs/isis/pkg/perl/bin/perl
use Net::SMTP;
# SEND MAIL SCRIPT 

#$mailprog = 'sendmail';
$nr = "no_reply\@email.unc.edu";
$cgiurl = "index.pl";  # un-rem for production
#$cgiurl = "http://www.unc.edu/usr-bin/dcayers/LS/CAL/TEST/leaveX.pl"; # rem for production
$attachment = 'leave.ics'; # un-rem for production
my $boundary = 'frontier';
open(DAT, $attachment) || die("Could not open text file!");
my @textFile = <DAT>;
close(DAT);
#$attachment = 'leaveX.ics'; # rem for production

    open TMP, "<", "tempinfo.txt"; # un-rem for production
	#open TMP, "<", "tempinfoX.txt"; # rem for production
    @fields = <TMP>;
    close TMP;
   $fields[5] =~ s/T/ /;
   $fields[6] =~ s/T/ /;
   chomp ($fields[3]);
   chomp ($fields[4]);
   $super = $fields[3];
   if ($fields[4]){
   
   #email to requester
my $smtp = Net::SMTP->new('relay.unc.edu') or die $!;
$smtp->mail( $super );
$smtp->to( $fields[4] );
$smtp->data();
$smtp->datasend("To: $fields[4]\n");
$smtp->datasend("From: $super\n");
$smtp->datasend("Subject: LEAVE REQUEST - FOR YOUR RECORDS\n");
$smtp->datasend("\n"); # done with header

$smtp->datasend("MIME-Version: 1.0\n");

$smtp->datasend("Content-Disposition: attachment; filename=\$attachment\n");

$smtp->datasend("Content-Type: application/text; name= leave.ics ");

$smtp->datasend();

$smtp->datasend("DOUBLE CLICK ON ATTACHMENT TO ADD EVENT TO OUTLOOK CALENDAR\n\n");
$smtp->dataend();
$smtp->quit(); # all done. message sent.

   #open (MAIL, "|$mailprog $fields[4]") || die "Can't open $mailprog!\n";
   #print MAIL "Reply-to: $super\n";
   #print MAIL "From: $super\n";
   #print MAIL "To: $fields[4]\n";
   #print MAIL "Subject: LEAVE REQUEST - FOR YOUR RECORDS\n\n";
   #print MAIL "DOUBLE CLICK ON ATTACHMENT TO ADD EVENT TO OUTLOOK CALENDAR\n\n";
   #print MAIL "ENTERED: $fields[0]\n";
   #print MAIL "PID: $fields[1]\n";
   #print MAIL "NAME: $fields[2]\n";
   #print MAIL "BEGIN: $fields[5]\n";
   #print MAIL "END: $fields[6]\n";
   #print MAIL "TYPE: $fields[7]\n";
   #print MAIL "COMMENTS: $fields[8]\n";
   #open(FILE, "uuencode $attachment $attachment|");
   #while( <FILE> ) { print MAIL; };
   #close(FILE);
   #close (MAIL);
   }
   else {
   $fields[4] = $nr;
   }
   #email to supervisor
   my $smtp = Net::SMTP->new('relay.unc.edu') or die $!;
$smtp->mail( $fields[4] );
$smtp->to( "dwayne\@n4mio.com" );
$smtp->data();
$smtp->datasend("To: dwayne\@n4mio.com\n");
$smtp->datasend("From: $fields[4]\n");
$smtp->datasend("Subject: $fields[2] / $fields[5] to $fields[6] / $fields[7]\n\n");
$smtp->datasend("\n"); # done with header
$smtp->datasend("DOUBLE CLICK ON ATTACHMENT TO ADD EVENT TO OUTLOOK CALENDAR\n\n");
$smtp->dataend();
$smtp->quit(); # all done. message sent.


   #open (MAIL, "|$mailprog $super") || die "Can't open $mailprog!\n";
   #print MAIL "Reply-to: $fields[4]\n";
   #print MAIL "From: $fields[4]\n";
   #print MAIL "To: $super\n";
   #print MAIL "Subject: $fields[2] / $fields[5] to $fields[6] / $fields[7]\n\n";
   #print MAIL "DOUBLE CLICK ON ATTACHMENT TO ADD EVENT TO OUTLOOK CALENDAR\n\n";
   #print MAIL "ENTERED: $fields[0]\n";
   #print MAIL "PID: $fields[1]\n";
   #print MAIL "NAME: $fields[2]\n";
   #print MAIL "BEGIN: $fields[5]\n";
   #print MAIL "END: $fields[6]\n";
   #print MAIL "TYPE: $fields[7]\n";
   #print MAIL "COMMENTS: $fields[8]\n";
   #open(FILE, "uuencode $attachment $attachment|");
   #while( <FILE> ) { print MAIL; };
   #close(FILE);
   #close (MAIL);
   
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
