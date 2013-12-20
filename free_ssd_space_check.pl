#!/usr/local/bin/perl
##
#
# We had a small crisis when our SSD pool filled up and caused
# some problems on our prod cluster.  Since this data isn't exposed
# in isilon SNMP implementation, we worked with their Support team
# which helped us find the right way to show this space.
#
# isiprod01-1# perl /ifs/data/scripts/free_ssd_space_check.pl
# free_ssd_blocks :: 696097467 total_ssd_blocks :: 866908404 :: percent_used :: 19.70
# isiprod01-1#
#
# Some graphing tools perfer raw numbers.  Just uncomment the free or total
# if your stats db wants to do the math on its own, or track the two values
# in different places.
# 
##
my $total_blocks = `sysctl efs.bam.layout.ssd.total_ssd_blocks`;
my $free_blocks = `sysctl efs.bam.layout.ssd.free_ssd_blocks`;

my @total_array  = split(/\s+/, $total_blocks);
my @free_array  = split(/\s+/, $free_blocks);

my $free = "$free_array[1]";
my $total = "$total_array[1]";

## print "$free\n";
## print "$total\n";

my $space_percent = (($total - $free) / $total)*100;

printf "free_ssd_blocks :: $free total_ssd_blocks :: $total :: percent_used :: %2.2f\n", $space_percent;
